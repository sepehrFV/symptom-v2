package msfv.original.enums;

public enum PhysicalTherapyTypeEnum {
    REHABILITATION_EXERCISE("Rehabilitation Exercise"),
    HYDROTHERAPY("Hydrotherapy"),
    ACUPUNCTURE("Acupuncture"),
    PHYSIOTHERAPY("Physiotherapy"), // General physiotherapy treatments
    MANUAL_THERAPY("Manual Therapy"), // Hands-on techniques to relieve pain and improve mobility
    ELECTROTHERAPY("Electrotherapy"), // Use of electrical energy for therapeutic purposes
    LASER_THERAPY("Laser Therapy"), // Use of laser light to promote healing
    MASSAGE_THERAPY("Massage Therapy"), // Therapeutic massage to relieve tension and improve circulation
    STRETCHING("Stretching"), // Specific stretching techniques to improve flexibility
    POSTURE_CORRECTION("Posture Correction"); // Techniques aimed at correcting posture

    private final String description;

    PhysicalTherapyTypeEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
