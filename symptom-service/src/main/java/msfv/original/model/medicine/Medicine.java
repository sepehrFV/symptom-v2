package msfv.original.model.medicine;

import jakarta.persistence.*;
import lombok.*;
import msfv.original.enums.MedicineTypeEnum;
import msfv.original.model.generic.GenericEntity;

@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
@Entity
@Table(name = "medicine")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Medicine extends GenericEntity {
    @Column(name = "type", nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private MedicineTypeEnum type;

    @Column(name = "dog_dosage", length = 200)
    private String dogDosage;

    @Column(name = "cat_dosage", length = 200)
    private String catDosage;

    @Column(name = "contraindications", columnDefinition = "TEXT")
    private String contraindications;
}