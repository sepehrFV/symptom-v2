export const TreatmentTypeEnum = {
    PHARMACOLOGICAL: {
        value: "PHARMACOLOGICAL",
        label: "درمان دارویی",
        description: "درمان مبتنی بر دارو با استفاده از داروهای قلبی"
    },
    ANTICOAGULANT: {
        value: "ANTICOAGULANT",
        label: "درمان ضد انعقاد",
        description: "داروها برای جلوگیری از تشکیل لخته"
    },
    ANTIARRHYTHMIC: {
        value: "ANTIARRHYTHMIC",
        label: "درمان ضد آریتمی",
        description: "داروها برای کنترل ریتم غیرطبیعی قلب"
    },
    NUTRITIONAL: {
        value: "NUTRITIONAL",
        label: "مکمل غذایی",
        description: "اصلاح کمبودها (مثل تائورین برای DCM)"
    },
    SURGICAL: {
        value: "SURGICAL",
        label: "مداخله جراحی",
        description: "روش‌های تهاجمی (مثل بستن PDA، پنجره پریکارد)"
    },
    INTERVENTIONAL: {
        value: "INTERVENTIONAL",
        label: "روش مداخله‌ای",
        description: "روش‌های کم‌تهاجمی (مثل بالن والوپلاستی، امبولیزاسیون کویل)"
    },
    MONITORING: {
        value: "MONITORING",
        label: "پایش",
        description: "ارزیابی منظم بدون درمان فعال"
    },
    SUPPORTIVE_CARE: {
        value: "SUPPORTIVE_CARE",
        label: "مراقبت حمایتی",
        description: "مدیریت غیر اختصاصی برای حفظ راحتی و عملکرد"
    },
    EMERGENCY: {
        value: "EMERGENCY",
        label: "اورژانس",
        description: "روش‌های حیاتی برای شرایط بحرانی"
    },
    PALLIATIVE: {
        value: "PALLIATIVE",
        label: "مراقبت تسکینی",
        description: "مدیریت علائم برای بیماران مرحله پایانی"
    },
    HORMONAL: {
        value: "HORMONAL",
        label: "درمان هورمونی",
        description: "مدیریت اختلالات غدد درون‌ریز"
    },
    ANTIBIOTIC: {
        value: "ANTIBIOTIC",
        label: "درمان با آنتی‌بیوتیک",
        description: "درمان عفونت‌های باکتریایی"
    },
    NSAID_ANTI_INFLAMMATORY: {
        value: "NSAID_ANTI_INFLAMMATORY",
        label: "داروهای ضد التهاب غیراستروئیدی (NSAID)",
        description: "داروهای غیر استروئیدی برای کاهش درد و التهاب"
    },
    STEROID_ANTI_INFLAMMATORY: {
        value: "STEROID_ANTI_INFLAMMATORY",
        label: "داروهای ضد التهاب استروئیدی",
        description: "کورتیکواستروئیدها برای التهاب شدید و تعدیل سیستم ایمنی"
    },
    OTHER: {
        value: "OTHER",
        label: "سایر",
        description: "درمان‌هایی که در دسته‌های دیگر نمی‌گنجند"
    },
} as const;

export type TreatmentTypeEnumType = keyof typeof TreatmentTypeEnum;
