package msfv.original.enums;

public enum SpeciesEnum {
    CANINE("Dog"),
    FELINE("Cat"),
    EQUINE("Horse"),
    BOVINE("Cattle"),
    OVINE("Sheep"),
    CAPRINE("Goat"),
    AVIAN("Bird"),
    REPTILIAN("Reptile"),
    SMALL_ANIMAL("Small Animal (e.g., rabbit, guinea pig)"),
    EXOTIC("Exotic Animal (e.g., ferret, hedgehog)"),
    PORCINE("Pig"), // New addition for pigs
    MARINE("Marine Animal (e.g., fish, dolphins)"), // New addition for aquatic species
    WILD("Wild Animal (e.g., deer, raccoon)"); // New addition for wild species

    private final String description;

    SpeciesEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

}
