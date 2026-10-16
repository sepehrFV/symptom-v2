import {PainIntensityEnum} from "@/types/enum/PainIntensityEnum";
import {BodyAreaEnum} from "@/types/enum/BodyAreaEnum";

export interface Symptom {
    code: number;
    englishValue: string;
    description: string;
    persianValue: string;
    bodyArea: BodyAreaEnum;
    painIntensity: PainIntensityEnum;
}
