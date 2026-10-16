package msfv.original.enums;

public enum PreventionMethodEnum {

    VACCINATION("Vaccination"), // Administering vaccines to prevent infectious diseases
    DEWORMING("Deworming"), // Regular treatment to eliminate intestinal parasites
    FLEA_AND_TICK_PREVENTION("Flea and Tick Prevention"), // Preventive treatments to control fleas and ticks
    PROPER_NUTRITION("Proper Nutrition"), // Providing a balanced diet to maintain overall health
    ENVIRONMENTAL_MANAGEMENT("Environmental Management"), // Managing the living environment to minimize risks
    REGULAR_VET_CHECKUPS("Regular Vet Check-ups"), // Routine health examinations by a veterinarian
    HYGIENE("Hygiene"), // Maintaining cleanliness to prevent infections
    QUARANTINE("Quarantine"), // Isolating new or sick animals to prevent disease spread
    TRAINING("Training"), // Behavior training to prevent accidents or injuries
    STRESS_MANAGEMENT("Stress Management"), // Techniques to reduce stress in animals, which can affect health
    GENETIC_SCREENING("Genetic Screening"); // Testing for hereditary diseases to make informed breeding choices;

    private final String description;

    PreventionMethodEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
