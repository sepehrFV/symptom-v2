// Types of the diagnosis API (Java proxy -> Python engine). Field names follow the engine's snake_case JSON.

export type SpeciesId = "dog" | "cat";
export type AgeGroupId = "young" | "adult" | "senior";
export type Audience = "owner" | "clinician";
export type EngineMode = "combined" | "rule" | "ai";
export type Answer = "yes" | "no" | "unknown";
export type Band = "high" | "moderate" | "low" | "unlikely";
export type CardiacBand = "high" | "moderate" | "low" | "very_low";
export type Urgency = "routine" | "urgent" | "emergency";

export interface Option {
    id: string;
    label_fa: string;
    label_en: string;
}

export interface AgeOption extends Option {
    population: number;
}

export interface MetaResponse {
    kb_version: string;
    kb_status: string;
    ml_available: boolean;
    species: Option[];
    age_groups: AgeOption[];
    breed_groups: Record<SpeciesId, Option[]>;
    audiences?: Option[];
}

export interface SignInfo {
    id: string;
    level: string;
    level_fa: string;
    group: string;
    group_fa: string;
    label_fa: string;
    label_en: string;
    text_fa: string;
    text_en: string;
    hint_fa: string;
    parent: string | null;
}

export interface Evidence {
    sign: string;
    label_fa: string;
    label_en: string;
    answer: Answer;
    lr: number;
}

export interface ToConfirm {
    sign: string;
    label_fa: string;
    label_en: string;
    level: string;
    expected: number;
}

export interface RankedDisease {
    rank: number;
    id: string;
    name_en: string;
    name_fa: string;
    category: string;
    db_names: string[];
    urgency: Urgency;
    score: number;
    band: Band;
    rule_score: number | null;
    ai_score: number | null;
    absolute_probability: number;
    supporting: Evidence[];
    against: Evidence[];
    to_confirm: ToConfirm[];
    confirm_tests_en: string[];
    note_en: string;
    kb_status: string;
    disease_id?: number | null;       // DB row (null when the disease has no page yet)
    disease_name_per?: string | null;
}

export interface NextQuestion {
    id: string;
    level: string;
    group: string;
    label_fa: string;
    label_en: string;
    text_fa: string;
    text_en: string;
    hint_fa: string;
    info_gain_bits: number;
}

export interface TriageMessage {
    sign: string | null;
    urgency: Urgency;
    fa: string;
    en: string;
}

export interface DiagnosisResponse {
    kb_version: string;
    engine_used: EngineMode;
    status: {
        answered: number;
        adaptive_asked: number;
        can_conclude: boolean;
        done: boolean;
        done_reason: string | null;
    };
    triage: { level: Urgency; messages: TriageMessage[] };
    cardiac_likelihood: { probability: number; band: CardiacBand; rule: number; ai: number | null };
    non_cardiac: {
        probability: number;
        rule: number;
        ai: number | null;
        likely_causes: { id: string; name_en: string; name_fa: string; share: number }[];
    };
    ranking: RankedDisease[];
    agreement: { state: "agree" | "partial" | "disagree"; top1_same: boolean; top3_overlap: number; divergence: number } | null;
    next_question: NextQuestion | null;
    warnings: { code: string; fa: string; en: string }[];
    disclaimer_fa: string;
    disclaimer_en: string;
    case_id?: string;
}

export interface DiagnosisRequest {
    species: SpeciesId;
    age_group?: AgeGroupId | null;
    breed_group?: string | null;
    audience: Audience;
    answers: Record<string, Answer>;
    initial?: string[];
    mode?: EngineMode;
    top_k?: number;
    finalize?: boolean;
    petName?: string;
}

export interface KbDisease {
    id: string;
    name_en: string;
    name_fa: string;
}

export interface Intake {
    species: SpeciesId | null;
    petName: string;
    ageGroup: AgeGroupId | null;
    breedGroup: string;
    audience: Audience;
    mode: EngineMode;
}
