# Knowledge-base curation log

## Status
All content in `diseases.yaml`, `signs.yaml`, `non_cardiac.yaml` is **AI-drafted (status `draft_ai_pending_vet_review`)**.
Probabilities are *expert-elicited style estimates informed by* the references in `references.yaml`; they are
not extracted from a dataset and are not quoted from those papers. Nothing here is validated until a
cardiologist has gone through `review/REVIEW_SHEET.md` (generate with `python export_review_sheet.py`).

## What changed relative to the original project
- The old data model (a disease x symptom CSV with 1/2/3 codes and a Naive-Bayes-less random "confidence")
  was discarded. The 68-symptom enum is kept only as `codes:` back-references on signs, so the old DB keeps working.
- Signs were re-modelled as 95 findings at four levels (owner / history / exam / test) so an owner is never asked
  for an ECG result and a clinician can use every level.
- Parent/child signs (e.g. heart murmur -> murmur location) are never double counted.
- Diseases: 35 cardiac diseases, each with species-specific overrides where dog and cat differ (HCM, DCM, ATE,
  hyperthyroid heart, ...). Non-cardiac causes are modelled as a mixture of 10 profiles so that a cough or
  exercise intolerance does not automatically mean "heart".

## Merges / exclusions (please challenge these)
- Old DB rows for equivalent conditions under different names are mapped through `db_names`.
- `mitral_dysplasia` and `svt` have no DB row yet (`db_names: []`): the API returns the KB name with
  `diseaseId: null`.
- Not modelled: simultaneous diseases (e.g. AF + DCM), post-treatment states, exotic species (rabbit, ferret, horse...),
  acquired valve disease in cats, canine HCM, Chagas, tick-borne myocarditis detail, drug toxicities (doxorubicin, ...).
- Prior numbers are relative prevalence in a *cardiology referral-like* population, not general practice; the
  owner audience gets a 60 % non-cardiac prior and the clinician audience 40 %. Adjust in `settings.yaml`.

## How to change something
1. Edit YAML (grades A-G are mapped to probabilities in `settings.yaml`).
2. `python -m unittest discover -s tests` (lint + regression) then `python evaluate.py --quick`.
3. If a vignette now fails, either the vignette or the KB is wrong - decide clinically, not statistically.
4. The ML model detects KB changes via a hash and retrains automatically (or run `python train.py`).
