export const DiseaseTypeEnum = {
    CONGENITAL: {
        value: "CONGENITAL",
        label: "بیماری مادرزادی قلب",
        description: "نقص‌های ساختاری موجود از بدو تولد (مثل PDA, VSD, SAS)"
    },
    VALVULAR: {
        value: "VALVULAR",
        label: "بیماری دریچه‌ای قلب",
        description: "اختلالات دریچه‌ای دژنراتیو یا دیسپلاستیک (مثل MVD, TVD)"
    },
    PRIMARY_CARDIOMYOPATHY: {
        value: "PRIMARY_CARDIOMYOPATHY",
        label: "کاردیومیوپاتی اولیه",
        description: "بیماری‌های میوکارد بدون علت شناسایی شده (مثل HCM, DCM, RCM, ARVC)"
    },
    PERICARDIAL: {
        value: "PERICARDIAL",
        label: "بیماری پریکارد",
        description: "اختلالات پریکاردیوم (مثل افیوژن، تامپوناد، انسداد)"
    },
    INFECTIOUS: {
        value: "INFECTIOUS",
        label: "بیماری عفونی قلب",
        description: "آسیب قلبی ناشی از پاتوژن‌ها (مثل هارت‌ورم، اندوکاردیت، میوکاردیت)"
    },
    THROMBOEMBOLIC: {
        value: "THROMBOEMBOLIC",
        label: "بیماری ترومبوامبولیک",
        description: "تشکیل لخته یا امبولی که باعث ایسکمی می‌شود (مثل سدل ترومبوس، PE)"
    },
    VASCULAR: {
        value: "VASCULAR",
        label: "بیماری عروقی",
        description: "اختلالات ساختاری شریانی/وریدی (مثل آنوریسم، واسکولیت، حلقه‌های عروقی)"
    },
    METABOLIC_ENDOCRINE: {
        value: "METABOLIC_ENDOCRINE",
        label: "بیماری متابولیک/اندوکراین قلب",
        description: "اختلالات سیستمیک که اثرات ثانویه قلبی ایجاد می‌کنند (مثل HCM ناشی از هایپرتیروئیدی، فشار خون بالا)"
    },
    ARRHYTHMIA: {
        value: "ARRHYTHMIA",
        label: "آریتمی اولیه",
        description: "اختلالات هدایت الکتریکی بدون بیماری ساختاری (مثل SSS، ایست کامل دهلیزی)"
    },
    NEOPLASTIC: {
        value: "NEOPLASTIC",
        label: "تومور قلبی",
        description: "تومورهای اولیه یا متاستاتیک قلب (مثل همانژیوسارکوما، کمدکتوما)"
    },
    HYPERTENSIVE: {
        value: "HYPERTENSIVE",
        label: "بیماری قلب ناشی از فشار خون",
        description: "تغییرات قلبی ثانویه به فشار خون سیستمیک یا ریوی"
    },
} as const;

export type DiseaseTypeEnumType = keyof typeof DiseaseTypeEnum;
