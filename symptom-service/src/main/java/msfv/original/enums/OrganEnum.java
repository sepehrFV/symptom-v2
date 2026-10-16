package msfv.original.enums;

public enum OrganEnum {

    HEART((short) 1, "Heart", BodyAreaEnum.CHEST, OrganSystemEnum.CIRCULATORY),
    LUNGS((short) 2, "Lungs", BodyAreaEnum.CHEST, OrganSystemEnum.RESPIRATORY),
    LIVER((short) 3, "Liver", BodyAreaEnum.ABDOMEN, OrganSystemEnum.DIGESTIVE),
    KIDNEYS((short) 4, "Kidneys", BodyAreaEnum.ABDOMEN, OrganSystemEnum.URINARY),
    STOMACH((short) 5, "Stomach", BodyAreaEnum.ABDOMEN, OrganSystemEnum.DIGESTIVE),
    INTESTINES((short) 6, "Intestines", BodyAreaEnum.ABDOMEN, OrganSystemEnum.DIGESTIVE),
    BRAIN((short) 7, "Brain", BodyAreaEnum.HEAD, OrganSystemEnum.NERVOUS),
    SPLEEN((short) 8, "Spleen", BodyAreaEnum.ABDOMEN, OrganSystemEnum.IMMUNE),
    PANCREAS((short) 9, "Pancreas", BodyAreaEnum.ABDOMEN, OrganSystemEnum.ENDOCRINE),
    BLADDER((short) 10, "Bladder", BodyAreaEnum.ABDOMEN, OrganSystemEnum.URINARY),
    EYES((short) 11, "Eyes", BodyAreaEnum.HEAD, OrganSystemEnum.SENSORY),
    EARS((short) 12, "Ears", BodyAreaEnum.HEAD, OrganSystemEnum.SENSORY),
    THYROID((short) 13, "Thyroid", BodyAreaEnum.NECK, OrganSystemEnum.ENDOCRINE),
    PROSTATE((short) 14, "Prostate", BodyAreaEnum.ABDOMEN, OrganSystemEnum.REPRODUCTIVE),
    ADRENAL_GLANDS((short) 15, "Adrenal Glands", BodyAreaEnum.ABDOMEN, OrganSystemEnum.ENDOCRINE),
    LYMPH_NODES((short) 16, "Lymph Nodes", BodyAreaEnum.ABDOMEN, OrganSystemEnum.IMMUNE),
    SKIN((short) 17, "Skin", BodyAreaEnum.GENERAL, OrganSystemEnum.INTEGUMENTARY);

    private final short id;
    private final String organName;
    private final BodyAreaEnum bodyArea;
    private final OrganSystemEnum mainOrganSystem;

    OrganEnum(short id, String organName, BodyAreaEnum bodyArea, OrganSystemEnum mainOrganSystem) {
        this.id = id;
        this.organName = organName;
        this.bodyArea = bodyArea;
        this.mainOrganSystem = mainOrganSystem;
    }

    public int getId() {
        return id;
    }

    public String getOrganName() {
        return organName;
    }

    public BodyAreaEnum getBodyArea() {
        return bodyArea;
    }

    public OrganSystemEnum getMainOrganSystem() {
        return mainOrganSystem;
    }
}
