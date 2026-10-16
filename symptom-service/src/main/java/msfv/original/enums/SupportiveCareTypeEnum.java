package msfv.original.enums;

public enum SupportiveCareTypeEnum {
    FLUIDS_AND_ELECTROLYTE_THERAPY("Fluids and Electrolyte Therapy"),
    OXYGEN_THERAPY("Oxygen Therapy"),
    PALLIATIVE_CARE("Palliative Care"),
    NUTRITIONAL_SUPPORT("Nutritional Support"), // For cases requiring specialized diets or supplements
    WOUND_CARE("Wound Care"), // Management of wounds and injuries
    PAIN_MANAGEMENT("Pain Management"), // Strategies for managing pain
    REHABILITATION("Rehabilitation"), // Recovery therapies post-injury or surgery
    MONITORING("Monitoring"), // Continuous assessment of vital signs and overall condition
    COMFORT_CARE("Comfort Care"); // General care to ensure the animal's comfort

    private final String description;

    SupportiveCareTypeEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
