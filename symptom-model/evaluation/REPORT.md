# Evaluation report

*Generated 2026-10-14 22:41 - KB `2.0.0-draft` (hash `ea21829cf3d7640e`) - status: **AI-drafted from published veterinary cardiology references; NOT yet reviewed by a board-certified cardiologist***

> **How to read this report.** Sections 2 and 3 use cases *simulated from the same knowledge base* the engines use. They show the software behaves coherently, not that it is right in clinics. Section 1 (vignettes) is where senior veterinarians should push back. Real accuracy requires confirmed clinic cases (see `evaluation/README.md`).

## 1. Clinical vignettes

| Engine | Passed | Rate |
|---|---|---|
| rule | 54/55 | 98.2% |
| ai | 54/55 | 98.2% |
| combined | 55/55 | 100.0% |

## 2. Synthetic hold-out (prevalence-weighted, deployment-like)

3953 simulated patients (species/age/breed/audience random; 46.7% cardiac).

| Engine | Top-1 | Top-3 | Top-5 | Log-loss | ECE | Cardiac-vs-other AUC |
|---|---|---|---|---|---|---|
| rule | 71.5% | 91.1% | 95.6% | 0.96 | 0.028 | 0.889 |
| ai | 75.3% | 92.6% | 96.3% | 0.81 | 0.014 | 0.909 |
| combined | 75.2% | 92.6% | 96.4% | 0.83 | 0.030 | 0.905 |

### Per-disease recall (equal number of cases per disease, real-world priors applied, incomplete answers)

Rare diseases are *expected* to score low here: with common diseases such as MMVD in competition and only partial answers, they cannot be told apart without exam/test findings.

| Disease | n | rule top-1 | ai top-1 | combined top-1 | rule top-3 | ai top-3 | combined top-3 |
|---|---|---|---|---|---|---|---|
| mmvd | 120 | 78.3% | 76.7% | 78.3% | 95.0% | 94.2% | 95.0% |
| endocarditis | 120 | 41.7% | 29.2% | 38.3% | 65.8% | 60.0% | 60.8% |
| dcm | 120 | 61.7% | 46.7% | 57.5% | 88.3% | 85.8% | 86.7% |
| hcm | 120 | 62.5% | 61.7% | 62.5% | 91.7% | 92.5% | 91.7% |
| rcm_unclassified | 120 | 22.5% | 19.2% | 20.0% | 69.2% | 79.2% | 70.8% |
| arvc | 120 | 43.3% | 53.3% | 52.5% | 81.7% | 78.3% | 80.0% |
| thyrotoxic_cm | 120 | 50.8% | 48.3% | 48.3% | 87.5% | 86.7% | 88.3% |
| hypertensive_hd | 120 | 37.5% | 34.2% | 36.7% | 78.3% | 78.3% | 77.5% |
| myocarditis | 120 | 15.0% | 9.2% | 11.7% | 32.5% | 35.0% | 30.8% |
| pericardial_effusion | 120 | 66.7% | 42.5% | 57.5% | 88.3% | 76.7% | 85.8% |
| pericarditis | 120 | 9.2% | 11.7% | 10.8% | 35.0% | 42.5% | 35.8% |
| heart_base_tumor | 120 | 15.8% | 24.2% | 20.8% | 48.3% | 53.3% | 49.2% |
| ra_hemangiosarcoma | 120 | 27.5% | 43.3% | 37.5% | 73.3% | 65.8% | 67.5% |
| cardiac_lymphoma | 120 | 6.7% | 7.5% | 6.7% | 27.5% | 35.8% | 30.0% |
| heartworm | 120 | 54.2% | 45.8% | 51.7% | 79.2% | 76.7% | 81.7% |
| pulmonary_hypertension | 120 | 39.2% | 28.3% | 34.2% | 68.3% | 62.5% | 65.0% |
| pulmonary_thromboembolism | 120 | 51.7% | 35.8% | 40.8% | 75.8% | 74.2% | 75.0% |
| pda | 120 | 52.5% | 50.0% | 48.3% | 66.7% | 68.3% | 69.2% |
| pulmonic_stenosis | 120 | 49.2% | 43.3% | 45.0% | 68.3% | 69.2% | 72.5% |
| subaortic_stenosis | 120 | 34.2% | 27.5% | 32.5% | 63.3% | 58.3% | 60.8% |
| vsd | 120 | 26.7% | 26.7% | 26.7% | 51.7% | 60.8% | 59.2% |
| asd | 120 | 8.3% | 13.3% | 10.8% | 32.5% | 35.8% | 32.5% |
| tof | 120 | 56.7% | 44.2% | 51.7% | 70.0% | 61.7% | 69.2% |
| reversed_shunt | 120 | 31.7% | 24.2% | 27.5% | 56.7% | 45.8% | 50.8% |
| tvd | 120 | 44.2% | 42.5% | 44.2% | 67.5% | 63.3% | 67.5% |
| mitral_dysplasia | 120 | 32.5% | 34.2% | 34.2% | 64.2% | 72.5% | 70.0% |
| cor_triatriatum | 120 | 14.2% | 13.3% | 15.8% | 35.8% | 42.5% | 40.8% |
| prra | 120 | 50.8% | 45.0% | 48.3% | 82.5% | 86.7% | 84.2% |
| atrial_fibrillation | 120 | 22.5% | 28.3% | 26.7% | 55.0% | 54.2% | 54.2% |
| ventricular_arrhythmia | 120 | 14.2% | 16.7% | 15.0% | 36.7% | 50.8% | 40.8% |
| svt | 120 | 23.3% | 23.3% | 22.5% | 35.0% | 37.5% | 35.8% |
| sss | 120 | 28.3% | 27.5% | 27.5% | 56.7% | 64.2% | 62.5% |
| av_block | 120 | 35.0% | 29.2% | 35.0% | 59.2% | 56.7% | 61.7% |
| atrial_standstill | 120 | 15.8% | 15.8% | 15.8% | 38.3% | 44.2% | 40.0% |
| ate | 120 | 71.7% | 60.8% | 71.7% | 87.5% | 81.7% | 85.0% |
| non_cardiac | 120 | 80.0% | 92.5% | 90.0% | 95.8% | 100.0% | 100.0% |

## 3. Interview simulation (adaptive questions vs random)

Prevalence-weighted simulated patients (like the hold-out). The patient volunteers up to 3 observed signs, then the system asks questions until it concludes. "Random" = the same number of questions chosen at random. Top-1/3 include the *non-cardiac* class.

| Audience | n | avg. questions | no questions top-1 | random questions top-1 | **adaptive top-1** | random top-3 | **adaptive top-3** |
|---|---|---|---|---|---|---|---|
| owner | 350 | 6.6 | 61.4% | 62.3% | **69.4%** | 87.4% | **91.1%** |
| clinician | 350 | 6.2 | 54.0% | 59.1% | **85.1%** | 87.4% | **94.0%** |
