package msfv.original.model.disease;

import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import msfv.original.enums.DiseaseTypeEnum;
import msfv.original.enums.SourceEnum;
import msfv.original.enums.SpeciesEnum;
import msfv.original.enums.SymptomEnum;
import msfv.original.model.diagnosis.Diagnosis;
import msfv.original.model.generic.GenericEntity;
import msfv.original.model.stage.Stage;
import msfv.original.model.treatment.Treatment;

import java.util.List;

@Entity
@Data
@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
@Table(name = "disease")
public class Disease extends GenericEntity {

    @Enumerated(EnumType.STRING)
    private DiseaseTypeEnum type;

    private String subType;

    @Enumerated(EnumType.STRING)
    private SymptomEnum mainSymptom;

    private boolean fromValidSources;

    @Enumerated(EnumType.STRING)
    private SourceEnum source;

    @OneToMany(mappedBy = "disease", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Stage> stages;

    @OneToMany(mappedBy = "disease", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Diagnosis> diagnoses;

    @OneToMany(mappedBy = "disease", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Treatment> treatments;

    @ElementCollection(targetClass = SymptomEnum.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "disease_symptom_enums", joinColumns = @JoinColumn(name = "disease_id"))
    @Column(name = "symptom_enum")
    @Enumerated(EnumType.STRING)
    private List<SymptomEnum> symptoms;

    @Column(length = 1000)
    private String symptomsStr;


    @Column(length = 1000)
    private String differentialDiseasesStr;


    @ElementCollection(targetClass = SpeciesEnum.class)
    @CollectionTable(name = "disease_species", joinColumns = @JoinColumn(name = "disease_id"))
    @Enumerated(EnumType.STRING) // Save enum as a string in the table
    @Column(name = "species") // Column for species in the disease_species table
    private List<SpeciesEnum> affected_species;

    @Transient
    private int irrelevantScore;

    @Column(name = "why_important")
    private String whyImportant;

    @Column(name = "per_why_important")
    private String whyImportant_per;

}
