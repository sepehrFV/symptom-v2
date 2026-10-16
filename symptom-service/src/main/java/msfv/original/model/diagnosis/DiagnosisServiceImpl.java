package msfv.original.model.diagnosis;

import lombok.RequiredArgsConstructor;
import msfv.original.model.generic.GenericRepo;
import msfv.original.model.generic.GenericServiceImpl;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class DiagnosisServiceImpl extends GenericServiceImpl<Diagnosis, Long> implements DiagnosisService {

    private final DiagnosisRepo repo;

    @Override
    public Diagnosis update(Long aLong, Diagnosis entity) {
        return null;
    }

    @Override
    protected GenericRepo<Diagnosis, Long> getRepo() {
        return this.repo;
    }

    @Override
    protected Class<?> getExtendedClass() {
        return this.getClass();
    }
}
