export const MedicineTypeEnum = {
    DIURETIC: {
        value: "DIURETIC",
        label: "دیورتیک",
        description: "افزایش دفع مایعات برای کاهش پیش‌بار در نارسایی قلبی"
    },
    INODILATOR: {
        value: "INODILATOR",
        label: "اینو دیلاتور",
        description: "افزایش قدرت انقباض میوکارد و گشاد شدن عروق (مثل pimobendan)"
    },
    ACE_INHIBITOR: {
        value: "ACE_INHIBITOR",
        label: "مهارکننده ACE",
        description: "کاهش پس‌بار و کند کردن تغییر شکل قلبی در CHF"
    },
    ANTIARRHYTHMIC: {
        value: "ANTIARRHYTHMIC",
        label: "داروی ضد آریتمی",
        description: "کنترل ریتم‌های غیر طبیعی قلب (کلاس I-IV)"
    },
    ANTICOAGULANT: {
        value: "ANTICOAGULANT",
        label: "ضد انعقاد",
        description: "جلوگیری از تشکیل لخته (مثل clopidogrel, heparin)"
    },
    VASODILATOR: {
        value: "VASODILATOR",
        label: "گشادکننده عروق",
        description: "گشاد کردن شریان‌ها/وریدها برای کاهش بار قلبی (مثل amlodipine)"
    },
    CARDIAC_GLYCOSIDE: {
        value: "CARDIAC_GLYCOSIDE",
        label: "گلیکوزید قلبی",
        description: "افزایش انقباض و کنترل ضربان بطنی در AF (مثل digoxin)"
    },
    ANTIBIOTIC: {
        value: "ANTIBIOTIC",
        label: "آنتی‌بیوتیک",
        description: "درمان عفونت‌های باکتریایی"
    },
    ANTIPARASITIC: {
        value: "ANTIPARASITIC",
        label: "ضد انگل",
        description: "هدف قرار دادن انگل‌ها (مثل melarsomine)"
    },
    ANALGESIC: {
        value: "ANALGESIC",
        label: "مسکن",
        description: "مدیریت درد (مثل buprenorphine)"
    },
    NUTRITIONAL: {
        value: "NUTRITIONAL",
        label: "مکمل غذایی",
        description: "اصلاح کمبودها (مثل تائورین برای DCM)"
    },
    EMERGENCY: {
        value: "EMERGENCY",
        label: "داروی اضطراری",
        description: "مداخلات حیاتی (مثل calcium gluconate)"
    },
    STEROID_ANTI_INFLAMMATORY: {
        value: "STEROID_ANTI_INFLAMMATORY",
        label: "استروئید ضد التهاب",
        description: "کورتیکواستروئیدها برای التهاب (مثل prednisone)"
    },
    NSAID_ANTI_INFLAMMATORY: {
        value: "NSAID_ANTI_INFLAMMATORY",
        label: "NSAID ضد التهاب",
        description: "داروهای ضد التهاب غیر استروئیدی"
    },
    HORMONAL: {
        value: "HORMONAL",
        label: "هورمونی",
        description: "مدیریت اختلالات غدد درون‌ریز"
    },
    ANTIFUNGAL: {
        value: "ANTIFUNGAL",
        label: "ضد قارچ",
        description: "درمان عفونت‌های قارچی"
    },
    NEUROLOGICAL: {
        value: "NEUROLOGICAL",
        label: "نورولوژیک",
        description: "تأثیر بر عملکرد سیستم عصبی"
    },
    SEDATIVES: {
        value: "SEDATIVES",
        label: "آرام‌بخش",
        description: "برای آرام‌سازی و بی‌حسی پروسه‌ها"
    },
    TOPICAL: {
        value: "TOPICAL",
        label: "موضعی",
        description: "اعمال مستقیم روی پوست/غشاها"
    },
    IMMUNOMODULATORS: {
        value: "IMMUNOMODULATORS",
        label: "ایمونومدولاتور",
        description: "تغییر پاسخ ایمنی"
    },
    OTHER: {
        value: "OTHER",
        label: "سایر",
        description: "داروهایی که در دسته‌بندی‌های دیگر نمی‌گنجند"
    },
} as const;

export type MedicineTypeEnumType = keyof typeof MedicineTypeEnum;
