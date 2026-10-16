import {BodyAreaEnum} from "@/types/enum/BodyAreaEnum";
import {PainIntensityEnum} from "@/types/enum/PainIntensityEnum";

export const SymptomEnum = {
    SEIZURES: { code: 1, englishValue: "seizures", description: "Seizures or Convulsions", persianValue: "حملات یا تشنج", bodyArea: BodyAreaEnum.NEUROLOGICAL, painIntensity: PainIntensityEnum.SEVERE },
    WEIGHT_LOSS: { code: 2, englishValue: "weight loss", description: "Unexplained Weight Loss", persianValue: "کاهش وزن بی‌دلیل", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    JUGULAR_VEIN_DISTENSION: { code: 3, englishValue: "jugular vein distension", description: "Jugular Vein Distension", persianValue: "اتساع ورید ژوگولار", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    HYPERTENSION: { code: 4, englishValue: "hypertension", description: "Hypertension", persianValue: "فشار خون بالا", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    POLYURIA: { code: 5, englishValue: "polyuria", description: "Increased Urination", persianValue: "افزایش ادرار", bodyArea: BodyAreaEnum.GENITOURINARY, painIntensity: PainIntensityEnum.NONE },
    PERICARDIAL_EFFUSION: { code: 6, englishValue: "pericardial effusion", description: "Pericardial Effusion", persianValue: "تراوش پریکاردیال", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    RESTLESSNESS: { code: 7, englishValue: "restlessness", description: "Restlessness", persianValue: "بی‌قراری", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    PALE_GUMS: { code: 8, englishValue: "pale gums", description: "Pale Gums", persianValue: "لثه‌های رنگ‌پریده", bodyArea: BodyAreaEnum.MOUTH, painIntensity: PainIntensityEnum.NONE },
    COUGHING: { code: 9, englishValue: "coughing", description: "Persistent Cough", persianValue: "سرفه مداوم", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.NONE },
    WEAKNESS: { code: 10, englishValue: "weakness", description: "General Weakness", persianValue: "ضعف عمومی", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    ASCITES: { code: 11, englishValue: "ascites", description: "Abdominal Fluid Accumulation", persianValue: "تجمع مایع شکمی", bodyArea: BodyAreaEnum.ABDOMEN, painIntensity: PainIntensityEnum.NONE },
    SKIN_ULCERS_OR_LESIONS: { code: 12, englishValue: "skin ulcers or lesions", description: "Skin Ulcers or Lesions", persianValue: "زخم‌ها یا ضایعات پوستی", bodyArea: BodyAreaEnum.SKIN, painIntensity: PainIntensityEnum.MODERATE },
    LETHARGY: { code: 13, englishValue: "lethargy", description: "Lethargy", persianValue: "بی‌حالی", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    DYSPNEA: { code: 14, englishValue: "dyspnea", description: "Difficulty Breathing", persianValue: "مشکل در تنفس", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.SEVERE },
    TACHYPNEA: { code: 15, englishValue: "tachypnea", description: "Rapid Breathing", persianValue: "تنفس سریع", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.MODERATE },
    SUDDEN_DEATH: { code: 16, englishValue: "sudden death", description: "Sudden Death", persianValue: "مرگ ناگهانی", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.SEVERE },
    FEVER: { code: 17, englishValue: "fever", description: "Fever", persianValue: "تب", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    HEART_MURMUR: { code: 18, englishValue: "heart murmur", description: "Heart Murmur", persianValue: "سوفل قلبی", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    MUFFLED_HEART_SOUNDS: { code: 19, englishValue: "muffled heart sounds", description: "Muffled Heart Sounds", persianValue: "صداهای قلبی خفه", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    SHOCK: { code: 20, englishValue: "shock", description: "Shock", persianValue: "شوک", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.SEVERE },
    MUSCLE_TREMORS: { code: 21, englishValue: "muscle tremors", description: "Muscle Tremors", persianValue: "لرزش‌های عضلانی", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MODERATE },
    COLD_EXTREMITIES: { code: 22, englishValue: "cold extremities", description: "Cold Extremities", persianValue: "اندام‌های سرد", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    HYPOTENSION: { code: 23, englishValue: "hypotension", description: "Low Blood Pressure", persianValue: "فشار خون پایین", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    VOMITING: { code: 24, englishValue: "vomiting", description: "Vomiting", persianValue: "استفراغ", bodyArea: BodyAreaEnum.GASTROINTESTINAL, painIntensity: PainIntensityEnum.MILD },
    COLD_INTOLERANCE: { code: 25, englishValue: "cold intolerance", description: "Cold Intolerance", persianValue: "عدم تحمل سرما", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    WEAK_PULSE: { code: 26, englishValue: "weak pulse", description: "Weak Pulse", persianValue: "نبض ضعیف", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    PANTING: { code: 27, englishValue: "panting", description: "Panting", persianValue: "نفس نفس زدن", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.NONE },
    PARALYSIS: { code: 28, englishValue: "paralysis", description: "Paralysis", persianValue: "فلج", bodyArea: BodyAreaEnum.NEUROLOGICAL, painIntensity: PainIntensityEnum.SEVERE },
    POLYPHAGIA: { code: 29, englishValue: "polyphagia", description: "Increased Appetite", persianValue: "افزایش اشتها", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    SUDDEN_BLINDNESS: { code: 30, englishValue: "sudden blindness", description: "Sudden Blindness", persianValue: "کوری ناگهانی", bodyArea: BodyAreaEnum.SENSORY, painIntensity: PainIntensityEnum.NONE },
    DECREASED_APPETITE: { code: 31, englishValue: "decreased appetite", description: "Decreased Appetite", persianValue: "کاهش اشتها", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    EXERCISE_INTOLERANCE: { code: 32, englishValue: "exercise intolerance", description: "Exercise Intolerance", persianValue: "عدم تحمل ورزش", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    IRREGULAR_HEART_RATE: { code: 33, englishValue: "irregular heart rate", description: "Irregular Heart Rate", persianValue: "ضربان قلب نامنظم", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    DIFFICULTY_SWALLOWING: { code: 34, englishValue: "difficulty swallowing", description: "Difficulty Swallowing", persianValue: "مشکل در بلع", bodyArea: BodyAreaEnum.GASTROINTESTINAL, painIntensity: PainIntensityEnum.MILD },
    ANOREXIA: { code: 35, englishValue: "anorexia", description: "Anorexia", persianValue: "بی‌اشتهایی", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    MUSCLE_WEAKNESS: { code: 36, englishValue: "muscle weakness", description: "Muscle Weakness", persianValue: "ضعف عضلانی", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MODERATE },
    TISSUE_DEATH: { code: 37, englishValue: "tissue death", description: "Tissue Death", persianValue: "مرگ بافت", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.SEVERE },
    REGURGITATION: { code: 38, englishValue: "regurgitation", description: "Regurgitation", persianValue: "برگشت غذا", bodyArea: BodyAreaEnum.GASTROINTESTINAL, painIntensity: PainIntensityEnum.MILD },
    LAMENESS: { code: 39, englishValue: "lameness", description: "Lameness", persianValue: "لنگیدن", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MODERATE },
    TACHYCARDIA: { code: 40, englishValue: "tachycardia", description: "Fast Heart Rate", persianValue: "تپش قلب سریع", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.MODERATE },
    SWELLING: { code: 41, englishValue: "swelling", description: "Swelling", persianValue: "ورم", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MILD },
    SYNCOPE: { code: 42, englishValue: "syncope", description: "Fainting", persianValue: "غش", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    COLLAPSE: { code: 43, englishValue: "collapse", description: "Collapse", persianValue: "افتادگی", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.SEVERE },
    REDUCED_PULSE_IN_AFFECTED_LIMBS: { code: 44, englishValue: "reduced pulse in affected limbs", description: "Reduced Pulse in Affected Limbs", persianValue: "نبض کم در اندام‌های آسیب دیده", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    PAINFUL_LIMBS: { code: 45, englishValue: "painful limbs", description: "Painful Limbs", persianValue: "اندام‌های دردناک", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MODERATE },
    BRADYCARDIA: { code: 46, englishValue: "bradycardia", description: "Slow Heart Rate", persianValue: "ضربان قلب آهسته", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.NONE },
    PAIN_IN_CHEST_OR_ABDOMEN: { code: 47, englishValue: "pain in the chest or abdomen", description: "Chest or Abdominal Pain", persianValue: "درد در قفسه سینه یا شکم", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.SEVERE },
    CYANOSIS: { code: 48, englishValue: "cyanosis", description: "Bluish Discoloration", persianValue: "تغییر رنگ آبی", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.SEVERE },
    WEIGHT_GAIN: { code: 49, englishValue: "weight gain", description: "Weight Gain", persianValue: "افزایش وزن", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    POLYDIPSIA: { code: 50, englishValue: "polydipsia", description: "Increased Thirst", persianValue: "افزایش تشنگی", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    ARRHYTHMIAS: { code: 51, englishValue: "arrhythmias", description: "Irregular Heartbeat", persianValue: "ضربان قلب نامنظم", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.MODERATE },
    HIND_LIMB_PARALYSIS: { code: 52, englishValue: "hind limb paralysis", description: "Hind Limb Paralysis", persianValue: "فلج اندام‌های عقبی", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.SEVERE },
    RESPIRATORY_DISTRESS: { code: 53, englishValue: "respiratory distress", description: "Severe Breathing Difficulty", persianValue: "دشواری شدید در تنفس", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.SEVERE },
    PROTEINURIA: { code: 54, englishValue: "proteinuria", description: "Protein in Urine", persianValue: "پروتئین در ادرار", bodyArea: BodyAreaEnum.GENITOURINARY, painIntensity: PainIntensityEnum.NONE },
    FAILURE_TO_THRIVE: { code: 55, englishValue: "failure to thrive", description: "Failure to Thrive", persianValue: "عدم رشد مناسب", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    DYSPHAGIA: { code: 56, englishValue: "dysphagia", description: "Difficulty Swallowing", persianValue: "مشکل در بلع", bodyArea: BodyAreaEnum.GASTROINTESTINAL, painIntensity: PainIntensityEnum.MILD },
    VENTRICULAR_ARRHYTHMIAS: { code: 57, englishValue: "ventricular arrhythmias", description: "Ventricular Arrhythmias", persianValue: "آریتمی‌های بطنی", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.MODERATE },
    ORTHOPNOEA: { code: 58, englishValue: "orthopnoea", description: "Orthopnea", persianValue: "تنگی نفس در حالت درازکشیدن", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.SEVERE },
    HEMOPTYSIS: { code: 59, englishValue: "hemoptysis", description: "Coughing Blood", persianValue: "سرفه خونی", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.MODERATE },
    HEMOGLOBINURIA: { code: 60, englishValue: "hemoglobinuria", description: "Hemoglobin in Urine", persianValue: "هموگلوبین در ادرار", bodyArea: BodyAreaEnum.GENITOURINARY, painIntensity: PainIntensityEnum.NONE },
    FLACCID_PARALYSIS: { code: 61, englishValue: "flaccid paralysis", description: "Flaccid Paralysis", persianValue: "فلج شل", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.SEVERE },
    ASYSTOLE: { code: 62, englishValue: "asystole", description: "Cardiac Arrest (Asystole)", persianValue: "توقف قلب (آسیستول)", bodyArea: BodyAreaEnum.CARDIOVASCULAR, painIntensity: PainIntensityEnum.SEVERE },
    PALLOR: { code: 63, englishValue: "pallor", description: "Pallor", persianValue: "کدورت پوست", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    ANXIETY: { code: 64, englishValue: "anxiety", description: "Anxiety", persianValue: "اضطراب", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.MILD },
    PNEUMONIA: { code: 65, englishValue: "pneumonia", description: "Pneumonia", persianValue: "ذات‌الریه", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.MODERATE },
    NONE: { code: 66, englishValue: "none", description: "No Symptoms", persianValue: "بدون علامت", bodyArea: BodyAreaEnum.GENERAL, painIntensity: PainIntensityEnum.NONE },
    PLEURAL_EFFUSION: { code: 67, englishValue: "pleural effusion", description: "Pleural Effusion", persianValue: "تراوش پلور", bodyArea: BodyAreaEnum.RESPIRATORY, painIntensity: PainIntensityEnum.MODERATE },
    EDEMA: { code: 68, englishValue: "edema", description: "Edema", persianValue: "ادم", bodyArea: BodyAreaEnum.MUSCULOSKELETAL, painIntensity: PainIntensityEnum.MILD },
} as const


export type SymptomKey = keyof typeof SymptomEnum;
export type SymptomValue = (typeof SymptomEnum)[SymptomKey];

export const SymptomUtils = {
    values(): SymptomValue[] {
        return Object.values(SymptomEnum);
    },

    getEnglishSymptoms(): string[] {
        return this.values().map(s => s.englishValue);
    },

    getPersianSymptoms(): string[] {
        return this.values().map(s => s.persianValue);
    },

    findByCode(code: number): SymptomValue {
        const result = this.values().find(s => s.code === code);
        if (!result) throw new Error(`No symptom found for code: ${code}`);
        return result;
    },

    findByEnglishValue(value: string): SymptomValue {
        const result = this.values().find(s => s.englishValue.toLowerCase() === value.toLowerCase());
        if (!result) throw new Error(`No symptom found for English value: ${value}`);
        return result;
    },

    findByPersianValue(value: string): SymptomValue {
        const result = this.values().find(s => s.persianValue === value);
        if (!result) throw new Error(`No symptom found for Persian value: ${value}`);
        return result;
    },

    findByEnglishValues(values: string[]): SymptomValue[] {
        return this.values().filter(s => values.includes(s.englishValue));
    },

    findByPersianValues(values: string[]): SymptomValue[] {
        return this.values().filter(s => values.includes(s.persianValue));
    }
};
