"""Stage-aware simulation of clinical cases from the knowledge base.

Why simulate?  There is no labelled patient dataset (yet).  The ML model is
therefore trained on synthetic cases drawn from the KB, but - unlike the rule
engine, which treats every sign as independent - the simulator adds structure
that real patients have:

* disease STAGE (preclinical / early / advanced) changes which signs appear
  (congestion only late, murmurs from the start...),
* signs of the same physiological GROUP are correlated through a latent
  severity factor (a patient with a lot of cough tends also to have
  tachypnea),
* parent/child consistency (a murmur location implies a murmur),
* observer error (owners miss signs / over-report),
* incomplete interviews (only a part of the signs is ever answered).

The ML model learns these patterns; the rule engine does not.  Both are
therefore genuinely different "opinions" about the same case.
NOTE: because the data are generated from the KB, the ML model can never know
more than the KB. Real validation needs real cases (see evaluation/README).
"""
from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Dict, List, Optional

import numpy as np

from .kb import KnowledgeBase, NC_ID

RHO = 0.9  # strength of the latent group-severity correlation (logit scale)


@dataclass
class Case:
    species: str
    age_group: str
    breed_group: str
    audience: str
    label: str
    truth: Dict[str, bool]
    answers: Dict[str, str]


def _logit(p):
    p = min(0.995, max(0.003, p))
    return math.log(p / (1 - p))


def _sigmoid(x):
    return 1.0 / (1.0 + math.exp(-x))


class Simulator:
    def __init__(self, kb: KnowledgeBase, seed: int = 0):
        self.kb = kb
        self.rng = np.random.default_rng(seed)
        mult = kb.settings["stage_group_multipliers"]
        self.stages = kb.settings["stages"]
        self.mult = mult
        self.ml = kb.settings["ml"]
        # sample-species shares per class (min 12 % for any valid species)
        self.species_share: Dict[str, Dict[str, float]] = {}
        for c in kb.classes:
            if c == NC_ID:
                self.species_share[c] = {sp: 1.0 / len(kb.species_ids) for sp in kb.species_ids}
                continue
            pr = {sp: kb.diseases[c].prior.get(sp, 0.0) for sp in kb.species_ids}
            tot = sum(pr.values())
            sh = {sp: v / tot for sp, v in pr.items()}
            valid = [sp for sp in sh if pr[sp] > 0]
            sh = {sp: (max(sh[sp], 0.12) if sp in valid else 0.0) for sp in sh}
            t = sum(sh.values())
            self.species_share[c] = {sp: v / t for sp, v in sh.items()}

    # ------------------------------------------------------------------
    def _stage_norm(self, d, group):
        w = d.stage_weights
        return sum(w.get(s, 0.0) * self.mult[group][s] for s in self.stages)

    def _true_probs(self, cls: str, species: str, age=None):
        """returns sign -> P(true present) for one concrete case (stage + NC profile sampled)."""
        kb, rng = self.kb, self.rng
        probs = {}
        if cls == NC_ID:
            ws = np.array(kb.nc_profile_weights(species, age))
            k = rng.choice(len(ws), p=ws / ws.sum())
            prof = kb.nc_profiles[k]
            for sid, sg in kb.signs.items():
                probs[sid] = prof["p"].get(sid, kb.nc_leak[sg.level])
            return probs
        d = kb.diseases[cls]
        st = rng.choice(self.stages, p=[d.stage_weights.get(s, 0.0) for s in self.stages])
        for sid, sg in kb.signs.items():
            base = d.p[species][sid]
            norm = self._stage_norm(d, sg.group)
            probs[sid] = base * self.mult[sg.group][st] / norm if norm > 0 else base
        return probs

    def sample_truth(self, cls: str, species: str, age=None) -> Dict[str, bool]:
        kb, rng = self.kb, self.rng
        probs = self._true_probs(cls, species, age)
        z = {g: rng.normal() for g in self.mult}
        truth: Dict[str, bool] = {}
        # parents first so children are conditioned on them
        order = sorted(kb.sign_ids, key=lambda s: 1 if kb.signs[s].parent else 0)
        for sid in order:
            sg = kb.signs[sid]
            p = min(0.985, max(0.001, probs[sid]))
            if sg.parent:
                pp = min(0.985, max(0.001, probs[sg.parent]))
                if not truth[sg.parent]:
                    truth[sid] = False
                    continue
                p = min(0.97, p / max(pp, 1e-6))
            # correlated draw through latent group severity (logit scale, mean-preserving shrink)
            shrink = 1.0 / math.sqrt(1.0 + (math.pi * RHO ** 2) / 8.0)
            eff = _sigmoid((_logit(p) * 1.0) * shrink + RHO * z[sg.group] * 0.6 * (1 if sg.level != "history" else 0))
            truth[sid] = bool(rng.random() < eff)
        # a murmur location implies a murmur
        for sid, sg in kb.signs.items():
            if sg.parent and truth.get(sid) and not truth[sg.parent]:
                truth[sg.parent] = True
        return truth

    def observe(self, truth: Dict[str, bool], audience: str) -> Dict[str, str]:
        kb, rng, ml = self.kb, self.rng, self.ml
        levels = set(kb.allowed_levels(audience))
        lo, hi = ml["completeness_range"]
        comp = rng.uniform(lo, hi)
        answers: Dict[str, str] = {}
        for sid, sg in kb.signs.items():
            if sg.level not in levels:
                continue
            o = kb.observation[sg.level]
            seen = truth[sid]
            if seen and rng.random() < o["miss"]:
                seen = False
            elif (not seen) and rng.random() < o["false_pos"]:
                seen = True
            if seen:
                p_ans = ml["present_answered_prob"] * (0.55 if sg.level == "test" else 1.0)
            else:
                p_ans = comp * (0.45 if sg.level == "test" else 1.0)
            if rng.random() < p_ans:
                answers[sid] = "yes" if seen else "no"
        # parent answered "no" -> children not asked; child yes -> parent yes
        for sid, sg in kb.signs.items():
            if sg.parent:
                if answers.get(sg.parent) == "no" and sid in answers and answers[sid] == "yes":
                    answers[sg.parent] = "yes"
                if answers.get(sid) == "yes" and answers.get(sg.parent) == "no":
                    answers[sg.parent] = "yes"
        return answers

    # ------------------------------------------------------------------
    def sample_case(self, cls: str, audience: Optional[str] = None, realistic: bool = False) -> Case:
        """realistic=True draws age/breed from the class-conditional distribution (for evaluation);
        realistic=False draws them independently of the class (for ML training, so that the
        demographic prior is applied exactly once - by the prior correction at inference)."""
        kb, rng = self.kb, self.rng
        sp_share = self.species_share[cls]
        sps = list(sp_share)
        species = rng.choice(sps, p=[sp_share[s] for s in sps])
        if audience is None:
            mix = self.ml["audience_mix"]
            audience = rng.choice(list(mix), p=list(mix.values()))
        # demographics drawn from class-conditional distribution (only used for evaluation)
        if realistic:
            age, breed = self._demographics(cls, species)
        else:
            age, breed = self._demographics(NC_ID, species)   # population draw, class-independent
        for _ in range(8):
            truth = self.sample_truth(cls, species, age)
            answers = self.observe(truth, audience)
            if any(v == "yes" for v in answers.values()):
                break
        return Case(species, age, breed, audience, cls, truth, answers)

    def _demographics(self, cls: str, species: str):
        kb, rng = self.kb, self.rng
        ages = kb.age_ids
        pop = np.array([kb.settings["age_groups"][a]["population"] for a in ages])
        if cls == NC_ID:
            age = rng.choice(ages, p=pop / pop.sum())
        else:
            m = np.array([kb._age_mult[cls][a] for a in ages])
            w = pop * m
            age = rng.choice(ages, p=w / w.sum())
        bgs = [b for b in kb.breed_groups[species] if b != "unknown"]
        bpop = np.array([kb.breed_groups[species][b]["population"] for b in bgs])
        if cls == NC_ID:
            breed = rng.choice(bgs, p=bpop / bpop.sum())
        else:
            m = np.array([kb._breed_mult[(cls, species)][b] for b in bgs])
            w = bpop * m
            breed = rng.choice(bgs, p=w / w.sum())
        return str(age), str(breed)

    def sample_dataset(self, per_class: int, audience: Optional[str] = None, realistic: bool = False) -> List[Case]:
        out = []
        for c in self.kb.classes:
            for _ in range(per_class):
                out.append(self.sample_case(c, audience, realistic))
        return out
