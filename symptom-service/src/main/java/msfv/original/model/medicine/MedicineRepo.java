package msfv.original.model.medicine;

import msfv.original.model.generic.GenericRepo;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicineRepo extends GenericRepo<Medicine, Long> {
}
