import {get, post} from "@/utils/api";
import {DIAGNOSIS_URL} from "@/utils/constants";
import {
    DiagnosisRequest,
    DiagnosisResponse,
    KbDisease,
    MetaResponse,
    SignInfo,
    Audience,
} from "@/types/diagnosis";

const DiagnosisService = {
    getMeta(): Promise<MetaResponse> {
        return get(DIAGNOSIS_URL, "/meta");
    },

    getSigns(audience: Audience): Promise<SignInfo[]> {
        return get(DIAGNOSIS_URL, `/signs?audience=${audience}`);
    },

    getDiseases(): Promise<KbDisease[]> {
        return get(DIAGNOSIS_URL, "/diseases");
    },

    /** one interview step; finalize=true also stores the case and returns its case_id */
    diagnose(payload: DiagnosisRequest): Promise<DiagnosisResponse> {
        return post(DIAGNOSIS_URL, "/diagnose", payload);
    },

    /** vet-confirmed final diagnosis (KB disease id, "non_cardiac" or "other") - used to validate the tool */
    recordOutcome(caseId: string, finalDiagnosis: string, note?: string) {
        return post(DIAGNOSIS_URL, `/cases/${caseId}/outcome`, {final_diagnosis: finalDiagnosis, note});
    },
};

export default DiagnosisService;
