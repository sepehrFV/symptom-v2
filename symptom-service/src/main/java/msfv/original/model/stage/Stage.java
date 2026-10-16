package msfv.original.model.stage;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import msfv.original.enums.SymptomEnum;
import msfv.original.model.disease.Disease;
import msfv.original.model.generic.GenericEntity;

import java.util.List;

@Entity
@Table(name = "stage", indexes = {
        @Index(name = "idx_stage_disease", columnList = "disease_id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
public class Stage extends GenericEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "disease_id", nullable = false, foreignKey = @ForeignKey(name = "fk_stage_disease"))
    @JsonIgnore
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Disease disease;

    @ElementCollection(targetClass = SymptomEnum.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "stage_symptom_enums", joinColumns = @JoinColumn(name = "stage_id"))
    @Column(name = "symptom_enum")
    @Enumerated(EnumType.STRING)
    private List<SymptomEnum> symptoms;
}
