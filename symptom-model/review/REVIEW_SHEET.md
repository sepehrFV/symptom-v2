# Knowledge-base review sheet

KB version: **2.0.0-draft** - AI-drafted from published veterinary cardiology references; NOT yet reviewed by a board-certified cardiologist

Grades: A=0.92, B=0.75, C=0.5, D=0.3, E=0.15, F=0.06, G=0.02

For every disease please check: (1) is the prior plausible for your caseload, (2) are the grades right (especially the A/B ones that drive the ranking), (3) are important signs missing, (4) urgency, (5) the 'confirm with' tests. Write corrections in the CSV or directly in kb/diseases.yaml.

## Myxomatous mitral valve disease (MMVD)  (دژنراسیون میکزوماتوز دریچهٔ میترال (MMVD))

- id: `mmvd` - category: valvular - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 66 / 0.2
- age multipliers: {'young': 0.03, 'adult': 0.55, 'senior': 1.9}  - breed: {'dog': {'cavalier': 4.0, 'small_toy': 1.6, 'medium': 0.6, 'large': 0.15, 'giant': 0.03, 'boxer': 0.2, 'doberman': 0.15, 'brachycephalic': 0.5}}
- note: Most common acquired canine heart disease (older small breeds, esp. Cavalier King Charles Spaniel). Cough in a small old dog may equally be airway disease; left atrial enlargement + edema supports MMVD.
- confirm with: Echocardiography (valve morphology, LA:Ao, LVIDDn); Thoracic radiographs (VHS, VLAS, edema); NT-proBNP; Sleeping respiratory rate
- sources: acvim_mmvd_2019, kittleson_1998, smith_manual_2015

  - **A**: Echo - mitral valve thickening / prolapse / dysplasia with regurgitation, Heart murmur, Systolic murmur, left apex (mitral area)
  - **B**: Echo - left atrial enlargement (LA:Ao increased), NT-proBNP elevated, Radiograph - generalized cardiomegaly (VHS above normal), Radiograph - left atrial enlargement
  - **C**: Cough, Exercise intolerance, Fast resting/sleeping breathing rate
  - **D**: Generalised weakness, Irregular heart rhythm, Labored breathing (dyspnea), Lethargy / reduced activity, Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Restlessness, especially at night, Systolic murmur, right side (tricuspid area), Tachycardia
  - **E**: Decreased appetite, ECG - ventricular premature complexes / ventricular tachycardia, Echo - tricuspid regurgitation velocity >3.4 m/s (pulmonary hypertension), Fainting (syncope), Gallop rhythm (S3/S4), Refuses to lie down / sits upright to breathe, Systolic ejection murmur, left base (aortic/pulmonic area), Weight / muscle loss
  - **F**: ECG - atrial fibrillation, Swollen abdomen (ascites)

## Infective endocarditis  (اندوکاردیت عفونی)

- id: `endocarditis` - category: inflammatory - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.5 / 0.2
- age multipliers: {'young': 0.2, 'adult': 1.2, 'senior': 0.9}  - breed: {'dog': {'large': 2.0, 'giant': 1.2, 'small_toy': 0.5, 'boxer': 1.5}}
- note: Think of it in a fever + new/changing murmur (esp. left basilar diastolic/AR) + shifting lameness or discospondylitis. Often large-breed dogs with aortic valve involvement.
- confirm with: Echocardiography (vegetation, new regurgitation); Blood cultures x3 (before antibiotics); CBC/chemistry/urinalysis; Bartonella serology/PCR
- sources: ettinger_2017, kittleson_1998

  - **A**: Fever, Lethargy / reduced activity
  - **B**: Decreased appetite, Echo - valvular vegetation (aortic or mitral), Heart murmur
  - **C**: Bounding (hyperdynamic) pulses, Cardiac troponin I elevated, ECG - ventricular premature complexes / ventricular tachycardia, Echo - mitral valve thickening / prolapse / dysplasia with regurgitation, Fast resting/sleeping breathing rate, Generalised weakness, Irregular heart rhythm, NT-proBNP elevated, Positive blood culture, Recent source of infection (dental, skin, urinary, discospondylitis), Systolic ejection murmur, left base (aortic/pulmonic area), Systolic murmur, left apex (mitral area), Weight / muscle loss
  - **D**: Anemia (low PCV/hematocrit), Azotemia (increased creatinine/BUN), Cough, Labored breathing (dyspnea), Radiograph - generalized cardiomegaly (VHS above normal), Severe limb pain / crying out, Vomiting

## Dilated cardiomyopathy (DCM)  (کاردیومیوپاتی اتساعی (DCM))

- id: `dcm` - category: cardiomyopathy - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 8 / 2
- age multipliers: {'young': 0.15, 'adult': 1.3, 'senior': 0.9}  - breed: {'dog': {'doberman': 8.0, 'boxer': 2.5, 'giant': 3.0, 'large': 2.2, 'medium': 0.6, 'small_toy': 0.1, 'cavalier': 0.1, 'brachycephalic': 0.3}}
- note: Large/giant breeds (Doberman occult phase - arrhythmia before overt dilation). In cats now rare (taurine-responsive after diet changes).
- confirm with: Echocardiography (LV dimensions, FS/EF); 24-h Holter (Doberman/Boxer); Thoracic radiographs; NT-proBNP/troponin; Taurine & carnitine levels (cats / predisposed dogs)
- sources: dukes_mcewan_2003, ettinger_2017, kittleson_1998

  - **A**: Echo - dilated LV with reduced systolic function
  - **B**: Echo - left atrial enlargement (LA:Ao increased), Exercise intolerance, Irregular heart rhythm, NT-proBNP elevated, Radiograph - generalized cardiomegaly (VHS above normal), Tachycardia
  - **C**: Cardiac troponin I elevated, Cough, ECG - atrial fibrillation, ECG - ventricular premature complexes / ventricular tachycardia, Fast resting/sleeping breathing rate, Generalised weakness, Heart murmur, Labored breathing (dyspnea), Radiograph - left atrial enlargement, Systolic murmur, left apex (mitral area), Weak or deficient pulses
  - **D**: Decreased appetite, Fainting (syncope), Family history of heart disease / sudden death, Gallop rhythm (S3/S4), Lethargy / reduced activity, Pale gums, Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Swollen abdomen (ascites), Weight / muscle loss
  - **E**: Collapse (sudden inability to stand), Jugular distension / pulsation, Pleural effusion (muffled ventral lung sounds / confirmed), Refuses to lie down / sits upright to breathe, Systolic murmur, right side (tricuspid area)
  - **F**: Echo - mitral valve thickening / prolapse / dysplasia with regurgitation
  - cat overrides: Labored breathing (dyspnea)=B, Fast resting/sleeping breathing rate=B, Panting / open-mouth breathing at rest=C, Lethargy / reduced activity=B, Decreased appetite=B, Cough=F, Weak or deficient pulses=C, Cold paws / extremities=D, Sudden hind-limb paralysis=F, Pleural effusion (muffled ventral lung sounds / confirmed)=C, Heart murmur=D, Systolic murmur, left apex (mitral area)=D, Exercise intolerance=D, Weight / muscle loss=D

## Hypertrophic cardiomyopathy (HCM)  (کاردیومیوپاتی هیپرتروفیک (HCM))

- id: `hcm` - category: cardiomyopathy - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.1 / 55
- age multipliers: {'young': 0.6, 'adult': 1.1, 'senior': 1.0}  - breed: {'cat': {'maine_coon_ragdoll': 5.0, 'other_pedigree': 2.0}}
- note: Most common feline cardiomyopathy; many cats are subclinical until CHF or aortic thromboembolism. Exclude hyperthyroidism and hypertension before labelling primary HCM.
- confirm with: Echocardiography (max end-diastolic wall thickness >=6 mm, LA size, SAM); NT-proBNP / SNAP; Thoracic radiographs (if dyspneic); BP + T4 (exclude secondary causes); MYBPC3 genotype (Maine Coon, Ragdoll)
- sources: acvim_feline_cm_2020, ettinger_2017, bsava_2010

  - **A**: Echo - LV wall thickening (hypertrophy)
  - **B**: Echo - left atrial enlargement (LA:Ao increased), NT-proBNP elevated
  - **C**: Cardiac troponin I elevated, Decreased appetite, Fast resting/sleeping breathing rate, Gallop rhythm (S3/S4), Heart murmur, Labored breathing (dyspnea), Lethargy / reduced activity, Panting / open-mouth breathing at rest, Radiograph - generalized cardiomegaly (VHS above normal), Radiograph - left atrial enlargement
  - **D**: Family history of heart disease / sudden death, Irregular heart rhythm, Pleural effusion (muffled ventral lung sounds / confirmed), Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Systolic ejection murmur, left base (aortic/pulmonic area), Systolic murmur, left apex (mitral area)
  - **E**: Collapse (sudden inability to stand), ECG - ventricular premature complexes / ventricular tachycardia, Echo - mitral valve thickening / prolapse / dysplasia with regurgitation, Fainting (syncope), Refuses to lie down / sits upright to breathe, Vomiting, Weight / muscle loss
  - **F**: Cold paws / extremities, Cough, Severe limb pain / crying out, Sudden hind-limb paralysis
  - dog overrides: Exercise intolerance=C, Fainting (syncope)=C, Collapse (sudden inability to stand)=D, Cough=D, Labored breathing (dyspnea)=D, Heart murmur=B, Systolic ejection murmur, left base (aortic/pulmonic area)=C, ECG - ventricular premature complexes / ventricular tachycardia=C

## Restrictive / unclassified cardiomyopathy  (کاردیومیوپاتی محدودشونده یا طبقه‌بندی‌نشده (RCM))

- id: `rcm_unclassified` - category: cardiomyopathy - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.05 / 12
- age multipliers: {'young': 0.2, 'adult': 0.8, 'senior': 1.4}  - breed: None
- note: Cats presenting with congestive failure and giant atria but only mild/no LV wall thickening. Dogs: extremely rare.
- confirm with: Echocardiography (marked biatrial enlargement, restrictive filling, endomyocardial scar); NT-proBNP; Thoracic radiographs
- sources: acvim_feline_cm_2020, ettinger_2017

  - **A**: Echo - left atrial enlargement (LA:Ao increased), Echo - marked biatrial enlargement with restrictive filling, near-normal LV walls
  - **B**: Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Lethargy / reduced activity, NT-proBNP elevated, Radiograph - generalized cardiomegaly (VHS above normal), Radiograph - left atrial enlargement
  - **C**: Decreased appetite, Gallop rhythm (S3/S4), Panting / open-mouth breathing at rest, Pleural effusion (muffled ventral lung sounds / confirmed)
  - **D**: Cardiac troponin I elevated, ECG - ventricular premature complexes / ventricular tachycardia, Heart murmur, Irregular heart rhythm, Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Systolic murmur, left apex (mitral area), Weight / muscle loss
  - **E**: ECG - atrial fibrillation, Echo - LV wall thickening (hypertrophy), Fainting (syncope), Vomiting
  - **F**: Cough, Sudden hind-limb paralysis

## Arrhythmogenic right ventricular cardiomyopathy (Boxer cardiomyopathy)  (کاردیومیوپاتی آریتموژنیک بطن راست (بیماری قلبی باکسر))

- id: `arvc` - category: cardiomyopathy - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.2 / 0.1
- age multipliers: {'young': 0.1, 'adult': 1.3, 'senior': 0.9}  - breed: {'dog': {'boxer': 45.0, 'brachycephalic': 2.0, 'doberman': 0.5, 'small_toy': 0.03, 'medium': 0.1, 'cavalier': 0.03, 'large': 0.3, 'giant': 0.05}}
- note: Syncope/collapse + ventricular ectopy in a Boxer (or English Bulldog) with a possibly normal heart on auscultation/echo.
- confirm with: 24-h Holter (>=300 VPC/24h or couplets/triplets); Echocardiography (LV function); Troponin; PDK4 genotype (Boxer)
- sources: ettinger_2017, kittleson_1998, smith_manual_2015

  - **A**: ECG - ventricular premature complexes / ventricular tachycardia
  - **B**: Fainting (syncope), Irregular heart rhythm
  - **C**: Cardiac troponin I elevated, Exercise intolerance, Family history of heart disease / sudden death, Generalised weakness, NT-proBNP elevated
  - **D**: Collapse (sudden inability to stand), Cough, Echo - dilated LV with reduced systolic function, Fast resting/sleeping breathing rate, Heart murmur, Labored breathing (dyspnea), Lethargy / reduced activity, Radiograph - generalized cardiomegaly (VHS above normal), Systolic ejection murmur, left base (aortic/pulmonic area), Tachycardia, Weak or deficient pulses
  - **E**: Echo - left atrial enlargement (LA:Ao increased), Pale gums, Swollen abdomen (ascites), Systolic murmur, left apex (mitral area)

## Thyrotoxic heart disease (hyperthyroid cardiomyopathy, cats)  (بیماری قلبی ناشی از پرکاری تیروئید (گربه))

- id: `thyrotoxic_cm` - category: systemic_cardiac - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.0 / 5
- age multipliers: {'young': 0.0, 'adult': 0.15, 'senior': 2.4}  - breed: None
- note: Weight loss + ravenous appetite + tachycardia/murmur in an older cat. Cardiac changes are often reversible after euthyroidism.
- confirm with: Total T4 (+ free T4 if borderline); BP; Echocardiography (re-evaluate after euthyroid); Renal panel (masked CKD)
- sources: ettinger_2017, acvim_feline_cm_2020

  - **A**: Tachycardia, Total T4 elevated, Weight / muscle loss
  - **B**: Increased appetite, Palpable thyroid nodule (cat)
  - **C**: Cardiac troponin I elevated, Echo - LV wall thickening (hypertrophy), Heart murmur, Increased drinking and urination, NT-proBNP elevated, Restlessness, especially at night, Systolic murmur, left apex (mitral area), Vomiting
  - **D**: Azotemia (increased creatinine/BUN), Echo - left atrial enlargement (LA:Ao increased), Fast resting/sleeping breathing rate, Gallop rhythm (S3/S4), Irregular heart rhythm, Radiograph - generalized cardiomegaly (VHS above normal), Systolic blood pressure >160 mmHg (repeatable), Systolic ejection murmur, left base (aortic/pulmonic area)
  - **E**: Decreased appetite, ECG - ventricular premature complexes / ventricular tachycardia, Labored breathing (dyspnea), Lethargy / reduced activity, Panting / open-mouth breathing at rest

## Systemic hypertension with cardiac / target-organ damage  (فشار خون سیستمیک با درگیری قلب و ارگان‌های هدف)

- id: `hypertensive_hd` - category: systemic_cardiac - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.2 / 6
- age multipliers: {'young': 0.03, 'adult': 0.35, 'senior': 2.2}  - breed: None
- note: Usually secondary (CKD, hyperthyroidism, hyperadrenocorticism, diabetes). Sudden blindness/retinal detachment is a classic presentation in cats.
- confirm with: Repeated BP (Doppler/oscillometric); Fundic exam; Renal panel + urinalysis (UPC); T4 (cats); Cushing's screening (dogs)
- sources: acvim_htn_2018, ettinger_2017

  - **A**: Systolic blood pressure >160 mmHg (repeatable)
  - **B**: Retinal hemorrhage / detachment
  - **C**: Azotemia (increased creatinine/BUN), Echo - LV wall thickening (hypertrophy), Increased drinking and urination, Sudden blindness / dilated pupils
  - **D**: Decreased appetite, Gallop rhythm (S3/S4), Generalised weakness, Heart murmur, Lethargy / reduced activity, NT-proBNP elevated, Seizure-like episodes, Systolic murmur, left apex (mitral area), Total T4 elevated, Weight / muscle loss
  - **E**: Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Radiograph - generalized cardiomegaly (VHS above normal)

## Myocarditis  (میوکاردیت)

- id: `myocarditis` - category: inflammatory - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.4 / 0.3
- age multipliers: {'young': 2.5, 'adult': 1.0, 'senior': 0.4}  - breed: None
- note: Acute arrhythmia + raised troponin after an infection (parvovirus puppies, Chagas disease, sepsis, toxins).
- confirm with: Troponin I; ECG/Holter; Echocardiography; Infectious work-up (Trypanosoma cruzi, Bartonella, Borrelia, parvovirus history); CBC
- sources: ettinger_2017, kittleson_1998

  - **B**: Cardiac troponin I elevated, ECG - ventricular premature complexes / ventricular tachycardia, Irregular heart rhythm, Lethargy / reduced activity
  - **C**: Decreased appetite, Exercise intolerance, Fever, Generalised weakness, NT-proBNP elevated, Tachycardia
  - **D**: Collapse (sudden inability to stand), Echo - dilated LV with reduced systolic function, Fainting (syncope), Fast resting/sleeping breathing rate, Heart murmur, Labored breathing (dyspnea), Recent source of infection (dental, skin, urinary, discospondylitis)
  - **E**: Cough, ECG - high-grade 2nd/3rd-degree AV block, Gallop rhythm (S3/S4), Pale gums, Weak or deficient pulses

## Pericardial effusion / cardiac tamponade  (افیوژن پریکارد و تامپوناد قلبی)

- id: `pericardial_effusion` - category: pericardial - urgency: **emergency** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 3.0 / 1.5
- age multipliers: {'young': 0.1, 'adult': 0.7, 'senior': 1.8}  - breed: {'dog': {'large': 2.5, 'giant': 1.5, 'boxer': 1.2, 'brachycephalic': 1.2, 'small_toy': 0.5, 'cavalier': 0.4}}
- note: Dog: idiopathic vs neoplastic (RA hemangiosarcoma, heart-base tumor). Cat: secondary to CHF, FIP, lymphoma, infection.
- confirm with: Echocardiography / point-of-care ultrasound (effusion, RA/heart-base mass); Thoracic radiographs; Pericardiocentesis (therapeutic; fluid analysis); Coagulation screen
- sources: ettinger_2017, kittleson_1998, smith_manual_2015

  - **A**: Echo - pericardial effusion
  - **B**: Collapse (sudden inability to stand), Exercise intolerance, Generalised weakness, Lethargy / reduced activity, Muffled heart sounds, Radiograph - globoid cardiac silhouette, Tachycardia
  - **C**: Decreased appetite, ECG - low voltage / electrical alternans, Fainting (syncope), Fast resting/sleeping breathing rate, Jugular distension / pulsation, Labored breathing (dyspnea), Pale gums, Radiograph - generalized cardiomegaly (VHS above normal), Swollen abdomen (ascites), Weak or deficient pulses
  - **D**: Cold paws / extremities, Cough, Echo - right atrial / heart-base / myocardial mass, Irregular heart rhythm, Pleural effusion (muffled ventral lung sounds / confirmed), Vomiting
  - cat overrides: Labored breathing (dyspnea)=B, Fast resting/sleeping breathing rate=B, Lethargy / reduced activity=B, Decreased appetite=B, Swollen abdomen (ascites)=E, Collapse (sudden inability to stand)=D, Muffled heart sounds=C, Pleural effusion (muffled ventral lung sounds / confirmed)=C, Cough=F

## Pericarditis (infectious / constrictive)  (پریکاردیت)

- id: `pericarditis` - category: pericardial - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.2 / 0.1
- age multipliers: {'young': 0.5, 'adult': 1.3, 'senior': 0.9}  - breed: None
- note: Rare. Consider after penetrating injury, foreign body, or systemic infection; constrictive forms behave like right-sided failure with a small heart.
- confirm with: Echocardiography (thickened/fibrinous pericardium, effusion); Pericardial fluid cytology + culture; Chest radiographs (foreign body, migrating grass awn)
- sources: ettinger_2017

  - **B**: Echo - pericardial effusion, Lethargy / reduced activity
  - **C**: Decreased appetite, Exercise intolerance, Fever, Jugular distension / pulsation, Swollen abdomen (ascites), Tachycardia
  - **D**: ECG - low voltage / electrical alternans, Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Muffled heart sounds, Radiograph - globoid cardiac silhouette, Recent source of infection (dental, skin, urinary, discospondylitis)

## Heart-base tumor (chemodectoma)  (تومور قاعدهٔ قلب (کموده‌کتوما))

- id: `heart_base_tumor` - category: neoplastic - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.7 / 0.05
- age multipliers: {'young': 0.0, 'adult': 0.4, 'senior': 2.4}  - breed: {'dog': {'boxer': 5.0, 'brachycephalic': 8.0, 'small_toy': 0.4, 'large': 0.8, 'medium': 0.7}}
- note: Brachycephalic/Boxer, older; slow-growing mass at the aortic root. Right-sided signs from effusion rather than from the mass itself.
- confirm with: Echocardiography (aortic-body mass at heart base); CT; Pericardiocentesis / pericardiectomy discussion
- sources: ettinger_2017, kittleson_1998

  - **B**: Echo - pericardial effusion, Echo - right atrial / heart-base / myocardial mass
  - **C**: Exercise intolerance, Generalised weakness, Jugular distension / pulsation, Lethargy / reduced activity, Muffled heart sounds, Radiograph - globoid cardiac silhouette, Swollen abdomen (ascites)
  - **D**: Collapse (sudden inability to stand), Cough, Decreased appetite, ECG - low voltage / electrical alternans, Fainting (syncope), Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Pleural effusion (muffled ventral lung sounds / confirmed), Weak or deficient pulses

## Right atrial hemangiosarcoma  (همانژیوسارکوم دهلیز راست)

- id: `ra_hemangiosarcoma` - category: neoplastic - urgency: **emergency** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.2 / 0.05
- age multipliers: {'young': 0.0, 'adult': 0.3, 'senior': 2.5}  - breed: {'dog': {'large': 2.5, 'giant': 1.2, 'small_toy': 0.3, 'brachycephalic': 0.3, 'cavalier': 0.2}}
- note: Older large-breed dog (GSD, Golden) with sudden collapse, pale gums, tamponade physiology.
- confirm with: Echocardiography (RA/auricular mass + hemorrhagic effusion); Abdominal ultrasound (splenic/liver masses); CBC (regenerative anemia, thrombocytopenia); Thoracic radiographs (metastases)
- sources: ettinger_2017

  - **A**: Echo - pericardial effusion
  - **B**: Anemia (low PCV/hematocrit), Collapse (sudden inability to stand), Echo - right atrial / heart-base / myocardial mass, Generalised weakness, Lethargy / reduced activity, Pale gums, Radiograph - globoid cardiac silhouette, Tachycardia, Weak or deficient pulses
  - **C**: Cardiac troponin I elevated, Decreased appetite, Exercise intolerance, Fast resting/sleeping breathing rate, Jugular distension / pulsation, Labored breathing (dyspnea), Muffled heart sounds, Swollen abdomen (ascites)
  - **D**: Cold paws / extremities, ECG - low voltage / electrical alternans, ECG - ventricular premature complexes / ventricular tachycardia, Fainting (syncope), Irregular heart rhythm

## Cardiac lymphoma / infiltrative neoplasia  (لنفوم قلبی)

- id: `cardiac_lymphoma` - category: neoplastic - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.1 / 1.0
- age multipliers: {'young': 0.15, 'adult': 0.7, 'senior': 1.8}  - breed: None
- note: Cats (FeLV-negative older cats too): thickened myocardium that does not behave like HCM + effusion + systemic signs.
- confirm with: Echocardiography; Thoracic/abdominal imaging (mediastinal mass, lymph nodes); Cytology of effusion/FNA
- sources: ettinger_2017

  - **B**: Decreased appetite, Lethargy / reduced activity
  - **C**: Cardiac troponin I elevated, Echo - pericardial effusion, Echo - right atrial / heart-base / myocardial mass, Fast resting/sleeping breathing rate, Labored breathing (dyspnea), NT-proBNP elevated, Pleural effusion (muffled ventral lung sounds / confirmed), Weight / muscle loss
  - **D**: Anemia (low PCV/hematocrit), Azotemia (increased creatinine/BUN), ECG - ventricular premature complexes / ventricular tachycardia, Echo - LV wall thickening (hypertrophy), Irregular heart rhythm, Pale gums, Radiograph - generalized cardiomegaly (VHS above normal), Vomiting

## Heartworm disease (dirofilariasis, incl. caval syndrome)  (دیروفیلاریوز (کرم قلب))

- id: `heartworm` - category: parasitic - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 3.0 / 1.0
- age multipliers: {'young': 0.25, 'adult': 1.4, 'senior': 0.8}  - breed: {'dog': {'large': 1.4, 'medium': 1.1, 'small_toy': 0.8}}
- note: Prior depends strongly on geography/prophylaxis (answer the exposure question carefully). Dark urine + collapse + hemoglobinuria = caval syndrome (emergency).
- confirm with: Antigen test + microfilaria test (Knott/filter); Thoracic radiographs; Echocardiography (caval syndrome: worms in RA/RV); Wolbachia-directed therapy planning
- sources: ahs_guidelines, ettinger_2017

  - **A**: Cough, Heartworm antigen / microfilaria positive, Heartworm exposure (endemic area without prevention, or positive test)
  - **B**: Exercise intolerance, Radiograph - enlarged/tortuous pulmonary arteries
  - **C**: Decreased appetite, Echo - RV hypertrophy / dilation, septal flattening, Echo - tricuspid regurgitation velocity >3.4 m/s (pulmonary hypertension), Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Lethargy / reduced activity, Radiograph - right heart enlargement (reverse-D), Weight / muscle loss
  - **D**: Anemia (low PCV/hematocrit), Coughing up blood, Echo - heartworms visible (pulmonary artery / right heart), Jugular distension / pulsation, Swollen abdomen (ascites), Systolic murmur, right side (tricuspid area)
  - **E**: Collapse (sudden inability to stand), Dark red/brown urine, Fainting (syncope), Pale gums
  - cat overrides: Heartworm exposure (endemic area without prevention, or positive test)=B, Heartworm antigen / microfilaria positive=D, Cough=C, Labored breathing (dyspnea)=C, Vomiting=C, Lethargy / reduced activity=C, Weight / muscle loss=C, Collapse (sudden inability to stand)=D, Exercise intolerance=E, Panting / open-mouth breathing at rest=D, Swollen abdomen (ascites)=F, Jugular distension / pulsation=F, Systolic murmur, right side (tricuspid area)=F, Echo - heartworms visible (pulmonary artery / right heart)=E

## Pulmonary hypertension (incl. cor pulmonale)  (هیپرتانسیون ریوی (شامل کور پولمونال))

- id: `pulmonary_hypertension` - category: pulmonary_vascular - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 2.5 / 0.4
- age multipliers: {'young': 0.3, 'adult': 0.8, 'senior': 1.5}  - breed: {'dog': {'small_toy': 2.0, 'medium': 0.9, 'large': 0.7, 'giant': 0.4}}
- note: Usually secondary (left heart disease, chronic airway/lung disease, heartworm, thromboembolism). Treat the cause; exertional syncope is a classic sign.
- confirm with: Echocardiography (TR velocity, RV, PA:Ao, septal flattening); Thoracic radiographs/CT (underlying lung disease); Heartworm test; Search for left heart disease/thromboembolic source
- sources: acvim_ph_2020, ettinger_2017

  - **A**: Echo - tricuspid regurgitation velocity >3.4 m/s (pulmonary hypertension)
  - **B**: Echo - RV hypertrophy / dilation, septal flattening, Exercise intolerance
  - **C**: Cough, Fainting (syncope), Fast resting/sleeping breathing rate, Generalised weakness, Heart murmur, Labored breathing (dyspnea), Lethargy / reduced activity, Radiograph - enlarged/tortuous pulmonary arteries, Radiograph - right heart enlargement (reverse-D), Systolic murmur, right side (tricuspid area)
  - **D**: Blue/purple gums or tongue (cyanosis), Collapse (sudden inability to stand), Decreased appetite, Heartworm exposure (endemic area without prevention, or positive test), Jugular distension / pulsation, NT-proBNP elevated, Radiograph - bronchial / airway pattern, Swollen abdomen (ascites), Thrombosis-predisposing condition, Weight / muscle loss
  - **E**: Coughing up blood
  - **F**: Secondary polycythemia (PCV >65%)

## Pulmonary thromboembolism  (ترومبوآمبولی ریوی)

- id: `pulmonary_thromboembolism` - category: pulmonary_vascular - urgency: **emergency** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.6 / 0.3
- age multipliers: {'young': 0.2, 'adult': 0.9, 'senior': 1.4}  - breed: None
- note: Sudden-onset dyspnea with relatively clear radiographs in an animal with a clot-predisposing condition.
- confirm with: Thoracic radiographs (often disproportionately normal); Echocardiography; CT pulmonary angiography; D-dimer / TEG; Search for predisposing disease (IMHA, PLN, Cushing's, neoplasia)
- sources: ettinger_2017

  - **A**: Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Thrombosis-predisposing condition
  - **B**: Lethargy / reduced activity, Panting / open-mouth breathing at rest, Tachycardia
  - **C**: Anemia (low PCV/hematocrit), Restlessness, especially at night
  - **D**: Blue/purple gums or tongue (cyanosis), Collapse (sudden inability to stand), Cough, Echo - RV hypertrophy / dilation, septal flattening, Echo - tricuspid regurgitation velocity >3.4 m/s (pulmonary hypertension), NT-proBNP elevated
  - **E**: Coughing up blood, Fainting (syncope), Fever, Pale gums

## Patent ductus arteriosus (PDA)  (مجرای شریانی باز (PDA))

- id: `pda` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.5 / 0.4
- age multipliers: {'young': 4.0, 'adult': 0.5, 'senior': 0.05}  - breed: {'dog': {'small_toy': 2.2, 'medium': 0.9, 'large': 0.5, 'giant': 0.4, 'cavalier': 0.5}}
- note: Young dog with a continuous machinery murmur and bounding pulses. Time-critical: surgical/interventional closure before Eisenmenger reversal.
- confirm with: Echocardiography/Doppler (continuous flow into main PA); Thoracic radiographs (ductal bump, LA/LV enlargement); Early closure (coil/occluder/ligation) planning before CHF or reversal
- sources: ettinger_2017, kittleson_1998, smith_manual_2015

  - **A**: Continuous ("machinery") murmur, left base, Echo - continuous retrograde flow in pulmonary artery (PDA), Heart murmur
  - **B**: Bounding (hyperdynamic) pulses, Echo - left atrial enlargement (LA:Ao increased), Exercise intolerance, Radiograph - generalized cardiomegaly (VHS above normal)
  - **C**: Cough, Fast resting/sleeping breathing rate, Labored breathing (dyspnea), NT-proBNP elevated, Radiograph - left atrial enlargement
  - **D**: Family history of heart disease / sudden death, Gallop rhythm (S3/S4), Generalised weakness, Irregular heart rhythm, Lethargy / reduced activity, Poor growth (young animals), Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Systolic murmur, left apex (mitral area)
  - **E**: Echo - dilated LV with reduced systolic function

## Pulmonic stenosis (valvular / dysplasia)  (تنگی دریچهٔ ریوی (شامل دیسپلازی دریچهٔ ریوی))

- id: `pulmonic_stenosis` - category: congenital - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.5 / 0.3
- age multipliers: {'young': 3.0, 'adult': 1.0, 'senior': 0.2}  - breed: {'dog': {'brachycephalic': 6.0, 'boxer': 3.0, 'small_toy': 1.5, 'medium': 1.0, 'large': 0.6, 'giant': 0.2, 'cavalier': 0.5}}
- note: Young Bulldog/Boxer/terrier with a left basilar systolic ejection murmur. Many dogs are asymptomatic until severe.
- confirm with: Doppler echocardiography (pressure gradient: mild <50, moderate 50-80, severe >80 mmHg); Coronary artery anomaly screening in bulldogs (before balloon valvuloplasty)
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - pulmonic outflow obstruction (high gradient), Heart murmur, Systolic ejection murmur, left base (aortic/pulmonic area)
  - **B**: Echo - RV hypertrophy / dilation, septal flattening
  - **C**: Exercise intolerance, Fainting (syncope), Radiograph - right heart enlargement (reverse-D)
  - **D**: Collapse (sudden inability to stand), Family history of heart disease / sudden death, Generalised weakness, Jugular distension / pulsation, Lethargy / reduced activity, Radiograph - generalized cardiomegaly (VHS above normal), Swollen abdomen (ascites), Systolic murmur, right side (tricuspid area)
  - **E**: ECG - ventricular premature complexes / ventricular tachycardia, Poor growth (young animals)

## Subaortic (aortic) stenosis  (تنگی زیر دریچه‌ای آئورت (SAS))

- id: `subaortic_stenosis` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.5 / 0.5
- age multipliers: {'young': 3.0, 'adult': 1.0, 'senior': 0.15}  - breed: {'dog': {'large': 3.0, 'giant': 2.2, 'boxer': 5.0, 'medium': 0.9, 'small_toy': 0.3, 'brachycephalic': 0.6, 'cavalier': 0.3}}
- note: Golden Retriever/Newfoundland/Boxer: murmur may be soft in young dogs; exertional syncope or sudden death are the major risks.
- confirm with: Doppler echocardiography (aortic velocity; >4.5 m/s severe in dogs); Holter in moderate-severe cases; Endocarditis awareness (dental prophylaxis)
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - subvalvular / valvular aortic outflow obstruction, Heart murmur, Systolic ejection murmur, left base (aortic/pulmonic area)
  - **B**: Echo - LV wall thickening (hypertrophy)
  - **C**: Exercise intolerance, Fainting (syncope), Family history of heart disease / sudden death
  - **D**: Collapse (sudden inability to stand), Cough, ECG - ventricular premature complexes / ventricular tachycardia, Echo - left atrial enlargement (LA:Ao increased), Fast resting/sleeping breathing rate, Generalised weakness, Irregular heart rhythm, Labored breathing (dyspnea), Radiograph - generalized cardiomegaly (VHS above normal), Systolic murmur, left apex (mitral area), Weak or deficient pulses
  - **E**: Lethargy / reduced activity

## Ventricular septal defect (VSD)  (نقص دیوارهٔ بین‌بطنی (VSD))

- id: `vsd` - category: congenital - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.4 / 1.2
- age multipliers: {'young': 3.0, 'adult': 0.6, 'senior': 0.1}  - breed: None
- note: Soft right-sided holosystolic murmur in a young dog/cat (small restrictive defects are often benign).
- confirm with: Echocardiography/Doppler (defect size, shunt direction; restrictive vs non-restrictive); Serial reassessment for reversal
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - ventricular or atrial septal defect with shunt flow, Heart murmur
  - **B**: Systolic murmur, right side (tricuspid area)
  - **C**: Echo - left atrial enlargement (LA:Ao increased), Exercise intolerance
  - **D**: Cough, Family history of heart disease / sudden death, Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Lethargy / reduced activity, NT-proBNP elevated, Poor growth (young animals), Radiograph - generalized cardiomegaly (VHS above normal), Radiograph - left atrial enlargement, Systolic ejection murmur, left base (aortic/pulmonic area), Systolic murmur, left apex (mitral area)

## Atrial septal defect / patent foramen ovale  (نقص دیوارهٔ بین‌دهلیزی (ASD / PFO))

- id: `asd` - category: congenital - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.3 / 0.3
- age multipliers: {'young': 2.5, 'adult': 1.0, 'senior': 0.3}  - breed: None
- note: Soft left-basilar systolic flow murmur (relative PS) due to increased right-sided flow. Often an incidental finding.
- confirm with: Echocardiography with color Doppler and bubble study; Exclude pulmonary hypertension/reversal
- sources: ettinger_2017

  - **A**: Echo - ventricular or atrial septal defect with shunt flow
  - **B**: Heart murmur, Systolic ejection murmur, left base (aortic/pulmonic area)
  - **C**: Echo - RV hypertrophy / dilation, septal flattening, Radiograph - right heart enlargement (reverse-D)
  - **D**: Exercise intolerance, Systolic murmur, right side (tricuspid area)
  - **E**: Cough, Fainting (syncope), Fast resting/sleeping breathing rate, Labored breathing (dyspnea), Swollen abdomen (ascites)

## Tetralogy of Fallot  (تترالوژی فالو)

- id: `tof` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.2 / 0.15
- age multipliers: {'young': 4.0, 'adult': 0.4, 'senior': 0.02}  - breed: {'dog': {'brachycephalic': 4.0, 'medium': 1.5, 'small_toy': 1.2, 'large': 0.4, 'giant': 0.2}}
- note: Young dog (Keeshond, English Bulldog) with exertional cyanosis/collapse and a pulmonic stenosis-type murmur.
- confirm with: Echocardiography with bubble study; PCV (polycythemia); Pulse oximetry/blood gas
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - right-to-left shunting (bubble study / Doppler), Exercise intolerance, Heart murmur, Systolic ejection murmur, left base (aortic/pulmonic area)
  - **B**: Blue/purple gums or tongue (cyanosis), Echo - RV hypertrophy / dilation, septal flattening, Echo - pulmonic outflow obstruction (high gradient), Echo - ventricular or atrial septal defect with shunt flow, Radiograph - right heart enlargement (reverse-D), Secondary polycythemia (PCV >65%)
  - **C**: Collapse (sudden inability to stand), Fainting (syncope), Generalised weakness, Labored breathing (dyspnea), Lethargy / reduced activity, Poor growth (young animals)
  - **D**: Family history of heart disease / sudden death, Fast resting/sleeping breathing rate, Seizure-like episodes

## Reversed (right-to-left) shunt / Eisenmenger physiology  (شانت معکوس (فیزیولوژی آیزنمنگر))

- id: `reversed_shunt` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.2 / 0.1
- age multipliers: {'young': 1.8, 'adult': 1.1, 'senior': 0.3}  - breed: None
- note: Young adult with exertional collapse, cyanosis (sometimes only caudal body in reversed PDA), polycythemia and often a quiet/absent murmur.
- confirm with: Echocardiography + bubble study; PCV (polycythemia); Pre/post-ductal oxygen saturation (differential cyanosis); Phlebotomy for symptomatic polycythemia
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - right-to-left shunting (bubble study / Doppler), Exercise intolerance, Secondary polycythemia (PCV >65%)
  - **B**: Blue/purple gums or tongue (cyanosis), Echo - RV hypertrophy / dilation, septal flattening, Echo - tricuspid regurgitation velocity >3.4 m/s (pulmonary hypertension)
  - **C**: Collapse (sudden inability to stand), Echo - ventricular or atrial septal defect with shunt flow, Fainting (syncope), Generalised weakness, Lethargy / reduced activity, Radiograph - right heart enlargement (reverse-D)
  - **D**: Echo - continuous retrograde flow in pulmonary artery (PDA), Fast resting/sleeping breathing rate, Heart murmur, Labored breathing (dyspnea), Poor growth (young animals), Radiograph - enlarged/tortuous pulmonary arteries, Seizure-like episodes
  - **E**: Cough

## Tricuspid valve dysplasia (incl. Ebstein-type malformation)  (دیسپلازی دریچهٔ تری‌کاسپید (آنومالی ابشتاین))

- id: `tvd` - category: congenital - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.8 / 0.5
- age multipliers: {'young': 3.0, 'adult': 1.0, 'senior': 0.2}  - breed: {'dog': {'large': 3.0, 'giant': 1.0, 'medium': 1.0, 'small_toy': 0.4, 'brachycephalic': 0.5, 'boxer': 1.0}}
- note: Large-breed dog (Labrador) with right-sided congestive failure early in life; ascites and a right apical systolic murmur.
- confirm with: Echocardiography (displaced/tethered septal leaflet, RA size); Abdominal ultrasound (ascites/hepatic congestion); ECG (WPW)
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - tricuspid valve dysplasia / displaced leaflets with severe right atrial enlargement, Heart murmur, Systolic murmur, right side (tricuspid area)
  - **B**: Radiograph - generalized cardiomegaly (VHS above normal), Swollen abdomen (ascites)
  - **C**: Exercise intolerance, Generalised weakness, Jugular distension / pulsation, Lethargy / reduced activity, Radiograph - right heart enlargement (reverse-D)
  - **D**: Decreased appetite, Family history of heart disease / sudden death, Fast resting/sleeping breathing rate, Irregular heart rhythm, Labored breathing (dyspnea), Pleural effusion (muffled ventral lung sounds / confirmed), Poor growth (young animals), Weight / muscle loss
  - **E**: ECG - atrial fibrillation, ECG - supraventricular tachycardia, Fainting (syncope)

## Mitral valve dysplasia (congenital)  (دیسپلازی مادرزادی دریچهٔ میترال)

- id: `mitral_dysplasia` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.4 / 2.0
- age multipliers: {'young': 3.0, 'adult': 1.0, 'senior': 0.2}  - breed: {'dog': {'large': 3.0, 'giant': 3.0, 'boxer': 1.0, 'small_toy': 0.3, 'medium': 0.8}}
- note: Young large-breed dog (Bull Terrier, GSD, Great Dane) or young cat with an apical systolic murmur and left atrial enlargement.
- confirm with: Echocardiography (leaflet/chordal anomalies, regurgitation severity, LA)
- sources: ettinger_2017, kittleson_1998

  - **A**: Echo - mitral valve thickening / prolapse / dysplasia with regurgitation, Heart murmur, Systolic murmur, left apex (mitral area)
  - **B**: Echo - left atrial enlargement (LA:Ao increased), Radiograph - generalized cardiomegaly (VHS above normal), Radiograph - left atrial enlargement
  - **C**: Cough, Exercise intolerance, Fast resting/sleeping breathing rate, NT-proBNP elevated
  - **D**: Family history of heart disease / sudden death, Gallop rhythm (S3/S4), Irregular heart rhythm, Labored breathing (dyspnea), Lethargy / reduced activity, Poor growth (young animals), Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema
  - cat overrides: Labored breathing (dyspnea)=B, Panting / open-mouth breathing at rest=C, Cough=F, Pleural effusion (muffled ventral lung sounds / confirmed)=D, Fast resting/sleeping breathing rate=B

## Cor triatriatum dexter  (کور تریاتریاتوم دکستر)

- id: `cor_triatriatum` - category: congenital - urgency: **routine** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.15 / 0.05
- age multipliers: {'young': 4.0, 'adult': 0.5, 'senior': 0.05}  - breed: {'dog': {'large': 2.0, 'giant': 1.5, 'small_toy': 0.3}}
- note: Young large-breed dog with unexplained ascites and no (or only a soft) murmur.
- confirm with: Echocardiography (membrane across the right atrium); Ascites fluid analysis (modified transudate)
- sources: ettinger_2017

  - **A**: Echo - membrane dividing the atrium (cor triatriatum), Swollen abdomen (ascites)
  - **C**: Exercise intolerance, Generalised weakness, Jugular distension / pulsation, Lethargy / reduced activity
  - **D**: Labored breathing (dyspnea), Pleural effusion (muffled ventral lung sounds / confirmed), Poor growth (young animals), Weight / muscle loss
  - **E**: Heart murmur, Systolic murmur, right side (tricuspid area)

## Vascular ring anomaly (persistent right aortic arch)  (حلقهٔ عروقی (قوس آئورت راست پایدار - PRAA))

- id: `prra` - category: congenital - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.5 / 0.1
- age multipliers: {'young': 6.0, 'adult': 0.1, 'senior': 0.01}  - breed: {'dog': {'large': 2.0, 'giant': 2.0, 'small_toy': 0.3, 'brachycephalic': 1.5}}
- note: Regurgitation from the time of weaning onto solid food in a puppy/kitten; not a primary cardiac disease but a great-vessel malformation.
- confirm with: Thoracic radiographs (megaesophagus cranial to heart base, aspiration pneumonia); Contrast esophagram; CT angiography; Surgical ligation of the ligamentum arteriosum
- sources: ettinger_2017

  - **A**: Regurgitation
  - **B**: Poor growth (young animals)
  - **C**: Cough, Weight / muscle loss
  - **D**: Decreased appetite, Difficulty swallowing, Fever, Labored breathing (dyspnea), Lethargy / reduced activity, Vomiting

## Atrial fibrillation  (فیبریلاسیون دهلیزی)

- id: `atrial_fibrillation` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 3.0 / 0.3
- age multipliers: {'young': 0.05, 'adult': 0.8, 'senior': 1.6}  - breed: {'dog': {'giant': 3.0, 'large': 1.8, 'doberman': 2.0, 'small_toy': 0.8, 'medium': 0.8}}
- note: Almost always secondary to atrial enlargement (DCM, MMVD) except 'lone AF' in giant breeds; list the underlying disease as well.
- confirm with: ECG (no P waves, irregularly irregular); Echocardiography for underlying disease (DCM / MMVD / lone AF in giants); Holter for rate control
- sources: ettinger_2017, kittleson_1998

  - **A**: ECG - atrial fibrillation, Irregular heart rhythm, Tachycardia
  - **B**: Echo - left atrial enlargement (LA:Ao increased), Exercise intolerance, Generalised weakness, Weak or deficient pulses
  - **C**: Heart murmur, Lethargy / reduced activity, NT-proBNP elevated, Radiograph - generalized cardiomegaly (VHS above normal)
  - **D**: Collapse (sudden inability to stand), Cough, Echo - dilated LV with reduced systolic function, Fainting (syncope), Fast resting/sleeping breathing rate, Labored breathing (dyspnea)
  - **E**: Gallop rhythm (S3/S4), Swollen abdomen (ascites)

## Ventricular arrhythmia (VPCs / ventricular tachycardia, secondary or primary)  (آریتمی‌های بطنی)

- id: `ventricular_arrhythmia` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 2.5 / 0.8
- age multipliers: {'young': 0.5, 'adult': 1.1, 'senior': 1.2}  - breed: {'dog': {'boxer': 1.5, 'doberman': 1.5, 'large': 1.2}}
- note: Ventricular ectopy is often secondary to systemic disease; structural disease (DCM, ARVC, myocarditis) should be excluded.
- confirm with: ECG/Holter; Echocardiography; Look for non-cardiac triggers (splenic mass, GDV, pancreatitis, hypoxia, electrolytes, drugs)
- sources: ettinger_2017, kittleson_1998

  - **A**: ECG - ventricular premature complexes / ventricular tachycardia, Irregular heart rhythm
  - **B**: Tachycardia
  - **C**: Exercise intolerance, Fainting (syncope), Generalised weakness, Weak or deficient pulses
  - **D**: Cardiac troponin I elevated, Collapse (sudden inability to stand), Heart murmur, Lethargy / reduced activity
  - **E**: Cough, Echo - dilated LV with reduced systolic function, Pale gums, Vomiting

## Supraventricular tachycardia  (تاکی‌کاردی فوق‌بطنی)

- id: `svt` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.0 / 0.4
- age multipliers: {'young': 1.2, 'adult': 1.1, 'senior': 0.7}  - breed: None
- note: Sustained rapid regular rhythm; accessory pathways (WPW) in young dogs; may cause tachycardia-induced cardiomyopathy.
- confirm with: ECG (regular narrow-complex tachycardia >250 bpm); Echocardiography (tachycardia-induced dysfunction); Vagal maneuvers / response to therapy
- sources: ettinger_2017

  - **A**: ECG - supraventricular tachycardia, Tachycardia
  - **C**: Exercise intolerance, Fainting (syncope), Fast resting/sleeping breathing rate, Generalised weakness, Lethargy / reduced activity, NT-proBNP elevated
  - **D**: Collapse (sudden inability to stand), Cough, Decreased appetite, Echo - dilated LV with reduced systolic function, Echo - left atrial enlargement (LA:Ao increased), Heart murmur, Labored breathing (dyspnea), Weak or deficient pulses
  - **E**: Irregular heart rhythm

## Sick sinus syndrome  (سندرم سینوس بیمار)

- id: `sss` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.2 / 0.1
- age multipliers: {'young': 0.02, 'adult': 0.6, 'senior': 2.0}  - breed: {'dog': {'small_toy': 3.0, 'cavalier': 0.8, 'medium': 0.6, 'large': 0.1, 'giant': 0.05, 'boxer': 0.2, 'doberman': 0.1, 'brachycephalic': 1.0}}
- note: Older small-breed dog (Miniature Schnauzer, West Highland, Cocker, Dachshund) with episodic syncope.
- confirm with: ECG/Holter (pauses >3 s, brady-tachy); Atropine response test; Pacemaker evaluation
- sources: ettinger_2017, kittleson_1998

  - **A**: ECG - sinus arrest / pauses / brady-tachy pattern, Fainting (syncope)
  - **B**: Bradycardia, Generalised weakness, Irregular heart rhythm
  - **C**: Collapse (sudden inability to stand), Exercise intolerance, Heart murmur, Systolic murmur, left apex (mitral area)
  - **D**: Cough, Lethargy / reduced activity, Seizure-like episodes, Weak or deficient pulses
  - **E**: ECG - high-grade 2nd/3rd-degree AV block, Tachycardia

## High-grade atrioventricular block  (بلوک دهلیزی-بطنی درجه بالا)

- id: `av_block` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 1.0 / 1.0
- age multipliers: {'young': 0.2, 'adult': 0.7, 'senior': 1.6}  - breed: None
- note: Syncope or exercise intolerance with a slow regular ventricular rate (often 30-60 bpm); myocarditis, fibrosis, drugs, Lyme/Chagas considered.
- confirm with: ECG (2nd-degree Mobitz II/3rd-degree AV block); Echocardiography (underlying myocardial disease); Electrolytes; Pacemaker evaluation
- sources: ettinger_2017, kittleson_1998

  - **A**: Bradycardia, ECG - high-grade 2nd/3rd-degree AV block
  - **B**: Exercise intolerance, Fainting (syncope), Generalised weakness
  - **C**: Collapse (sudden inability to stand), Irregular heart rhythm, Lethargy / reduced activity, Weak or deficient pulses
  - **D**: Decreased appetite, Heart murmur, Radiograph - generalized cardiomegaly (VHS above normal), Seizure-like episodes
  - **E**: Hyperkalemia, Labored breathing (dyspnea), Vomiting
  - cat overrides: Labored breathing (dyspnea)=D, Lethargy / reduced activity=B, Decreased appetite=C

## Atrial standstill (persistent or hyperkalemic)  (ایست دهلیزی)

- id: `atrial_standstill` - category: arrhythmia - urgency: **urgent** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.4 / 0.3
- age multipliers: {'young': 0.8, 'adult': 1.2, 'senior': 0.9}  - breed: {'dog': {'medium': 2.5, 'small_toy': 0.5, 'large': 0.5, 'giant': 0.1, 'boxer': 0.1}}
- note: Slow regular rhythm without P waves. Always check potassium first (hyperkalemia mimics persistent atrial standstill).
- confirm with: ECG (absent P waves, slow regular rhythm); Serum potassium (exclude Addison's / urinary obstruction); Echocardiography; Atrial myocardial dysfunction (English Springer Spaniel; ECG + echo)
- sources: ettinger_2017, kittleson_1998

  - **A**: Bradycardia, ECG - atrial standstill (no P waves, slow regular rhythm)
  - **B**: Generalised weakness, Lethargy / reduced activity
  - **C**: Collapse (sudden inability to stand), Decreased appetite, Exercise intolerance, Hyperkalemia, Vomiting
  - **D**: Fainting (syncope), Increased drinking and urination, Labored breathing (dyspnea), Weak or deficient pulses
  - **E**: Heart murmur

## Aortic (saddle) thromboembolism  (ترومبوآمبولی آئورت (لختهٔ زینی))

- id: `ate` - category: vascular - urgency: **emergency** - status: draft_ai_pending_vet_review
- relative prior dog/cat: 0.1 / 7
- age multipliers: {'young': 0.2, 'adult': 0.9, 'senior': 1.4}  - breed: None
- note: Cat with sudden hind-limb paresis/paralysis, cold pale paws, painful, absent femoral pulses; most have occult/overt cardiomyopathy.
- confirm with: Echocardiography (LA size, spontaneous echo contrast/thrombus); Thoracic radiographs (CHF); Blood glucose/lactate/potassium (reperfusion); Analgesia + management of underlying cardiomyopathy
- sources: smith_2003_ate, acvim_feline_cm_2020

  - **A**: Absent femoral pulse(s), Severe limb pain / crying out, Sudden hind-limb paralysis
  - **B**: Cold paws / extremities, Echo - left atrial enlargement (LA:Ao increased), Lethargy / reduced activity, NT-proBNP elevated
  - **C**: Decreased appetite, Echo - LV wall thickening (hypertrophy), Fast resting/sleeping breathing rate, Gallop rhythm (S3/S4), Generalised weakness, Heart murmur, Labored breathing (dyspnea), Panting / open-mouth breathing at rest
  - **D**: Collapse (sudden inability to stand), Irregular heart rhythm, Pleural effusion (muffled ventral lung sounds / confirmed), Pulmonary crackles, Radiograph - cardiogenic-pattern pulmonary edema, Vomiting
  - **E**: Blue/purple gums or tongue (cyanosis)
  - dog overrides: Severe limb pain / crying out=B, Sudden hind-limb paralysis=C, Absent femoral pulse(s)=B, Generalised weakness=B, Labored breathing (dyspnea)=D
