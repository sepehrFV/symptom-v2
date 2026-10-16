package msfv.original.model.treatment;

import msfv.original.model.generic.GenericRepo;
import msfv.original.model.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TreatmentServiceImpl extends GenericServiceImpl<Treatment, Long> implements TreatmentService {
    
    
    private final TreatmentRepo repo;

    @Autowired
    public TreatmentServiceImpl(TreatmentRepo repo) {
        this.repo = repo;
    }

    @Override
    public Treatment update(Long aLong, Treatment entity) {
        return null;// TODO: 10/9/2024  
    }

    @Override
    protected GenericRepo<Treatment, Long> getRepo() {
        return this.repo;
    }

    @Override
    protected Class<?> getExtendedClass() {
        return this.getClass();
    }
}
