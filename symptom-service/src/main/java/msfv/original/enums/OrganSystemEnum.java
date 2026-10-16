package msfv.original.enums;

public enum OrganSystemEnum {

    CIRCULATORY((short) 1),
    RESPIRATORY((short) 2),
    DIGESTIVE((short) 3),
    URINARY((short) 4),
    NERVOUS((short) 5),
    IMMUNE((short) 6),
    ENDOCRINE((short) 7),
    SENSORY((short) 8),
    REPRODUCTIVE((short) 9),
    INTEGUMENTARY((short) 10),
    MULTIPLE((short) 11);


    private final short id;

    OrganSystemEnum(short id) {
        this.id = id;
    }

    public short getId() {
        return id;
    }
}
