import {SpeciesEnum, SpeciesEnumType} from "@/types/enum/SpeciesEnum";
import {SymptomKey} from "@/types/enum/SymptomEnum";
import {Stage} from "@/types/model/Stage";
import {Diagnosis} from "@/types/model/Diagnosis";
import {Treatment} from "@/types/model/Treatment";
import {DiseaseTypeEnumType} from "@/types/enum/DiseaseTypeEnum";
import {SourceEnumType} from "@/types/enum/SourceEnum";
import {GenericEntity} from "@/types/model/GenericEntity";

export interface Disease extends GenericEntity{
    type: DiseaseTypeEnumType;
    subType?: string;

    mainSymptom?: SymptomKey;

    fromValidSources: boolean;
    source?: SourceEnumType;

    stages?: Stage[];
    diagnoses?: Diagnosis[];
    treatments?: Treatment[];

    symptoms?: SymptomKey[];
    symptomsStr?: string;

    differentialDiseasesStr?: string;

    affected_species?: SpeciesEnumType[];

    irrelevantScore?: number;

    whyImportant?: string;
    whyImportant_per?: string;
}