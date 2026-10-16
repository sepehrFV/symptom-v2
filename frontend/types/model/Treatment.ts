import {Disease} from "@/types/model/Disease";
import {Medicine} from "@/types/model/Medicine";
import {TreatmentTypeEnumType} from "@/types/enum/TreatmentTypeEnum";
import {GenericEntity} from "@/types/model/GenericEntity";

export interface Treatment extends GenericEntity{
    disease?: Disease;
    type: TreatmentTypeEnumType;
    medicines?: Medicine[];
}
