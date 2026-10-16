import {MedicineTypeEnumType} from "@/types/enum/MedicineTypeEnum";
import {GenericEntity} from "@/types/model/GenericEntity";

export interface Medicine extends GenericEntity{
    type: MedicineTypeEnumType;
    dogDosage?: string;
    catDosage?: string;
    contraindications?: string;
}
