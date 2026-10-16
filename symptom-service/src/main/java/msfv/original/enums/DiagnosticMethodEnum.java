package msfv.original.enums;
public enum DiagnosticMethodEnum {
    PHYSICAL_EXAMINATION("Physical Examination", "Auscultation, pulse assessment, JVD evaluation"),
    LABORATORY_TESTING("Laboratory Testing", "Blood/urine tests (e.g., NT-proBNP, troponin)"),
    IMAGING("Imaging Techniques", "Radiography, CT, MRI"),
    ECG("Electrocardiogram", "Electrical activity assessment for arrhythmias/conduction delays"),
    ECHO("Echocardiogram", "Gold standard for structural/functional cardiac assessment"),
    ANTIGEN_TEST("Antigen Testing", "Heartworm antigen detection"),
    MICROFILARIA_TEST("Microfilaria Testing", "Knott's test or filter for heartworm larvae"),
    CULTURE("Culture", "Bacterial/fungal cultures for endocarditis"),
    BIOPSY("Biopsy", "Endomyocardial or pericardial tissue sampling"),
    GENETIC_TESTING("Genetic Testing", "DNA tests for inherited cardiomyopathies (e.g., Boxer ARVC)"),
    NECROPSY("Necropsy", "Post-mortem examination for definitive diagnosis");

    private final String displayName;
    private final String description;

    DiagnosticMethodEnum(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public String getDisplayName() {
        return displayName;
    }
}
