package msfv.original.model.disease;

import msfv.original.enums.SymptomEnum;
import msfv.original.model.generic.GenericRepo;
import msfv.original.model.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class DiseaseServiceImpl extends GenericServiceImpl<Disease, Long> implements DiseaseService {

    private final DiseaseRepo repo;

    @Autowired
    public DiseaseServiceImpl(DiseaseRepo repo) {
        this.repo = repo;
    }


    @Override
    protected GenericRepo<Disease, Long> getRepo() {
        return this.repo;
    }

    @Override
    protected Class<?> getExtendedClass() {
        return this.getClass();
    }

    @Override
    public Disease update(Long aLong, Disease entity) {
        return null; // TODO
    }

    @Override
    @Cacheable(value = "diseasesByNames", key = "#diseaseNames.hashCode()", unless = "#result == null or #result.isEmpty()")
    public Set<Disease> getDiseasesByNames(Set<String> diseaseNames) {
        return repo.findAllByNameIn(diseaseNames);
    }

    @Override
    @Cacheable(value = "diseasesByIds", key = "#diseaseIds.hashCode()", unless = "#result == null or #result.isEmpty()")
    public List<Disease> getDiseasesByIds(Set<Long> diseaseIds) {
        return repo.findAllById(diseaseIds);
    }

    @Override
    @Cacheable(value = "diseasesBySymptoms", key = "#symptoms.hashCode()", unless = "#result == null or #result.isEmpty()")
    public Set<Disease> getDiseasesBySymptoms(Set<SymptomEnum> symptoms) {
        return repo.findDiseasesBySymptoms(symptoms.stream().toList());
    }

    @Override
    @Cacheable(value = "diseasesNamesBySymptoms", key = "#symptoms.hashCode()", unless = "#result == null or #result.isEmpty()")
    public Set<String> getDiseasesNamesBySymptoms(Set<SymptomEnum> symptoms) {
        return repo.findDiseaseNamesBySymptoms(symptoms.stream().toList());
    }
}
