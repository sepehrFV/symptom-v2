package msfv.original.enums;

public enum SurgeryTypeEnum {
    CORRECTIVE("Corrective Surgery"), // Surgery to repair or correct a defect
    EXPLORATORY("Exploratory Surgery"), // Surgery to investigate a condition
    EMERGENCY("Emergency Surgery"), // Surgery performed in urgent situations
    ELECTIVE("Elective Surgery"), // Non-emergency surgeries that are planned in advance
    LASER("Laser Surgery"), // Use of laser technology for surgical procedures
    MINIMALLY_INVASIVE("Minimally Invasive Surgery"), // Techniques that reduce tissue damage
    ORTHOPEDIC("Orthopedic Surgery"), // Surgery related to bones and joints
    SOFT_TISSUE("Soft Tissue Surgery"); // Surgery involving soft tissues (e.g., skin, organs)

    private final String description;

    SurgeryTypeEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
