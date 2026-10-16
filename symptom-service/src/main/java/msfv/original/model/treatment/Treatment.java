package msfv.original.model.treatment;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import msfv.original.enums.TreatmentTypeEnum;
import msfv.original.model.disease.Disease;
import msfv.original.model.generic.GenericEntity;
import msfv.original.model.medicine.Medicine;

import java.util.HashSet;
import java.util.Set;

@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
@Entity
@Table(name = "treatment", indexes = {
        @Index(name = "idx_treatment_disease", columnList = "disease_id")
})
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Treatment extends GenericEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "disease_id", nullable = false, foreignKey = @ForeignKey(name = "fk_diagnosis_disease"))
    @JsonIgnore
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Disease disease;

    @Column(name = "type", nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private TreatmentTypeEnum type; // ← define enum similarly to MedicineTypeEnum

    // Many-to-Many with Medicine (via treatment_medicine junction table)
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "treatment_medicine",
            joinColumns = @JoinColumn(name = "treatment_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "medicine_id", nullable = false),
            foreignKey = @ForeignKey(name = "fk_treatment_medicine_treatment"),
            inverseForeignKey = @ForeignKey(name = "fk_treatment_medicine_medicine")
    )
    @Builder.Default
    private Set<Medicine> medicines = new HashSet<>();

    // Optional: helper methods for bidirectional safety (if Medicine also maps back)
    public void addMedicine(Medicine medicine) {
        this.medicines.add(medicine);
    }

    public void removeMedicine(Medicine medicine) {
        this.medicines.remove(medicine);
    }
}