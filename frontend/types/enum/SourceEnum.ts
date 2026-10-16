export const SourceEnum = {
    ETTINGER_8TH_EDITION: {
        value: "ETTINGER_8TH_EDITION",
        label: "کتاب داخلی دامپزشکی، چاپ هشتم (Ettinger & Feldman)",
        description: "مرجع جامع بیماری‌های حیوانات کوچک، فصل‌های قلب توسط متخصصین"
    },
    TILLEY_CARDIOLOGY: {
        value: "TILLEY_CARDIOLOGY",
        label: "Cardiology of the Dog and Cat, چاپ دوم (Tilley, Smith, Oyama)",
        description: "کتاب مرجع قلب و عروق؛ پروتکل‌های مبتنی بر شواهد"
    },
    PLUMBS_10TH_EDITION: {
        value: "PLUMBS_10TH_EDITION",
        label: "راهنمای دارویی دامپزشکی Plumb، چاپ دهم",
        description: "دوز داروها، کاربردها و منع مصرف"
    },
    ACVIM_2019_MVD: {
        value: "ACVIM_2019_MVD",
        label: "راهنمای ACVIM: MVD سگ (2019)",
        description: "استاندارد مراقبت برای مرحله‌بندی و درمان MVD"
    },
    ACVIM_2020_HCM: {
        value: "ACVIM_2020_HCM",
        label: "راهنمای ACVIM: HCM گربه (2020)",
        description: "معیارهای مبتنی بر شواهد برای تشخیص و مدیریت HCM"
    },
    ISFM_2022: {
        value: "ISFM_2022",
        label: "راهنمای انجمن بین‌المللی گربه (ISFM 2022)",
        description: "پروتکل‌های اختصاصی گربه برای فشار خون، HCM و ترومبوآمبولی"
    },
    MERCK_VET_MANUAL: {
        value: "MERCK_VET_MANUAL",
        label: "راهنمای دامپزشکی مرک (آنلاین 2024)",
        description: "خلاصه‌های بالینی آزاد و مرور شده"
    },
    VIN_PUBLIC_LIBRARY: {
        value: "VIN_PUBLIC_LIBRARY",
        label: "کتابخانه عمومی VIN",
        description: "گزارش‌های موردی و تحلیل‌های کارشناسان"
    },
    IRANIAN_VET_JOURNAL: {
        value: "IRANIAN_VET_JOURNAL",
        label: "مجله دامپزشکی ایران (Open Access)",
        description: "مقالات بازبینی شده فارسی/انگلیسی"
    },
    CURRENT_VETERINARY_THERAPY: {
        value: "CURRENT_VETERINARY_THERAPY",
        label: "Current Veterinary Therapy XV (2022)",
        description: "پروتکل‌های درمانی به‌روز، استفاده کم"
    },
} as const;

export type SourceEnumType = keyof typeof SourceEnum;
