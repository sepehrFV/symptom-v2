package msfv.original.enums;

public enum TreatmentTypeEnum {
    // === MEDICAL TREATMENTS (Drug-Based) ===
    PHARMACOLOGICAL("Pharmacological Therapy", "Medication-based treatment using cardiovascular drugs (e.g., furosemide, pimobendan)"),
    ANTICOAGULANT("Anticoagulant Therapy", "Medications to prevent thrombus formation (e.g., clopidogrel, enoxaparin)"),
    ANTIARRHYTHMIC("Antiarrhythmic Therapy", "Drugs to control abnormal heart rhythms (e.g., sotalol, diltiazem)"),
    NUTRITIONAL("Nutritional Supplementation", "Correction of deficiencies (e.g., taurine for DCM)"),

    // === PROCEDURAL TREATMENTS ===
    SURGICAL("Surgical Intervention", "Invasive procedures (e.g., PDA coil occlusion, pericardial window)"),
    INTERVENTIONAL("Interventional Procedure", "Minimally invasive techniques (e.g., balloon valvuloplasty, coil embolization)"),

    // === MONITORING & SUPPORTIVE CARE ===
    MONITORING("Monitoring Protocol", "Regular assessment without active treatment (e.g., asymptomatic HCM, PFO)"),
    SUPPORTIVE_CARE("Supportive Care", "Non-specific management to maintain comfort and function"),

    // === ACUTE & SPECIALTY CARE ===
    EMERGENCY("Emergency Intervention", "Life-saving procedures for critical conditions (e.g., pericardiocentesis, hyperkalemia protocol)"),
    PALLIATIVE("Palliative Care", "Symptom-focused management for terminal conditions (e.g., cardiac hemangiosarcoma)"),

    // === MISC (Minimal Use) ===
    HORMONAL("Hormonal Therapy", "Endocrine disorder management (e.g., levothyroxine for hypothyroidism)"),
    ANTIBIOTIC("Antibiotic Therapy", "Treatment of bacterial infections (e.g., endocarditis, heartworm adjunct)"),
    OTHER("Other", "Treatments not fitting other categories"),
    NSAID_ANTI_INFLAMMATORY("NSAID Anti-Inflammatory", "Non-steroidal anti-inflammatory drugs for pain and inflammation"),
    STEROID_ANTI_INFLAMMATORY("Steroid Anti-Inflammatory", "Corticosteroids for severe inflammation and immune modulation"),
    ;

    private final String displayName;
    private final String description;

    TreatmentTypeEnum(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }

    // For backward compatibility
    public String getDescription() {
        return description;
    }

    public String getDisplayName() {
        return displayName;
    }

    // Optional: Helper for UI display
    public String getLabel() {
        return displayName + " — " + description;
    }
}