package msfv.original.enums;

public enum BodyAreaEnum {

    HEAD((short) 1, "Head"),
    NECK((short) 2, "Neck"),
    SHOULDERS((short) 3, "Shoulders"),
    CHEST((short) 4, "Chest"),
    BACK((short) 5, "Back"),
    ARMS((short) 6, "Arms"),
    HANDS((short) 7, "Hands"),
    ABDOMEN((short) 8, "Abdomen"),
    HIPS((short) 9, "Hips"),
    LEGS((short) 10, "Legs"),
    FEET((short) 11, "Feet"),
    GENERAL((short) 12, "General"),
    RESPIRATORY((short) 13, "Respiratory System"),
    MUSCULOSKELETAL((short) 14, "Musculoskeletal System"),
    GASTROINTESTINAL((short) 15, "Gastrointestinal System"),
    CARDIOVASCULAR((short) 16, "Cardiovascular System"),
    NEUROLOGICAL((short) 17, "Neurological System"),
    SENSORY((short) 18, "Sensory System"),
    SKIN((short) 19, "Skin"),
    ENT((short) 20, "Ear, Nose, and Throat"),
    GENITOURINARY((short) 21, "Genitourinary System"),
    MOUTH((short) 22, "Mouth"),
    EYES((short) 23, "Eyes"),
    THROAT((short) 24, "Throat"),
    SPINE((short) 25, "Spine"),
    PENIS((short) 26, "Penis"),
    VAGINA((short) 27, "Vagina"),
    LYMPH_NODES((short) 28, "Lymph Nodes"),
    ANAL_REGION((short) 29, "Anal Region"),
    PROSTATE((short) 30, "Prostate");

    private final short id;
    private final String areaName;

    BodyAreaEnum(short id, String areaName) {
        this.id = id;
        this.areaName = areaName;
    }

    public int getId() {
        return id;
    }

    public String getAreaName() {
        return areaName;
    }

    @Override
    public String toString() {
        return areaName;
    }

}
