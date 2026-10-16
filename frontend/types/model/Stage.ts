import {Disease} from "@/types/model/Disease";
import {SymptomKey} from "@/types/enum/SymptomEnum";
import {GenericEntity} from "@/types/model/GenericEntity";

export interface Stage extends GenericEntity{
    disease?: Disease;
    symptoms?: SymptomKey[];
}