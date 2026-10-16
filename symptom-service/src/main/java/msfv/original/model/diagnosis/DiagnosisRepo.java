package msfv.original.model.diagnosis;

import msfv.original.model.generic.GenericRepo;
import org.springframework.stereotype.Repository;

@Repository
public interface DiagnosisRepo extends GenericRepo<Diagnosis, Long> {
}
