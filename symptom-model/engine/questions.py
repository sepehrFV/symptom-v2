"""Adaptive question selection by expected information gain (bits) per unit cost."""
from __future__ import annotations

from typing import Dict, List, Optional

import numpy as np

from .kb import KnowledgeBase
from .rules import Context, RuleEngine, YES, NO


def _entropy(p: np.ndarray) -> float:
    p = p[p > 1e-12]
    return float(-(p * np.log2(p)).sum())


def eligible_signs(kb: KnowledgeBase, ctx: Context, answers: Dict[str, str],
                   skipped: Optional[set] = None) -> List[str]:
    """Signs that may still be asked for this audience / answer state."""
    levels = set(kb.allowed_levels(ctx.audience))
    skipped = skipped or set()
    out = []
    for sid, sg in kb.signs.items():
        if sid in answers or sid in skipped or sg.level not in levels:
            continue
        # a murmur child is pointless once the parent murmur was answered "no"
        if sg.parent and answers.get(sg.parent) == NO:
            continue
        # a parent is pointless once one of its children was answered
        if sg.children and any(c in answers for c in sg.children):
            continue
        # a clinician who is asked for a murmur location does not need the owner phrasing
        if ctx.audience == "clinician" and sg.children and sg.level == "history":
            pass
        out.append(sid)
    return out


def info_gain(kb: KnowledgeBase, rule: RuleEngine, ctx: Context, post: np.ndarray, sid: str) -> float:
    col = rule.matrix(ctx)[:, kb.sign_index[sid]]
    p_yes = float((post * col).sum())
    if p_yes <= 1e-9 or p_yes >= 1 - 1e-9:
        return 0.0
    post_y = post * col / p_yes
    post_n = post * (1 - col) / (1 - p_yes)
    return _entropy(post) - (p_yes * _entropy(post_y) + (1 - p_yes) * _entropy(post_n))


def rank_questions(kb: KnowledgeBase, rule: RuleEngine, ctx: Context, answers: Dict[str, str],
                   post: np.ndarray, skipped: Optional[set] = None, limit: int = 5) -> List[dict]:
    rows = []
    for sid in eligible_signs(kb, ctx, answers, skipped):
        ig = info_gain(kb, rule, ctx, post, sid)
        cost = kb.cost[kb.signs[sid].level]
        rows.append({"id": sid, "info_gain": ig, "score": ig / cost})
    rows.sort(key=lambda r: -r["score"])
    return rows[:limit]


def question_payload(kb: KnowledgeBase, ctx: Context, row: dict) -> dict:
    sg = kb.signs[row["id"]]
    clin = ctx.audience == "clinician"
    return {
        "id": sg.id, "level": sg.level, "group": sg.group,
        "label_en": sg.en, "label_fa": sg.fa,
        "text_en": (sg.ask_clinician_en if clin and sg.ask_clinician_en else sg.ask_en),
        "text_fa": (sg.ask_clinician_fa if clin and sg.ask_clinician_fa else sg.ask_fa),
        "hint_fa": sg.hint_fa,
        "info_gain_bits": round(row["info_gain"], 4),
    }
