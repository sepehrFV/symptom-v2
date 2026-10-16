"""Evaluation harness.

    python evaluate.py                    # full report  -> evaluation/REPORT.md + results.json
    python evaluate.py --quick            # smaller samples
    python evaluate.py --vignettes-only   # only the clinical vignettes (what vets will edit)

Three independent kinds of evidence are produced:
  1. CLINICAL VIGNETTES   textbook cases with expected outcome (evaluation/vignettes.yaml)
  2. SYNTHETIC HOLD-OUT   fresh simulated cases (different random seed than training):
                          accuracy, log-loss, calibration, cardiac-vs-other AUC
  3. INTERVIEW SIMULATION full adaptive question loop against simulated patients, compared
                          with asking the same number of RANDOM questions

HONEST LIMITATION: (2) and (3) use cases generated from the same knowledge base the
engines use. They prove the software works and is internally consistent; they do NOT
measure real-world accuracy. Only real, confirmed clinic cases can do that
(see evaluation/README.md for the protocol).
"""
from __future__ import annotations

import json
import sys
import time
from collections import defaultdict
from pathlib import Path

import numpy as np
import yaml
from sklearn.metrics import roc_auc_score

from engine.kb import NC_ID, load_kb
from engine.questions import eligible_signs
from engine.rules import Context, RuleEngine
from engine.service import DiagnosisService
from engine.simulator import Simulator

HERE = Path(__file__).resolve().parent
EVAL_DIR = HERE / "evaluation"
TRIAGE_RANK = {"routine": 0, "urgent": 1, "emergency": 2}
BAND_ORDER = ["very_low", "low", "moderate", "high"]


# =============================================================================
# 1. vignettes
# =============================================================================
def check_vignette(v: dict, r: dict) -> list:
    """returns list of failure strings (empty = pass)"""
    ex, fails = v.get("expect", {}), []
    ids = [x["id"] for x in r["ranking"]]
    if "top1_in" in ex and ids[0] not in ex["top1_in"]:
        fails.append(f"top1 is {ids[0]}, expected one of {ex['top1_in']}")
    if "top3_any" in ex and not set(ex["top3_any"]) & set(ids[:3]):
        fails.append(f"none of {ex['top3_any']} in top3 {ids[:3]}")
    if "top3_all" in ex and not set(ex["top3_all"]) <= set(ids[:3]):
        fails.append(f"not all of {ex['top3_all']} in top3 {ids[:3]}")
    if "not_top1" in ex and ids[0] in ex["not_top1"]:
        fails.append(f"top1 must not be {ids[0]}")
    if "cardiac_in" in ex and r["cardiac_likelihood"]["band"] not in ex["cardiac_in"]:
        fails.append(f"cardiac band {r['cardiac_likelihood']['band']} ({r['cardiac_likelihood']['probability']}) not in {ex['cardiac_in']}")
    if "triage_min" in ex and TRIAGE_RANK[r["triage"]["level"]] < TRIAGE_RANK[ex["triage_min"]]:
        fails.append(f"triage {r['triage']['level']} < {ex['triage_min']}")
    if "nc_cause_top" in ex:
        top = r["non_cardiac"]["likely_causes"][0]["id"]
        if top != ex["nc_cause_top"]:
            fails.append(f"top non-cardiac cause {top}, expected {ex['nc_cause_top']}")
    return fails


def run_vignettes(svc: DiagnosisService) -> dict:
    vs = yaml.safe_load((EVAL_DIR / "vignettes.yaml").read_text(encoding="utf-8"))["vignettes"]
    modes = ["rule", "ai", "combined"] if svc.ml else ["rule"]
    out = {"n": len(vs), "modes": {}}
    for mode in modes:
        res, passed = [], 0
        for v in vs:
            r = svc.diagnose({"species": v["species"], "age_group": v.get("age_group"),
                              "breed_group": v.get("breed_group"), "audience": v["audience"],
                              "answers": v["answers"], "mode": mode, "top_k": 5})
            f = check_vignette(v, r)
            passed += not f
            res.append({"id": v["id"], "title": v["title"], "pass": not f, "failures": f,
                        "top3": [x["id"] for x in r["ranking"][:3]],
                        "cardiac": r["cardiac_likelihood"]["probability"], "triage": r["triage"]["level"]})
        out["modes"][mode] = {"passed": passed, "rate": passed / len(vs), "results": res}
    return out


# =============================================================================
# 2. synthetic hold-out
# =============================================================================
def _ece(conf, hit, bins=12):
    conf, hit = np.asarray(conf), np.asarray(hit, dtype=float)
    edges = np.linspace(0, 1, bins + 1)
    e = 0.0
    for lo, hi in zip(edges[:-1], edges[1:]):
        m = (conf > lo) & (conf <= hi)
        if m.any():
            e += m.mean() * abs(hit[m].mean() - conf[m].mean())
    return float(e)



def make_prevalence_sampler(kb, sim, rng):
    """draws a patient the way deployment would: species/age/breed/audience at random, disease by prior"""
    def draw(audience=None):
        sp = rng.choice(kb.species_ids, p=[0.65, 0.35])
        aud = audience or rng.choice(["owner", "clinician"], p=[0.6, 0.4])
        ages = kb.age_ids
        ap = np.array([kb.settings["age_groups"][a]["population"] for a in ages])
        age = str(rng.choice(ages, p=ap / ap.sum()))
        bgs = [b for b in kb.breed_groups[sp] if b != "unknown"]
        bp = np.array([kb.breed_groups[sp][b]["population"] for b in bgs])
        breed = str(rng.choice(bgs, p=bp / bp.sum()))
        pri = kb.priors(sp, age, breed, aud)
        cls = str(rng.choice(list(pri), p=np.array(list(pri.values()))))
        c = sim.sample_case(cls, aud)
        c.species, c.age_group, c.breed_group = sp, age, breed
        c.truth = sim.sample_truth(cls, sp, age)
        c.answers = sim.observe(c.truth, aud)
        return c
    return draw


def _all_posteriors(svc, ctx, answers):
    prior = svc.rule.prior_vector(ctx)
    pr = svc.rule.posterior(ctx, answers)
    pm = svc.ml.posterior_from_prior(ctx, answers, prior) if svc.ml else None
    return {"rule": pr, "ai": pm, "combined": (0.5 * pr + 0.5 * pm) if pm is not None else None}


def run_holdout(svc: DiagnosisService, n_cases: int, per_class_balanced: int) -> dict:
    kb = svc.kb
    seed = kb.settings["ml"]["seed"] + 777
    sim = Simulator(kb, seed)
    rng = np.random.default_rng(seed)
    nc_i = kb.class_index[NC_ID]

    draw_prevalence_case = make_prevalence_sampler(kb, sim, rng)

    engines = ["rule", "ai", "combined"] if svc.ml else ["rule"]
    stats = {e: {"top1": [], "top3": [], "top5": [], "ll": [], "conf": [], "hit": [], "pcard": []} for e in engines}
    y_card = []
    t0 = time.time()
    for _ in range(n_cases):
        c = draw_prevalence_case()
        if not any(v == "yes" for v in c.answers.values()):
            continue
        ctx = Context(c.species, c.age_group, c.breed_group, c.audience)
        post = _all_posteriors(svc, ctx, c.answers)
        y = kb.class_index[c.label]
        y_card.append(0 if c.label == NC_ID else 1)
        for e in engines:
            p = post[e]
            rk = np.argsort(-p)
            stats[e]["top1"].append(rk[0] == y)
            stats[e]["top3"].append(y in rk[:3])
            stats[e]["top5"].append(y in rk[:5])
            stats[e]["ll"].append(-np.log(max(p[y], 1e-9)))
            stats[e]["conf"].append(p[rk[0]])
            stats[e]["hit"].append(rk[0] == y)
            stats[e]["pcard"].append(1 - p[nc_i])
    out = {"n": len(y_card), "engines": {}}
    for e in engines:
        s = stats[e]
        out["engines"][e] = {
            "top1": float(np.mean(s["top1"])), "top3": float(np.mean(s["top3"])), "top5": float(np.mean(s["top5"])),
            "log_loss": float(np.mean(s["ll"])), "ece": _ece(s["conf"], s["hit"]),
            "cardiac_vs_other_auc": float(roc_auc_score(y_card, s["pcard"])) if len(set(y_card)) > 1 else None,
        }
    out["cardiac_share"] = float(np.mean(y_card))

    # balanced per-disease recall (each class equally often, own demographics)
    per_class = {e: {} for e in engines}
    for cls in kb.classes:
        hits = {e: [0, 0, 0] for e in engines}
        n = 0
        for _ in range(per_class_balanced):
            c = sim.sample_case(cls, realistic=True)
            if not any(v == "yes" for v in c.answers.values()):
                continue
            ctx = Context(c.species, c.age_group, c.breed_group, c.audience)
            post = _all_posteriors(svc, ctx, c.answers)
            y = kb.class_index[cls]
            n += 1
            for e in engines:
                rk = np.argsort(-post[e])
                hits[e][0] += rk[0] == y
                hits[e][1] += y in rk[:3]
                hits[e][2] += y in rk[:5]
        for e in engines:
            per_class[e][cls] = {"n": n, "top1": hits[e][0] / max(n, 1), "top3": hits[e][1] / max(n, 1)}
    out["per_class"] = per_class
    out["seconds"] = round(time.time() - t0, 1)
    return out


# =============================================================================
# 3. interview simulation (adaptive vs random questions)
# =============================================================================
def run_interviews(svc: DiagnosisService, n_total: int) -> dict:
    kb = svc.kb
    seed = kb.settings["ml"]["seed"] + 4242
    sim = Simulator(kb, seed)
    rng = np.random.default_rng(seed)
    rule = RuleEngine(kb)
    draw = make_prevalence_sampler(kb, sim, rng)
    res = {"owner": defaultdict(list), "clinician": defaultdict(list)}
    t0 = time.time()
    done_n = {"owner": 0, "clinician": 0}
    attempts = 0
    while min(done_n.values()) < n_total // 2 and attempts < n_total * 6:
        attempts += 1
        aud = "owner" if done_n["owner"] <= done_n["clinician"] else "clinician"
        case = draw(aud)
        cls, truth, sp = case.label, case.truth, case.species
        seen_cache = {}

        def observed(sid):
            if sid not in seen_cache:
                o = kb.observation[kb.signs[sid].level]
                v = truth[sid]
                if v and rng.random() < o["miss"]:
                    v = False
                elif (not v) and rng.random() < o["false_pos"]:
                    v = True
                seen_cache[sid] = "yes" if v else "no"
            return seen_cache[sid]

        owner_present = [s for s in kb.sign_ids if kb.signs[s].level in ("owner", "history") and observed(s) == "yes"]
        if not owner_present:
            continue
        init = [str(x) for x in rng.choice(owner_present, size=min(3, len(owner_present)), replace=False)]
        answers = {s: "yes" for s in init}
        asked = 0
        while True:
            r = svc.diagnose({"species": sp, "age_group": case.age_group, "breed_group": case.breed_group,
                              "audience": aud, "answers": answers, "mode": "combined", "top_k": 5, "initial": init})
            if r["status"]["done"] or not r["next_question"]:
                break
            q = r["next_question"]["id"]
            answers[q] = observed(q)
            asked += 1
            if asked > 40:
                break
        nc_p = r["non_cardiac"]["probability"]
        ranked = [(NC_ID, nc_p)] + [(x["id"], x["absolute_probability"]) for x in r["ranking"]]
        ranked.sort(key=lambda t: -t[1])
        hit1, hit3 = ranked[0][0] == cls, cls in [t[0] for t in ranked[:3]]

        ctx = Context(sp, case.age_group, case.breed_group, aud)
        y = kb.class_index[cls]

        def eval_rule(ans):
            p = rule.posterior(ctx, ans)
            rk = np.argsort(-p)
            return rk[0] == y, y in rk[:3]

        h0 = eval_rule({s: "yes" for s in init})
        rand_ans = {s: "yes" for s in init}
        pool = list(eligible_signs(kb, ctx, rand_ans))
        rng.shuffle(pool)
        for s in pool[:asked]:
            rand_ans[s] = observed(s)
        hr = eval_rule(rand_ans)
        for key, val in [("adaptive_top1", hit1), ("adaptive_top3", hit3), ("none_top1", h0[0]), ("none_top3", h0[1]),
                         ("random_top1", hr[0]), ("random_top3", hr[1]), ("questions", asked)]:
            res[aud][key].append(float(val))
        done_n[aud] += 1
    out = {}
    for aud, d in res.items():
        out[aud] = {k: float(np.mean(v)) for k, v in d.items()}
        out[aud]["n"] = len(d["questions"])
    out["seconds"] = round(time.time() - t0, 1)
    return out


# =============================================================================
# report
# =============================================================================
def pct(x):
    return "n/a" if x is None else f"{100*x:.1f}%"


def write_report(kb, vig, hold, itv):
    L = []
    L.append("# Evaluation report\n")
    L.append(f"*Generated {time.strftime('%Y-%m-%d %H:%M')} - KB `{kb.version}` (hash `{kb.hash}`) - status: **{kb.settings['status']}***\n")
    L.append("> **How to read this report.** Sections 2 and 3 use cases *simulated from the same knowledge base* "
             "the engines use. They show the software behaves coherently, not that it is right in clinics. "
             "Section 1 (vignettes) is where senior veterinarians should push back. "
             "Real accuracy requires confirmed clinic cases (see `evaluation/README.md`).\n")
    L.append("## 1. Clinical vignettes\n")
    L.append("| Engine | Passed | Rate |\n|---|---|---|")
    for m, d in vig["modes"].items():
        L.append(f"| {m} | {d['passed']}/{vig['n']} | {pct(d['rate'])} |")
    for m in ("combined",):
        if m in vig["modes"]:
            fails = [r for r in vig["modes"][m]["results"] if not r["pass"]]
            if fails:
                L.append(f"\n**Failing vignettes ({m}):**\n")
                for r in fails:
                    L.append(f"- `{r['id']}` {r['title']} - top3 {r['top3']}; " + "; ".join(r["failures"]))
    if hold:
        L.append("\n## 2. Synthetic hold-out (prevalence-weighted, deployment-like)\n")
        L.append(f"{hold['n']} simulated patients (species/age/breed/audience random; {pct(hold['cardiac_share'])} cardiac).\n")
        L.append("| Engine | Top-1 | Top-3 | Top-5 | Log-loss | ECE | Cardiac-vs-other AUC |\n|---|---|---|---|---|---|---|")
        for e, s in hold["engines"].items():
            L.append(f"| {e} | {pct(s['top1'])} | {pct(s['top3'])} | {pct(s['top5'])} | {s['log_loss']:.2f} | {s['ece']:.3f} | {s['cardiac_vs_other_auc']:.3f} |")
        L.append("\n### Per-disease recall (equal number of cases per disease, real-world priors applied, incomplete answers)\n")
        L.append("Rare diseases are *expected* to score low here: with common diseases such as MMVD in competition and only partial answers, they cannot be told apart without exam/test findings.\n")
        engs = list(hold["per_class"].keys())
        L.append("| Disease | n | " + " | ".join(f"{e} top-1" for e in engs) + " | " + " | ".join(f"{e} top-3" for e in engs) + " |")
        L.append("|---|---|" + "---|" * (2 * len(engs)))
        for cls in kb.classes:
            row = hold["per_class"][engs[0]][cls]
            L.append(f"| {cls} | {row['n']} | " + " | ".join(pct(hold['per_class'][e][cls]['top1']) for e in engs) + " | "
                     + " | ".join(pct(hold['per_class'][e][cls]['top3']) for e in engs) + " |")
    if itv:
        L.append("\n## 3. Interview simulation (adaptive questions vs random)\n")
        L.append("Prevalence-weighted simulated patients (like the hold-out). The patient volunteers up to 3 observed signs, then the system asks questions until it concludes. \"Random\" = the same number of questions chosen at random. Top-1/3 include the *non-cardiac* class.\n")
        L.append("| Audience | n | avg. questions | no questions top-1 | random questions top-1 | **adaptive top-1** | random top-3 | **adaptive top-3** |\n|---|---|---|---|---|---|---|---|")
        for aud in ("owner", "clinician"):
            s = itv[aud]
            L.append(f"| {aud} | {s['n']} | {s['questions']:.1f} | {pct(s['none_top1'])} | {pct(s['random_top1'])} | **{pct(s['adaptive_top1'])}** | {pct(s['random_top3'])} | **{pct(s['adaptive_top3'])}** |")
    (EVAL_DIR / "REPORT.md").write_text("\n".join(L) + "\n", encoding="utf-8")


def main():
    quick = "--quick" in sys.argv
    vig_only = "--vignettes-only" in sys.argv
    kb = load_kb()
    svc = DiagnosisService(kb)
    if svc.ml is None:
        print("! no ML model loaded (run train.py) - evaluating rule engine only")
    vig = run_vignettes(svc)
    for m, d in vig["modes"].items():
        print(f"vignettes [{m}]: {d['passed']}/{vig['n']}")
        if m == "combined" or len(vig["modes"]) == 1:
            for r in d["results"]:
                if not r["pass"]:
                    print(f"   FAIL {r['id']} {r['title']}\n        top3={r['top3']} cardiac={r['cardiac']} triage={r['triage']}\n        " + "; ".join(r["failures"]))
    hold = itv = None
    if not vig_only:
        hold = run_holdout(svc, 600 if quick else 4000, 25 if quick else 120)
        print("holdout:", json.dumps(hold["engines"], indent=1))
        itv = run_interviews(svc, 100 if quick else 700)
        print("interviews:", json.dumps(itv, indent=1))
    (EVAL_DIR / "results.json").write_text(json.dumps({"vignettes": vig, "holdout": hold, "interviews": itv}, indent=1), encoding="utf-8")
    write_report(kb, vig, hold, itv)
    print("report written to", EVAL_DIR / "REPORT.md")


if __name__ == "__main__":
    main()
