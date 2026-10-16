# How to validate this tool honestly

## What the current numbers mean
`REPORT.md` contains three kinds of evidence:
1. **Vignettes** (`vignettes.yaml`, 55 hand-written scenarios) - clinical face validity. Senior vets should
   add, edit and *try to break* these. Expectations are written as "top-1 is one of ...", "triage at least ...".
2. **Synthetic hold-out / interview simulation** - cases simulated from the *same* KB. These only show that the
   software is internally coherent and that adaptive questions beat random ones. They are **not** clinical accuracy.
3. Nothing in this repository is a measurement on real patients yet.

## Prospective validation protocol (recommended for the thesis)
1. For every real patient where the tool is used, store: species, age group, breed group, audience, all answers,
   both rankings (rule, ai) and the date. (The backend exposes `/diagnosis/cases` for this.)
2. When the final diagnosis is established by echo / specialist, record it with `/diagnosis/cases/{id}/outcome`
   (use the KB id, `non_cardiac`, or `other`).
3. After >= 100 confirmed cases run `python evaluate_cases.py cases.csv`: top-1/top-3
   accuracy per engine, cardiac-vs-non-cardiac AUC, calibration of the bands, and triage sensitivity
   (did every real emergency get `emergency`?). Report per-disease numbers only for diseases with >= 10 cases.
4. Use confirmed cases to correct grades in the KB; do NOT tune on the same cases you report.

## Metrics to report
Top-k accuracy, sensitivity/specificity of "cardiac cause" at the moderate band, triage under-call rate,
engine agreement rate and accuracy when they agree vs disagree.
