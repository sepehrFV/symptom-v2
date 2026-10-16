package msfv.original.model.disease;

import msfv.original.enums.SymptomEnum;
import msfv.original.model.generic.GenericService;

import java.util.List;
import java.util.Set;

public interface DiseaseService extends GenericService<Disease, Long> {
    Set<Disease> getDiseasesByNames(Set<String> diseaseNames);

    List<Disease> getDiseasesByIds(Set<Long> diseaseIds);

    Set<Disease> getDiseasesBySymptoms(Set<SymptomEnum> symptoms);

    Set<String> getDiseasesNamesBySymptoms(Set<SymptomEnum> symptoms);

}
