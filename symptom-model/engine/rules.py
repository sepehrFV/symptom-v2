"""Transparent Bayesian rule engine.

posterior(class | answers) ∝ prior(class | species, age, breed, audience)
                             × Π_answered-signs P(answer | class)

* P(answer | class) comes from the graded expert probabilities in the KB, blurred
  by the observer error rate of the sign level (owner answers are less reliable
  than ECG/echo findings).
* "unknown / don't know" answers are simply skipped - they never count as "no".
* Parent/child signs (murmur -> murmur location) are never double counted.
* A competing "non-cardiac cause" hypothesis stops vague signs from being forced
  into a cardiac diagnosis.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List, Optional

import numpy as np

from .kb import KnowledgeBase, NC_ID

YES, NO, UNKNOWN = "yes", "no", "unknown"


@dataclass
class Context:
    species: str
    age_group: Optional[str] = None
    breed_group: Optional[str] = None
    audience: str = "owner"


def normalise_answers(raw: Dict[str, object]) -> Dict[str, str]:
    """Accepts yes/no/unknown, true/false, 1/2/3 (legacy codes) and returns yes|no."""
    out = {}
    for k, v in (raw or {}).items():
        if isinstance(v, bool):
            out[k] = YES if v else NO
        elif isinstance(v, (int, float)):
            out[k] = {1: YES, 2: NO}.get(int(v), UNKNOWN)
        else:
            s = str(v).strip().lower()
            out[k] = YES if s in ("yes", "y", "true", "1") else NO if s in ("no", "n", "false", "2") else UNKNOWN
    return {k: v for k, v in out.items() if v in (YES, NO)}


def effective_answers(kb: KnowledgeBase, answers: Dict[str, str]) -> Dict[str, str]:
    """Drop parent signs whose children were answered (prevents double counting)."""
    used = {}
    for sid, a in answers.items():
        if sid not in kb.signs:
            continue
        sg = kb.signs[sid]
        if sg.children and any(c in answers for c in sg.children):
            continue
        used[sid] = a
    return used


class RuleEngine:
    def __init__(self, kb: KnowledgeBase):
        self.kb = kb
        n_c, n_s = len(kb.classes), len(kb.sign_ids)
        self.nc_i = kb.class_index[NC_ID]
        self.rep = {}      # (species, age|None) -> (n_c, n_s) P(report yes | class)
        for sp in kb.species_ids:
            base = np.zeros((n_c, n_s))
            for ci, c in enumerate(kb.classes):
                if c == NC_ID:
                    continue
                for si, s in enumerate(kb.sign_ids):
                    base[ci, si] = kb.p_reported(c, sp, s)
            for age in kb.age_ids + [None]:
                m = base.copy()
                for si, s in enumerate(kb.sign_ids):
                    m[self.nc_i, si] = kb.p_reported(NC_ID, sp, s, age)
                self.rep[(sp, age)] = m

    def matrix(self, ctx: "Context") -> np.ndarray:
        return self.rep[(ctx.species, ctx.age_group if ctx.age_group in self.kb.age_ids else None)]

    # ------------------------------------------------------------------
    def prior_vector(self, ctx: Context) -> np.ndarray:
        pr = self.kb.priors(ctx.species, ctx.age_group, ctx.breed_group, ctx.audience)
        return np.array([pr[c] for c in self.kb.classes])

    def log_likelihood(self, ctx: Context, answers: Dict[str, str]) -> np.ndarray:
        used = effective_answers(self.kb, answers)
        m = self.matrix(ctx)
        ll = np.zeros(len(self.kb.classes))
        for sid, a in used.items():
            col = m[:, self.kb.sign_index[sid]]
            ll += np.log(col if a == YES else 1.0 - col)
        return ll

    def posterior(self, ctx: Context, answers: Dict[str, str]) -> np.ndarray:
        prior = self.prior_vector(ctx)
        with np.errstate(divide="ignore"):
            lp = np.log(prior) + self.log_likelihood(ctx, answers)
        lp -= lp.max()
        p = np.exp(lp)
        return p / p.sum()

    # ------------------------------------------------------------------
    def nc_breakdown(self, ctx: Context, answers: Dict[str, str]) -> List[dict]:
        """Which non-cardiac syndromes fit best (shown as 'other causes to consider')."""
        kb = self.kb
        used = effective_answers(kb, answers)
        rows = []
        wts = kb.nc_profile_weights(ctx.species, ctx.age_group)
        for pr, w in zip(kb.nc_profiles, wts):
            if w <= 0:
                continue
            lw = np.log(w)
            for sid, a in used.items():
                sg = kb.signs[sid]
                p = pr["p"].get(sid, kb.nc_leak[sg.level])
                p = kb.blur(min(0.985, max(0.002, p)), sg.level)
                lw += np.log(p if a == YES else 1 - p)
            rows.append((pr, lw))
        mx = max(l for _, l in rows)
        ws = np.array([np.exp(l - mx) for _, l in rows])
        ws = ws / ws.sum()
        out = [{"id": pr["id"], "name_en": pr["name_en"], "name_fa": pr["name_fa"], "share": float(w)}
               for (pr, _), w in zip(rows, ws)]
        return sorted(out, key=lambda r: -r["share"])
