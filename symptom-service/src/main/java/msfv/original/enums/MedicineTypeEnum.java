package msfv.original.enums;

public enum MedicineTypeEnum {
    // === CARDIOVASCULAR SUBTYPES (Primary for your use case) ===
    DIURETIC("Diuretic", "Promotes fluid excretion to reduce preload in heart failure"),
    INODILATOR("Inodilator", "Enhances myocardial contractility and vasodilation (e.g., pimobendan)"),
    ACE_INHIBITOR("ACE Inhibitor", "Reduces afterload and slows cardiac remodeling in CHF"),
    ANTIARRHYTHMIC("Antiarrhythmic", "Controls abnormal heart rhythms (Classes I-IV)"),
    ANTICOAGULANT("Anticoagulant", "Prevents thrombus formation (e.g., clopidogrel, heparin)"),
    VASODILATOR("Vasodilator", "Dilates arteries/veins to reduce cardiac workload (e.g., amlodipine)"),
    CARDIAC_GLYCOSIDE("Cardiac Glycoside", "Increases contractility and controls ventricular rate in AF (e.g., digoxin)"),

    // === SUPPORTIVE THERAPIES ===
    ANTIBIOTIC("Antibiotic", "Treats bacterial infections (e.g., endocarditis, heartworm adjunct)"),
    ANTIPARASITIC("Antiparasitic", "Targets parasites (e.g., melarsomine for heartworm)"),
    ANALGESIC("Analgesic", "Manages pain (e.g., buprenorphine for saddle thrombus)"),
    NUTRITIONAL("Nutritional Supplement", "Corrects deficiencies (e.g., taurine for DCM)"),
    EMERGENCY("Emergency Drug", "Critical interventions (e.g., calcium gluconate for hyperkalemia)"),

    // === GENERAL CATEGORIES (For future expansion) ===
    STEROID_ANTI_INFLAMMATORY("Steroid Anti-Inflammatory", "Corticosteroids for inflammation (e.g., prednisone)"),
    NSAID_ANTI_INFLAMMATORY("NSAID Anti-Inflammatory", "Non-steroidal anti-inflammatories (use cautiously in cardiac patients)"),
    HORMONAL("Hormonal", "Endocrine disorder management (e.g., levothyroxine for hypothyroidism)"),
    ANTIFUNGAL("Antifungal", "Treats fungal infections"),
    NEUROLOGICAL("Neurological", "Affects nervous system function"),
    SEDATIVES("Sedatives", "For calming and procedural sedation"),
    TOPICAL("Topical", "Applied directly to skin/mucous membranes"),
    IMMUNOMODULATORS("Immunomodulators", "Modifies immune response"),
    OTHER("Other", "Medications not fitting other categories");

    private final String displayName;
    private final String description;

    MedicineTypeEnum(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }

    // For backward compatibility (if getDescription() was used externally)
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