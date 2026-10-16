package msfv.original.model.diagnose;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.util.UUID;

/**
 * A finished consultation, stored so the tool can later be validated against the real (vet-confirmed) diagnosis.
 * No personal data about the owner is stored.
 */
@Entity
@Table(name = "diagnosis_case")
@Getter
@Setter
@NoArgsConstructor
public class DiagnosisCase {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private Instant createdAt;

    @Column(length = 100)
    private String petName;

    private String species;
    private String ageGroup;
    private String breedGroup;
    private String audience;
    private String mode;
    private String kbVersion;

    /** flat JSON object {signId: yes|no|unknown} */
    @Column(columnDefinition = "text")
    private String answersJson;

    /** the complete engine response that the user saw */
    @Column(columnDefinition = "text")
    private String resultJson;

    private String topRule;
    private String topAi;
    private String triage;

    /** confirmed final diagnosis: a KB disease id, "non_cardiac" or "other" */
    private String finalDiagnosis;

    @Column(length = 2000)
    private String outcomeNote;

    private Instant outcomeAt;
}
