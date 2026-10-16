package msfv.original.enums;

import java.util.List;
import java.util.stream.Stream;

public enum SymptomEnum {

    SEIZURES((short) 1, "seizures", "Seizures or Convulsions", "حملات یا تشنج", BodyAreaEnum.NEUROLOGICAL, PainIntensityEnum.SEVERE),
    WEIGHT_LOSS((short) 2, "weight loss", "Unexplained Weight Loss", "کاهش وزن بی‌دلیل", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    JUGULAR_VEIN_DISTENSION((short) 3, "jugular vein distension", "Jugular Vein Distension", "اتساع ورید ژوگولار", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    HYPERTENSION((short) 4, "hypertension", "Hypertension", "فشار خون بالا", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    POLYURIA((short) 5, "polyuria", "Increased Urination", "افزایش ادرار", BodyAreaEnum.GENITOURINARY, PainIntensityEnum.NONE),
    PERICARDIAL_EFFUSION((short) 6, "pericardial effusion", "Pericardial Effusion", "تراوش پریکاردیال", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    RESTLESSNESS((short) 7, "restlessness", "Restlessness", "بی‌قراری", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    PALE_GUMS((short) 8, "pale gums", "Pale Gums", "لثه‌های رنگ‌پریده", BodyAreaEnum.MOUTH, PainIntensityEnum.NONE),
    COUGHING((short) 9, "coughing", "Persistent Cough", "سرفه مداوم", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.NONE),
    WEAKNESS((short) 10, "weakness", "General Weakness", "ضعف عمومی", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    ASCITES((short) 11, "ascites", "Abdominal Fluid Accumulation", "تجمع مایع شکمی", BodyAreaEnum.ABDOMEN, PainIntensityEnum.NONE),
    SKIN_ULCERS_OR_LESIONS((short) 12, "skin ulcers or lesions", "Skin Ulcers or Lesions", "زخم‌ها یا ضایعات پوستی", BodyAreaEnum.SKIN, PainIntensityEnum.MODERATE),
    LETHARGY((short) 13, "lethargy", "Lethargy", "بی‌حالی", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    DYSPNEA((short) 14, "dyspnea", "Difficulty Breathing", "مشکل در تنفس", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.SEVERE),
    TACHYPNEA((short) 15, "tachypnea", "Rapid Breathing", "تنفس سریع", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.MODERATE),
    SUDDEN_DEATH((short) 16, "sudden death", "Sudden Death", "مرگ ناگهانی", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.SEVERE),
    FEVER((short) 17, "fever", "Fever", "تب", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    HEART_MURMUR((short) 18, "heart murmur", "Heart Murmur", "سوفل قلبی", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    MUFFLED_HEART_SOUNDS((short) 19, "muffled heart sounds", "Muffled Heart Sounds", "صداهای قلبی خفه", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    SHOCK((short) 20, "shock", "Shock", "شوک", BodyAreaEnum.GENERAL, PainIntensityEnum.SEVERE),
    MUSCLE_TREMORS((short) 21, "muscle tremors", "Muscle Tremors", "لرزش‌های عضلانی", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MODERATE),
    COLD_EXTREMITIES((short) 22, "cold extremities", "Cold Extremities", "اندام‌های سرد", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    HYPOTENSION((short) 23, "hypotension", "Low Blood Pressure", "فشار خون پایین", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    VOMITING((short) 24, "vomiting", "Vomiting", "استفراغ", BodyAreaEnum.GASTROINTESTINAL, PainIntensityEnum.MILD),
    COLD_INTOLERANCE((short) 25, "cold intolerance", "Cold Intolerance", "عدم تحمل سرما", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    WEAK_PULSE((short) 26, "weak pulse", "Weak Pulse", "نبض ضعیف", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    PANTING((short) 27, "panting", "Panting", "نفس نفس زدن", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.NONE),
    PARALYSIS((short) 28, "paralysis", "Paralysis", "فلج", BodyAreaEnum.NEUROLOGICAL, PainIntensityEnum.SEVERE),
    POLYPHAGIA((short) 29, "polyphagia", "Increased Appetite", "افزایش اشتها", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    SUDDEN_BLINDNESS((short) 30, "sudden blindness", "Sudden Blindness", "کوری ناگهانی", BodyAreaEnum.SENSORY, PainIntensityEnum.NONE),
    DECREASED_APPETITE((short) 31, "decreased appetite", "Decreased Appetite", "کاهش اشتها", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    EXERCISE_INTOLERANCE((short) 32, "exercise intolerance", "Exercise Intolerance", "عدم تحمل ورزش", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    IRREGULAR_HEART_RATE((short) 33, "irregular heart rate", "Irregular Heart Rate", "ضربان قلب نامنظم", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    DIFFICULTY_SWALLOWING((short) 34, "difficulty swallowing", "Difficulty Swallowing", "مشکل در بلع", BodyAreaEnum.GASTROINTESTINAL, PainIntensityEnum.MILD),
    ANOREXIA((short) 35, "anorexia", "Anorexia", "بی‌اشتهایی", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    MUSCLE_WEAKNESS((short) 36, "muscle weakness", "Muscle Weakness", "ضعف عضلانی", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MODERATE),
    TISSUE_DEATH((short) 37, "tissue death", "Tissue Death", "مرگ بافت", BodyAreaEnum.GENERAL, PainIntensityEnum.SEVERE),
    REGURGITATION((short) 38, "regurgitation", "Regurgitation", "برگشت غذا", BodyAreaEnum.GASTROINTESTINAL, PainIntensityEnum.MILD),
    LAMENESS((short) 39, "lameness", "Lameness", "لنگیدن", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MODERATE),
    TACHYCARDIA((short) 40, "tachycardia", "Fast Heart Rate", "تپش قلب سریع", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.MODERATE),
    SWELLING((short) 41, "swelling", "Swelling", "ورم", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MILD),
    SYNCOPE((short) 42, "syncope", "Fainting", "غش", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    COLLAPSE((short) 43, "collapse", "Collapse", "افتادگی", BodyAreaEnum.GENERAL, PainIntensityEnum.SEVERE),
    REDUCED_PULSE_IN_AFFECTED_LIMBS((short) 44, "reduced pulse in affected limbs", "Reduced Pulse in Affected Limbs", "نبض کم در اندام‌های آسیب دیده", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    PAINFUL_LIMBS((short) 45, "painful limbs", "Painful Limbs", "اندام‌های دردناک", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MODERATE),
    BRADYCARDIA((short) 46, "bradycardia", "Slow Heart Rate", "ضربان قلب آهسته", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.NONE),
    PAIN_IN_CHEST_OR_ABDOMEN((short) 47, "pain in the chest or abdomen", "Chest or Abdominal Pain", "درد در قفسه سینه یا شکم", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.SEVERE),
    CYANOSIS((short) 48, "cyanosis", "Bluish Discoloration", "تغییر رنگ آبی", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.SEVERE),
    WEIGHT_GAIN((short) 49, "weight gain", "Weight Gain", "افزایش وزن", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    POLYDIPSIA((short) 50, "polydipsia", "Increased Thirst", "افزایش تشنگی", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    ARRHYTHMIAS((short) 51, "arrhythmias", "Irregular Heartbeat", "ضربان قلب نامنظم", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.MODERATE),
    HIND_LIMB_PARALYSIS((short) 52, "hind limb paralysis", "Hind Limb Paralysis", "فلج اندام‌های عقبی", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.SEVERE),
    RESPIRATORY_DISTRESS((short) 53, "respiratory distress", "Severe Breathing Difficulty", "دشواری شدید در تنفس", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.SEVERE),

    // === 15 new cardiology-specific symptoms (codes 54–68) ===
    PROTEINURIA((short) 54, "proteinuria", "Protein in Urine", "پروتئین در ادرار", BodyAreaEnum.GENITOURINARY, PainIntensityEnum.NONE),
    FAILURE_TO_THRIVE((short) 55, "failure to thrive", "Failure to Thrive", "عدم رشد مناسب", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    DYSPHAGIA((short) 56, "dysphagia", "Difficulty Swallowing", "مشکل در بلع", BodyAreaEnum.GASTROINTESTINAL, PainIntensityEnum.MILD),
    VENTRICULAR_ARRHYTHMIAS((short) 57, "ventricular arrhythmias", "Ventricular Arrhythmias", "آریتمی‌های بطنی", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.MODERATE),
    ORTHOPNOEA((short) 58, "orthopnoea", "Orthopnea", "تنگی نفس در حالت درازکشیدن", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.SEVERE),
    HEMOPTYSIS((short) 59, "hemoptysis", "Coughing Blood", "سرفه خونی", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.MODERATE),
    HEMOGLOBINURIA((short) 60, "hemoglobinuria", "Hemoglobin in Urine", "هموگلوبین در ادرار", BodyAreaEnum.GENITOURINARY, PainIntensityEnum.NONE),
    FLACCID_PARALYSIS((short) 61, "flaccid paralysis", "Flaccid Paralysis", "فلج شل", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.SEVERE),
    ASYSTOLE((short) 62, "asystole", "Cardiac Arrest (Asystole)", "توقف قلب (آسیستول)", BodyAreaEnum.CARDIOVASCULAR, PainIntensityEnum.SEVERE),
    PALLOR((short) 63, "pallor", "Pallor", "کدورت پوست", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    ANXIETY((short) 64, "anxiety", "Anxiety", "اضطراب", BodyAreaEnum.GENERAL, PainIntensityEnum.MILD),
    PNEUMONIA((short) 65, "pneumonia", "Pneumonia", "ذات‌الریه", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.MODERATE),
    NONE((short) 66, "none", "No Symptoms", "بدون علامت", BodyAreaEnum.GENERAL, PainIntensityEnum.NONE),
    PLEURAL_EFFUSION((short) 67, "pleural effusion", "Pleural Effusion", "تراوش پلور", BodyAreaEnum.RESPIRATORY, PainIntensityEnum.MODERATE),
    EDEMA((short) 68, "edema", "Edema", "ادم", BodyAreaEnum.MUSCULOSKELETAL, PainIntensityEnum.MILD),
    ;

    private static List<String> persianSymptoms;
    private static List<String> englishSymptoms;

    static {
        persianSymptoms = Stream.of(values()).map(SymptomEnum::getPersianValue).toList();
        englishSymptoms = Stream.of(values()).map(SymptomEnum::getEnglishValue).toList();
    }

    private final short code;
    private final String englishValue;
    private final String description;
    private final String persianValue;
    private final BodyAreaEnum bodyArea;
    private final PainIntensityEnum painIntensity;

    SymptomEnum(short code, String englishValue, String description, String persianValue, BodyAreaEnum bodyArea, PainIntensityEnum painIntensity) {
        this.code = code;
        this.englishValue = englishValue;
        this.description = description;
        this.persianValue = persianValue;
        this.bodyArea = bodyArea;
        this.painIntensity = painIntensity;
    }

    public static List<SymptomEnum> findByPersianValues(List<String> persianValues) {
        return Stream.of(values()).filter(symptom -> persianValues.contains(symptom.getPersianValue())).toList();
    }

    public static List<SymptomEnum> findByEnglishValues(List<String> englishValues) {
        return Stream.of(values()).filter(symptom -> englishValues.contains(symptom.getEnglishValue())).toList();
    }

    public static SymptomEnum findByEnglishValue(String englishValue) {
        return Stream.of(values())
                .filter(symptom -> symptom.getEnglishValue().equalsIgnoreCase(englishValue))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("No enum constant for English value: " + englishValue));
    }

    public static SymptomEnum findByPersianValue(String persianValue) {
        return Stream.of(values())
                .filter(symptom -> symptom.getPersianValue().equalsIgnoreCase(persianValue))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("No enum constant for Persian value: " + persianValue));
    }

    public static SymptomEnum findByCode(Short code) {
        return Stream.of(values())
                .filter(symptom -> symptom.getCode() == code)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("No enum constant for code value: " + code));
    }



    public static List<String> getPersianSymptoms() {
        return persianSymptoms;
    }

    public static List<String> getEnglishSymptoms() {
        return englishSymptoms;
    }

    public short getCode() {
        return code;
    }

    public String getEnglishValue() {
        return englishValue;
    }

    public String getDescription() {
        return description;
    }

    public String getPersianValue() {
        return persianValue;
    }

    public BodyAreaEnum getBodyArea() {
        return bodyArea;
    }

    public PainIntensityEnum getPainIntensity() {
        return painIntensity;
    }
}
