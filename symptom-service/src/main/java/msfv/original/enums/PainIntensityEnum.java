package msfv.original.enums;

public enum PainIntensityEnum {

    NONE((short) 1, "None"),
    VERY_MILD((short) 2, "Very Mild"),
    MILD((short) 3, "Mild"),
    DISCOMFORTING((short) 4, "Discomforting"),
    MODERATE((short) 5, "Moderate"),
    SEVERE((short) 6, "Severe"),
    UNBEARABLE((short) 7, "Unbearable"),
    EXCRUCIATING((short) 8, "Excruciating"),
    DEBILITATING((short) 9, "Debilitating"),
    DEEP((short) 10, "Deep"),
    HOLLOW((short) 11, "Hollow"),
    THROBBING((short) 12, "Throbbing"),
    STABBING((short) 13, "Stabbing"),
    PIERCING((short) 14, "Piercing"),
    SHARP((short) 15, "Sharp"),
    BURNING((short) 16, "Burning"),
    SHOOTING((short) 17, "Shooting"),
    ACHING((short) 18, "Aching"),
    CRAMPING((short) 19, "Cramping"),
    TWINGE((short) 20, "Twinge");

    private final short id;
    private final String name;

    PainIntensityEnum(short id, String name) {
        this.id = id;
        this.name = name;
    }

    public short getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
