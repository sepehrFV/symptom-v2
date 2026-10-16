"""Score the tool on REAL, vet-confirmed cases.

  python evaluate_cases.py cases.csv

CSV columns: species, age_group, breed_group, audience, answers_json, final_diagnosis
  answers_json    {"cough":"yes","syncope":"no",...}
  final_diagnosis a KB disease id, or  non_cardiac / other  (other = a cardiac disease not in the KB)
Prints top-1 / top-3 and cardiac-vs-other sensitivity & specificity per engine. Needs >=100 cases to mean much.
"""
import csv
import json
import sys

from engine.kb import NC_ID
from engine.service import DiagnosisService


def main(path):
    svc = DiagnosisService()
    rows = list(csv.DictReader(open(path, encoding="utf-8-sig")))
    modes = ["rule", "ai", "combined"] if svc.ml else ["rule"]
    for mode in modes:
        n = t1 = t3 = tp = fn = tn = fp = 0
        n_dis = 0
        for r in rows:
            truth = r["final_diagnosis"].strip()
            res = svc.diagnose({"species": r["species"], "age_group": r.get("age_group") or None,
                                "breed_group": r.get("breed_group") or None, "audience": r["audience"],
                                "answers": json.loads(r["answers_json"] or "{}"), "mode": mode, "top_k": 5})
            ids = [x["id"] for x in res["ranking"]]
            n += 1
            cardiac_truth = truth != NC_ID
            pred_cardiac = res["cardiac_likelihood"]["band"] in ("high", "moderate")
            if cardiac_truth:
                tp += pred_cardiac
                fn += not pred_cardiac
            else:
                tn += not pred_cardiac
                fp += pred_cardiac
            if truth in svc.kb.diseases:
                n_dis += 1
                t1 += ids[0] == truth
                t3 += truth in ids[:3]
        sens = tp / (tp + fn) if tp + fn else float("nan")
        spec = tn / (tn + fp) if tn + fp else float("nan")
        print(f"{mode:9s} n={n}  disease cases={n_dis}  top1={t1/max(n_dis,1):.1%}  top3={t3/max(n_dis,1):.1%}  "
              f"cardiac sens={sens:.1%} spec={spec:.1%}  (cardiac = band moderate or high)")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    main(sys.argv[1])
