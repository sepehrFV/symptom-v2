package msfv.original.model.diagnose;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface DiagnosisCaseRepo extends JpaRepository<DiagnosisCase, UUID> {
    List<DiagnosisCase> findAllByOrderByCreatedAtDesc();

    List<DiagnosisCase> findAllByFinalDiagnosisIsNotNullOrderByCreatedAtAsc();
}
