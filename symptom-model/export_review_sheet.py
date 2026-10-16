"""Export the knowledge base as sheets a veterinarian can review / correct.

  python export_review_sheet.py   ->  review/diseases_signs.csv   (one row per disease x sign grade)
                                       review/priors_demographics.csv
                                       review/REVIEW_SHEET.md      (readable, per disease)
Reviewer edits the 'reviewer_grade' / 'reviewer_comment' columns; changes are then copied to kb/diseases.yaml.
"""
import csv
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent
KB = ROOT / "kb"
OUT = ROOT / "review"
OUT.mkdir(exist_ok=True)

settings = yaml.safe_load((KB / "settings.yaml").read_text(encoding="utf-8"))
signs = {s["id"]: s for s in yaml.safe_load((KB / "signs.yaml").read_text(encoding="utf-8"))["signs"]}
diseases = yaml.safe_load((KB / "diseases.yaml").read_text(encoding="utf-8"))["diseases"]
grades = settings["grades"]

with open(OUT / "diseases_signs.csv", "w", newline="", encoding="utf-8-sig") as f:
    w = csv.writer(f)
    w.writerow(["disease_id", "disease", "species", "sign_id", "sign", "level", "grade", "approx_probability",
                "reviewer_grade", "reviewer_comment"])
    for d in diseases:
        for sp in ("dog", "cat"):
            if d["prior"].get(sp, 0) <= 0:
                continue
            merged = {**(d.get("signs") or {}), **(d.get(f"signs_{sp}") or {})}
            for sid, g in sorted(merged.items(), key=lambda kv: kv[1]):
                s = signs[sid]
                prob = grades.get(g, g) if isinstance(g, str) else g
                w.writerow([d["id"], d["name_en"], sp, sid, s["en"], s["level"], g, prob, "", ""])

with open(OUT / "priors_demographics.csv", "w", newline="", encoding="utf-8-sig") as f:
    w = csv.writer(f)
    w.writerow(["disease_id", "disease", "relative_prior_dog", "relative_prior_cat", "age_multipliers",
                "breed_multipliers", "urgency", "status", "reviewer_comment"])
    for d in diseases:
        w.writerow([d["id"], d["name_en"], d["prior"].get("dog", 0), d["prior"].get("cat", 0),
                    d.get("age"), d.get("breed"), d.get("urgency"), d.get("status"), ""])

lines = ["# Knowledge-base review sheet", "",
         f"KB version: **{settings['kb_version']}** - {settings['status']}", "",
         "Grades: " + ", ".join(f"{k}={v}" for k, v in grades.items()), "",
         "For every disease please check: (1) is the prior plausible for your caseload, (2) are the grades right "
         "(especially the A/B ones that drive the ranking), (3) are important signs missing, (4) urgency, (5) the "
         "'confirm with' tests. Write corrections in the CSV or directly in kb/diseases.yaml.", ""]
for d in diseases:
    lines += [f"## {d['name_en']}  ({d['name_fa']})", "",
              f"- id: `{d['id']}` - category: {d.get('category')} - urgency: **{d.get('urgency')}** - status: {d.get('status')}",
              f"- relative prior dog/cat: {d['prior'].get('dog', 0)} / {d['prior'].get('cat', 0)}",
              f"- age multipliers: {d.get('age')}  - breed: {d.get('breed')}"]
    if d.get("note_en"):
        lines.append(f"- note: {d['note_en']}")
    if d.get("confirm_en"):
        lines.append("- confirm with: " + "; ".join(d["confirm_en"]))
    lines.append("- sources: " + ", ".join(d.get("refs") or []))
    lines.append("")
    by_grade = {}
    for sid, g in (d.get("signs") or {}).items():
        by_grade.setdefault(g, []).append(signs[sid]["en"])
    for g in sorted(by_grade):
        lines.append(f"  - **{g}**: " + ", ".join(sorted(by_grade[g])))
    for sp in ("dog", "cat"):
        ov = d.get(f"signs_{sp}")
        if ov:
            lines.append(f"  - {sp} overrides: " + ", ".join(f"{signs[k]['en']}={v}" for k, v in ov.items()))
    lines.append("")
(OUT / "REVIEW_SHEET.md").write_text("\n".join(lines), encoding="utf-8")
print("wrote", OUT)
