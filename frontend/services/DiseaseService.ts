import {get} from "@/utils/api";
import {DISEASE_URL} from "@/utils/constants";
import {Disease} from "@/types/model/Disease";

const DiseaseService = {

    async getAllDiseases(): Promise<Disease[]> {
        try {
            return await get(DISEASE_URL, "");
        } catch (error) {
            throw error;
        }
    },

    async getById(id: number): Promise<Disease> {
        try {
            return await get(DISEASE_URL, `/${id}`);
        } catch (error) {
            throw error;
        }
    },
};

export default DiseaseService;