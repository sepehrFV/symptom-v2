package msfv.original.model.diagnosis;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import msfv.original.enums.DiagnosticMethodEnum;
import msfv.original.model.disease.Disease;
import msfv.original.model.generic.GenericEntity;

@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
@Entity
@Table(name = "diagnosis", indexes = {
        @Index(name = "idx_diagnosis_disease", columnList = "disease_id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Diagnosis extends GenericEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "disease_id", nullable = false, foreignKey = @ForeignKey(name = "fk_diagnosis_disease"))
    @JsonIgnore
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Disease disease;

    @Column(name = "type", nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private DiagnosticMethodEnum type;
}