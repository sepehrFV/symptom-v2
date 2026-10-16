package msfv.original.enums;

public enum DiseaseTypeEnum {
    // === PRIMARY CARDIAC DISEASES ===
    CONGENITAL("Congenital Heart Disease",
            "Structural defects present at birth (e.g., PDA, VSD, SAS)"),

    VALVULAR("Valvular Heart Disease",
            "Degenerative or dysplastic valve disorders (e.g., MVD, TVD)"),

    PRIMARY_CARDIOMYOPATHY("Primary Cardiomyopathy",
            "Myocardial diseases without identifiable cause (e.g., HCM, DCM, RCM, ARVC)"),

    PERICARDIAL("Pericardial Disease",
            "Disorders of the pericardium (e.g., effusion, tamponade, constriction)"),

    // === SECONDARY CARDIAC DISEASES ===
    INFECTIOUS("Infectious Cardiac Disease",
            "Pathogen-induced cardiac damage (e.g., heartworm, endocarditis, myocarditis)"),

    THROMBOEMBOLIC("Thromboembolic Disease",
            "Thrombus formation/embolization causing ischemia (e.g., saddle thrombus, PE)"),

    VASCULAR("Vascular Disease",
            "Arterial/venous structural disorders (e.g., aneurysm, vasculitis, vascular rings)"),

    METABOLIC_ENDOCRINE("Metabolic/Endocrine Cardiac Disease",
            "Systemic disorders causing secondary cardiac effects (e.g., hyperthyroid-HCM, CKD-hypertension)"),

    // === ELECTRICAL DISORDERS ===
    ARRHYTHMIA("Primary Arrhythmia",
            "Electrical conduction abnormalities without structural disease (e.g., SSS, atrial standstill)"),

    // === NEOPLASTIC & SYSTEMIC ===
    NEOPLASTIC("Cardiac Neoplasia",
            "Primary or metastatic tumors affecting the heart (e.g., hemangiosarcoma, chemodectoma)"),

    HYPERTENSIVE("Hypertensive Heart Disease",
            "Cardiac changes secondary to systemic/pulmonary hypertension");

    private final String displayName;
    private final String description;

    DiseaseTypeEnum(String displayName, String description) {
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