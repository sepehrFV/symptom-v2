export const DiagnosticMethodEnum = {
    PHYSICAL_EXAMINATION: {
        value: "PHYSICAL_EXAMINATION",
        label: "معاینه فیزیکی",
        description: "شنیدن صداها، بررسی نبض، ارزیابی JVD"
    },
    LABORATORY_TESTING: {
        value: "LABORATORY_TESTING",
        label: "آزمایشگاه",
        description: "آزمایش خون/ادرار (مثل NT-proBNP, تروپونین)"
    },
    IMAGING: {
        value: "IMAGING",
        label: "تصویربرداری",
        description: "رادیوگرافی، سی‌تی، MRI"
    },
    ECG: {
        value: "ECG",
        label: "نوار قلب",
        description: "ارزیابی فعالیت الکتریکی برای آریتمی‌ها یا تأخیر هدایت"
    },
    ECHO: {
        value: "ECHO",
        label: "اکو قلب",
        description: "استاندارد طلایی برای ارزیابی ساختاری و عملکردی قلب"
    },
    ANTIGEN_TEST: {
        value: "ANTIGEN_TEST",
        label: "تست آنتی‌ژن",
        description: "تشخیص آنتی‌ژن هارت‌ورم"
    },
    MICROFILARIA_TEST: {
        value: "MICROFILARIA_TEST",
        label: "تست میکروفیلاریا",
        description: "Knott یا فیلتر برای لارو هارت‌ورم"
    },
    CULTURE: {
        value: "CULTURE",
        label: "کشت",
        description: "کشت باکتری/قارچ برای اندوکاردیت"
    },
    BIOPSY: {
        value: "BIOPSY",
        label: "بیوپسی",
        description: "نمونه‌گیری بافت اندومیوکارد یا پریکارد"
    },
    GENETIC_TESTING: {
        value: "GENETIC_TESTING",
        label: "آزمایش ژنتیک",
        description: "تست DNA برای کاردیومیوپاتی‌های ارثی (مثل Boxer ARVC)"
    },
    NECROPSY: {
        value: "NECROPSY",
        label: "پس‌مرگ",
        description: "معاینه بعد از مرگ برای تشخیص قطعی"
    },
} as const;

export type DiagnosticMethodEnumType = keyof typeof DiagnosticMethodEnum;
