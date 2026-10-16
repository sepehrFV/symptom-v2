"""Orchestrates both engines and produces the response consumed by the Java service / UI."""
from __future__ import annotations

from typing import Dict, List, Optional

import numpy as np

from .kb import KnowledgeBase, NC_ID, load_kb
from .ml import MLEngine, MODEL_FILE
from .questions import eligible_signs, question_payload, rank_questions
from .rules import Context, RuleEngine, effective_answers, normalise_answers, YES, NO

DISCLAIMER_FA = ("این ابزار فقط برای پشتیبانی از تصمیم‌گیری بالینی است و جایگزین معاینه و تشخیص دامپزشک نیست. "
                 "نتیجه بر پایهٔ برآوردهای تخصصی و مدل آماری است و باید با آزمایش‌های تأییدی (اکوکاردیوگرافی، رادیوگرافی، ECG، آزمایش خون) تأیید شود.")
DISCLAIMER_EN = ("Decision-support only - not a diagnosis. Results rest on expert-elicited estimates and a statistical model "
                 "and must be confirmed with a veterinary examination and diagnostic tests (echocardiography, radiographs, ECG, blood work).")

GROUP_LABELS = {
    "left_congestion": ("تنفس و احتقان ریوی", "Breathing / pulmonary congestion"),
    "right_congestion": ("احتقان سمت راست (شکم، ورم)", "Right-sided congestion"),
    "low_output": ("ضعف، غش و کاهش خون‌رسانی", "Weakness / low output"),
    "rhythm": ("ریتم و ضربان", "Rhythm and heart rate"),
    "constitutional": ("علائم عمومی", "General signs"),
    "structural": ("سمع قلب و یافته‌های ساختاری", "Auscultation / structural findings"),
    "systemic": ("علائم سیستمیک و آزمایشگاهی", "Systemic / laboratory"),
    "thrombo": ("اندام‌ها و لخته", "Limbs / thromboembolism"),
    "gi_esophageal": ("بلع و برگشت غذا", "Swallowing / regurgitation"),
    "neuro": ("عصبی", "Neurological"),
    "other": ("سایر", "Other"),
}
LEVEL_LABELS = {
    "owner": ("مشاهدهٔ صاحب حیوان", "Owner-observed"),
    "history": ("سابقه", "History"),
    "exam": ("معاینهٔ بالینی", "Clinical exam"),
    "test": ("آزمایش و تصویربرداری", "Diagnostic test"),
}


def _band(p: float, bands: Dict[str, float]) -> str:
    if p >= bands["high"]:
        return "high"
    if p >= bands["moderate"]:
        return "moderate"
    if p >= bands["low"]:
        return "low"
    return "unlikely"


def _cardiac_band(p: float, bands: Dict[str, float]) -> str:
    if p >= bands["high"]:
        return "high"
    if p >= bands["moderate"]:
        return "moderate"
    if p >= bands["low"]:
        return "low"
    return "very_low"


class DiagnosisService:
    def __init__(self, kb: Optional[KnowledgeBase] = None, ml: Optional[MLEngine] = None, load_ml: bool = True):
        self.kb = kb or load_kb()
        self.rule = RuleEngine(self.kb)
        self.ml = ml if ml is not None else (MLEngine.load(self.kb, MODEL_FILE) if load_ml else None)

    # ------------------------------------------------------------------ meta
    def meta(self) -> dict:
        kb = self.kb
        return {
            "kb_version": kb.version, "kb_hash": kb.hash, "kb_status": kb.settings["status"],
            "ml_available": self.ml is not None,
            "species": [{"id": k, **v} for k, v in kb.settings["species"].items()],
            "age_groups": [{"id": k, **v} for k, v in kb.settings["age_groups"].items()],
            "breed_groups": {sp: [{"id": k, "label_fa": v["label_fa"], "label_en": v["label_en"]}
                                  for k, v in groups.items()] for sp, groups in kb.breed_groups.items()},
            "audiences": list(kb.settings["audiences"].keys()),
            "disclaimer_fa": DISCLAIMER_FA, "disclaimer_en": DISCLAIMER_EN,
        }

    def signs_for(self, audience: str = "owner") -> List[dict]:
        kb = self.kb
        levels = set(kb.allowed_levels(audience))
        out = []
        for sg in kb.signs.values():
            if sg.level not in levels:
                continue
            clin = audience == "clinician"
            out.append({
                "id": sg.id, "level": sg.level, "level_fa": LEVEL_LABELS[sg.level][0], "level_en": LEVEL_LABELS[sg.level][1],
                "group": sg.group, "group_fa": GROUP_LABELS[sg.group][0], "group_en": GROUP_LABELS[sg.group][1],
                "label_fa": sg.fa, "label_en": sg.en,
                "text_fa": sg.ask_clinician_fa if clin and sg.ask_clinician_fa else sg.ask_fa,
                "text_en": sg.ask_clinician_en if clin and sg.ask_clinician_en else sg.ask_en,
                "hint_fa": sg.hint_fa, "parent": sg.parent,
            })
        return out

    def diseases_overview(self) -> List[dict]:
        return [{"id": d.id, "name_en": d.name_en, "name_fa": d.name_fa, "category": d.category,
                 "db_names": d.db_names, "urgency": d.urgency, "status": d.status}
                for d in self.kb.diseases.values()]

    # ------------------------------------------------------------------ main entry
    def diagnose(self, req: dict) -> dict:
        kb = self.kb
        species = (req.get("species") or "").lower()
        age = req.get("age_group") or None
        breed = req.get("breed_group") or None
        if breed == "unknown":
            breed = None
        audience = (req.get("audience") or "owner").lower()
        mode = (req.get("mode") or "combined").lower()
        top_k = int(req.get("top_k") or 5)
        if audience not in kb.settings["audiences"]:
            raise ValueError(f"audience must be one of {list(kb.settings['audiences'])}")
        if mode not in ("combined", "rule", "ai"):
            raise ValueError("mode must be combined | rule | ai")
        kb.validate_context(species, age, breed)
        ctx = Context(species, age, breed, audience)

        raw = req.get("answers") or {}
        unknown_ids = [k for k in raw if k not in kb.signs]
        answers = normalise_answers({k: v for k, v in raw.items() if k in kb.signs})
        asked_ids = set(k for k in raw if k in kb.signs)
        initial = set(req.get("initial") or [])
        warnings: List[dict] = []
        if unknown_ids:
            warnings.append({"code": "unknown_signs", "ids": unknown_ids,
                             "fa": "برخی علائم ناشناخته نادیده گرفته شد.", "en": "Some unknown sign ids were ignored."})

        prior = self.rule.prior_vector(ctx)
        p_rule = self.rule.posterior(ctx, answers)
        p_ml = None
        if mode in ("combined", "ai"):
            if self.ml is not None:
                p_ml = self.ml.posterior_from_prior(ctx, answers, prior)
            else:
                warnings.append({"code": "ml_unavailable", "fa": "مدل هوش مصنوعی در دسترس نیست؛ فقط موتور قاعده‌محور استفاده شد.",
                                 "en": "ML model unavailable - rule-based engine only."})
        if mode == "rule" or p_ml is None:
            p_main, used = p_rule, "rule"
            p_ml_out = None if mode == "rule" else p_ml
        elif mode == "ai":
            p_main, used = p_ml, "ai"
            p_ml_out = p_ml
        else:
            p_main, used = 0.5 * p_rule + 0.5 * p_ml, "combined"
            p_ml_out = p_ml

        n_answered = len(answers)
        if n_answered < kb.decision["min_questions"]:
            warnings.append({"code": "few_answers", "fa": "تعداد پاسخ‌ها کم است؛ اطمینان نتیجه پایین است.",
                             "en": "Few answers so far - low reliability."})
        if age is None or breed is None:
            warnings.append({"code": "generic_priors", "fa": "سن یا نژاد نامشخص است؛ از شیوع‌های عمومی استفاده شد.",
                             "en": "Age and/or breed not given - generic prevalence used."})

        # ---------------- ranking among cardiac diseases
        nc_i = kb.class_index[NC_ID]
        n_d = len(kb.disease_ids)
        cond = lambda p: p[:n_d] / max(p[:n_d].sum(), 1e-12)
        c_main, c_rule = cond(p_main), cond(p_rule)
        c_ml = cond(p_ml_out) if p_ml_out is not None else None
        order = np.argsort(-c_main)[:top_k]
        used_ans = effective_answers(kb, answers)
        eligible = eligible_signs(kb, ctx, answers, asked_ids - set(answers))

        ranking = []
        for r, i in enumerate(order, 1):
            d = kb.diseases[kb.classes[i]]
            sup, ag = self._explain(ctx, used_ans, p_main, i)
            confirm = self._to_confirm(ctx, d.id, eligible)
            ranking.append({
                "rank": r, "id": d.id, "name_en": d.name_en, "name_fa": d.name_fa,
                "category": d.category, "db_names": d.db_names, "urgency": d.urgency,
                "score": round(float(c_main[i]), 4),
                "band": _band(float(c_main[i]), kb.decision["bands"]),
                "rule_score": round(float(c_rule[i]), 4),
                "ai_score": None if c_ml is None else round(float(c_ml[i]), 4),
                "absolute_probability": round(float(p_main[i]), 4),
                "supporting": sup, "against": ag, "to_confirm": confirm,
                "confirm_tests_en": d.confirm_en, "note_en": d.note_en, "kb_status": d.status,
            })

        p_card = 1.0 - float(p_main[nc_i])
        nc = {
            "probability": round(float(p_main[nc_i]), 4),
            "rule": round(float(p_rule[nc_i]), 4),
            "ai": None if p_ml_out is None else round(float(p_ml_out[nc_i]), 4),
            "likely_causes": [{**c, "share": round(c["share"], 3)} for c in self.rule.nc_breakdown(ctx, answers)[:3]],
        }
        cardiac = {
            "probability": round(p_card, 4),
            "band": _cardiac_band(p_card, kb.decision["cardiac_bands"]),
            "rule": round(1 - float(p_rule[nc_i]), 4),
            "ai": None if p_ml_out is None else round(1 - float(p_ml_out[nc_i]), 4),
        }

        agreement = None
        if c_ml is not None:
            top_r, top_m = set(np.argsort(-c_rule)[:3]), set(np.argsort(-c_ml)[:3])
            jac = len(top_r & top_m) / len(top_r | top_m)
            same1 = int(np.argmax(c_rule)) == int(np.argmax(c_ml))
            state = "agree" if same1 else ("partial" if jac >= kb.decision["engines_disagree_top1_overlap"] else "disagree")
            agreement = {"state": state, "top1_same": bool(same1), "top3_overlap": round(jac, 3),
                         "divergence": round(float(0.5 * np.abs(c_rule - c_ml).sum()), 3)}
            if state == "disagree":
                warnings.append({"code": "engines_disagree",
                                 "fa": "دو موتور (قاعده‌محور و هوش مصنوعی) هم‌نظر نیستند؛ فهرست افتراقی را با احتیاط تفسیر کنید.",
                                 "en": "The rule-based and AI engines disagree - interpret the differential with caution."})

        # ---------------- next question / stopping rule
        dec = kb.decision
        adaptive_asked = len(set(raw) - initial)
        qrows = rank_questions(kb, self.rule, ctx, answers, p_rule if used == "rule" or p_ml_out is None else p_main,
                               asked_ids - set(answers), limit=3)
        best_gain = qrows[0]["info_gain"] if qrows else 0.0
        top_abs = float(p_main.max())
        done, reason = False, None
        can_conclude = n_answered >= dec["min_questions"]
        if not qrows:
            done, reason = True, "no_more_questions"
        elif adaptive_asked >= dec["max_questions"]:
            done, reason = True, "question_limit"
        elif adaptive_asked < dec["min_adaptive_questions"]:
            pass
        elif can_conclude and top_abs >= dec["stop_confidence"]:
            done, reason = True, "confident"
        elif can_conclude and best_gain < dec["min_information_gain_bits"]:
            done, reason = True, "diminishing_returns"
        next_q = None if (done or not qrows) else question_payload(kb, ctx, qrows[0])

        return {
            "kb_version": kb.version, "engine_used": used, "mode": mode,
            "context": {"species": species, "age_group": age, "breed_group": breed, "audience": audience},
            "status": {"answered": n_answered, "adaptive_asked": adaptive_asked,
                       "can_conclude": can_conclude, "done": done, "done_reason": reason},
            "triage": self._triage(ctx, used_ans, ranking),
            "cardiac_likelihood": cardiac,
            "non_cardiac": nc,
            "ranking": ranking,
            "agreement": agreement,
            "next_question": next_q,
            "warnings": warnings,
            "disclaimer_fa": DISCLAIMER_FA, "disclaimer_en": DISCLAIMER_EN,
        }

    # ------------------------------------------------------------------ explanations
    def _explain(self, ctx: Context, used: Dict[str, str], post: np.ndarray, ci: int):
        kb = self.kb
        m = self.rule.matrix(ctx)
        others = post.copy()
        others[ci] = 0
        if others.sum() <= 0:
            return [], []
        others /= others.sum()
        rows = []
        for sid, a in used.items():
            col = m[:, kb.sign_index[sid]]
            like = col if a == YES else 1 - col
            ref = float((others * like).sum())
            lr = float(like[ci] / max(ref, 1e-9))
            sg = kb.signs[sid]
            rows.append({"sign": sid, "label_fa": sg.fa, "label_en": sg.en, "answer": a, "lr": round(lr, 2)})
        sup = sorted([r for r in rows if r["lr"] >= 1.35], key=lambda r: -r["lr"])[:4]
        ag = sorted([r for r in rows if r["lr"] <= 0.74], key=lambda r: r["lr"])[:3]
        return sup, ag

    def _to_confirm(self, ctx: Context, dis_id: str, eligible: List[str]) -> List[dict]:
        kb = self.kb
        d = kb.diseases[dis_id]
        cands = [(d.p[ctx.species][s], s) for s in eligible if d.p[ctx.species][s] >= 0.5]
        cands.sort(reverse=True)
        return [{"sign": s, "label_fa": kb.signs[s].fa, "label_en": kb.signs[s].en,
                 "level": kb.signs[s].level, "expected": round(p, 2)} for p, s in cands[:4]]

    # ------------------------------------------------------------------ triage
    def _triage(self, ctx: Context, used: Dict[str, str], ranking: List[dict]) -> dict:
        kb = self.kb
        rank_of = {"routine": 0, "urgent": 1, "emergency": 2}
        level, msgs, seen = "routine", [], set()
        for sid, a in used.items():
            if a != YES:
                continue
            rf = kb.signs[sid].red_flag
            if not rf:
                continue
            if rf.get("species") and ctx.species not in rf["species"]:
                continue
            if rf["urgency"] not in seen or True:
                msgs.append({"sign": sid, "urgency": rf["urgency"], "fa": rf["fa"], "en": rf["en"]})
            if rank_of[rf["urgency"]] > rank_of[level]:
                level = rf["urgency"]
        for r in ranking[:3]:
            if r["urgency"] == "emergency" and r["absolute_probability"] >= 0.25:
                u = "emergency" if r["absolute_probability"] >= 0.5 else "urgent"
                msgs.append({"sign": None, "urgency": u,
                             "fa": f"احتمال یک وضعیت اورژانسی ({r['name_fa']}) وجود دارد؛ معاینهٔ فوری دامپزشکی لازم است.",
                             "en": f"A possible emergency condition ({r['name_en']}) is among the candidates; urgent veterinary assessment is needed."})
                if rank_of[u] > rank_of[level]:
                    level = u
        for r in ranking[:3]:
            if r["urgency"] == "urgent" and r["absolute_probability"] >= 0.5:
                msgs.append({"sign": None, "urgency": "urgent",
                             "fa": f"{r['name_fa']} محتمل است و نیاز به ارزیابی دامپزشکی ظرف ۲۴ ساعت دارد.",
                             "en": f"{r['name_en']} is likely and needs veterinary assessment within 24 hours."})
                if rank_of["urgent"] > rank_of[level]:
                    level = "urgent"
        msgs.sort(key=lambda m: -rank_of[m["urgency"]])
        return {"level": level, "messages": msgs}
