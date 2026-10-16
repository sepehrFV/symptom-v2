# Veterinary cardiology decision-support engine (v2)

Two independent engines over one clinician-editable knowledge base (`kb/*.yaml`):

* **Rule engine** - transparent Bayesian model (35 cardiac diseases + a non-cardiac mixture). Priors depend on
  species, age group, breed group and who is answering (owner vs clinician). Every answer's likelihood includes
  observer error; "unknown" answers are skipped, not treated as "no".
* **AI engine** - ensemble of 3 neural nets trained on cases simulated from the KB (stage-aware, correlated signs,
  incomplete interviews, observer noise), prior-shift corrected and temperature-calibrated.
* **Combined** (default) averages both and reports whether they agree.

The interview is adaptive: the next question maximises expected information gain per unit cost; it stops when the
top diagnosis is clear (>=85 %), further questions add <0.03 bit, or 14 questions were asked.

Output uses qualitative bands (high / moderate / low / unlikely) instead of fake percentages, a separate
"cardiac vs other cause" statement, supporting/against evidence, tests to confirm, a triage level
(routine / urgent / emergency) and bilingual disclaimers.

## Run
    pip install -r requirements.txt
    python train.py            # ~2 min; also happens automatically on first request / after a KB change
    python app.py              # http://localhost:5000   GET /meta /signs?audience= /diseases   POST /diagnose
    python -m unittest discover -s tests -v
    python evaluate.py [--quick]          # evaluation/REPORT.md
    python export_review_sheet.py         # review/ for the senior vets
    python evaluate_cases.py cases.csv    # real, confirmed cases

## POST /diagnose
    {"species":"dog","age_group":"senior","breed_group":"cavalier","audience":"owner",
     "answers":{"cough":"yes","syncope":"no","dyspnea":"unknown"},"mode":"combined","top_k":5}

## Limits (read before trusting)
* KB is AI-drafted and unreviewed - see `kb/CURATION.md`. Synthetic and vignette results are circular
  (see `evaluation/README.md`); there is no real-patient accuracy figure yet.
* One disease at a time; no treatment advice; dogs and cats only.
