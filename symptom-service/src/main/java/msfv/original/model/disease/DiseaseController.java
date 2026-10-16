package msfv.original.model.disease;

import lombok.RequiredArgsConstructor;
import msfv.original.model.generic.GenericController;
import msfv.original.model.generic.GenericService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/disease")
@RequiredArgsConstructor
public class DiseaseController extends GenericController<Disease, Long> {

    private final DiseaseService service;

    @Override
    protected GenericService<Disease, Long> getService() {
        return this.service;
    }
}
