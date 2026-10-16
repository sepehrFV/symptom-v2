package msfv.original.model.medicine;

import msfv.original.model.generic.GenericRepo;
import msfv.original.model.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MedicineServiceImpl extends GenericServiceImpl<Medicine, Long> implements MedicineService {

    private final MedicineRepo repo;

    @Autowired
    public MedicineServiceImpl(MedicineRepo repo) {
        this.repo = repo;
    }

    @Override
    public Medicine update(Long aLong, Medicine entity) {
        return null; // TODO: 10/9/2024
    }

    @Override
    protected GenericRepo<Medicine, Long> getRepo() {
        return this.repo;
    }

    @Override
    protected Class<?> getExtendedClass() {
        return this.getClass();
    }
}
