export const SpeciesEnum = {
    CANINE: {
        value: "CANINE",
        label: "سگ",
        description: "گونه‌های سگ اهلی و مرتبط"
    },
    FELINE: {
        value: "FELINE",
        label: "گربه",
        description: "گونه‌های گربه اهلی و مرتبط"
    },
} as const;

export type SpeciesEnumType = keyof typeof SpeciesEnum;
