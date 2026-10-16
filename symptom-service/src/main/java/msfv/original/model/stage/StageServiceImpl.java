package msfv.original.model.stage;

import msfv.original.model.generic.GenericRepo;
import msfv.original.model.generic.GenericServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StageServiceImpl extends GenericServiceImpl<Stage, Long> implements StageService {

    private final StageRepo repo;

    @Autowired
    public StageServiceImpl(StageRepo repo) {
        this.repo = repo;
    }

    @Override
    public Stage update(Long aLong, Stage entity) {
        return null;
    }

    @Override
    protected GenericRepo<Stage, Long> getRepo() {
        return this.repo;
    }

    @Override
    protected Class<?> getExtendedClass() {
        return this.getClass();
    }
}
