package msfv.original.enums;

public enum SourceEnum {
    // === PRIMARY TEXTBOOKS (Gold Standard) ===
    ETTINGER_8TH_EDITION("Textbook of Veterinary Internal Medicine, 8th Edition (Ettinger & Feldman)",
            "Comprehensive reference for small animal diseases; cardiology chapters by leading specialists"),

    TILLEY_CARDIOLOGY("Cardiology of the Dog and Cat, 2nd Edition (Tilley, Smith, Oyama)",
            "Definitive cardiology textbook; evidence-based protocols for diagnosis and treatment"),

    PLUMBS_10TH_EDITION("Plumb's Veterinary Drug Handbook, 10th Edition (Donald Plumb)",
            "Authoritative drug dosing, indications, and contraindications for veterinary species"),

    // === PROFESSIONAL GUIDELINES (Highest Evidence Level) ===
    ACVIM_2019_MVD("ACVIM Consensus Guidelines: Diagnosis and Treatment of Myxomatous Mitral Valve Disease (2019)",
            "Standard-of-care staging and treatment for canine MVD"),

    ACVIM_2020_HCM("ACVIM Consensus Guidelines: Diagnosis of Hypertrophic Cardiomyopathy in Cats (2020)",
            "Evidence-based criteria for feline HCM diagnosis and management"),

    ISFM_2022("International Society of Feline Medicine (ISFM) Cardiology Guidelines (2022)",
            "Feline-specific protocols for hypertension, HCM, and thromboembolism"),

    // === OPEN-ACCESS PUBLIC SOURCES (For Thesis Reproducibility) ===
    MERCK_VET_MANUAL("Merck Veterinary Manual (Online, 2024 Edition)",
            "Freely accessible, peer-reviewed clinical summaries; used for disease definitions and key facts"),

    VIN_PUBLIC_LIBRARY("VIN Public Library (Veterinary Information Network)",
            "Open-access case reports and expert commentaries; used for rare disease insights"),

    IRANIAN_VET_JOURNAL("Iranian Veterinary Journal (Open Access)",
            "Peer-reviewed Persian/English publications on regional disease prevalence and management"),

    // === LEGACY/BACKUP (Used Sparingly) ===
    CURRENT_VETERINARY_THERAPY("Current Veterinary Therapy XV (2022)",
            "Updated therapeutic protocols; used for adjunctive treatments");

    private final String displayName;
    private final String description;

    SourceEnum(String displayName, String description) {
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