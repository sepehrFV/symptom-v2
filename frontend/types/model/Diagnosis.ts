import {Disease} from "@/types/model/Disease";
import {DiagnosticMethodEnumType} from "@/types/enum/DiagnosticMethodEnum";
import {GenericEntity} from "@/types/model/GenericEntity";

export interface Diagnosis extends GenericEntity{
    disease?: Disease;
    type: DiagnosticMethodEnumType;
}
