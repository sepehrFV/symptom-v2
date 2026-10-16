package msfv.original.model.diagnose;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

/**
 * Public API used by the frontend:
 * <pre>
 * GET  /diagnosis/meta                      species, age groups, breed groups, audiences
 * GET  /diagnosis/diseases                  KB diseases (ids + names)
 * GET  /diagnosis/signs?audience=owner      questions the given audience can answer
 * POST /diagnosis/diagnose                  one interview step (rule + AI) ; finalize=true stores the case
 * POST /diagnosis/cases/{id}/outcome        vet-confirmed final diagnosis (for validation)
 * GET  /diagnosis/cases                     case list
 * GET  /diagnosis/cases/export.csv          confirmed cases for symptom-model/evaluate_cases.py
 * </pre>
 */
@RestController
@RequestMapping("/diagnosis")
@RequiredArgsConstructor
public class DiagnosisController {

    private final DiagnosisService service;

    private static ResponseEntity<String> json(PredictorClient.Response r) {
        return ResponseEntity.status(r.status()).contentType(MediaType.APPLICATION_JSON).body(r.body());
    }

    @GetMapping("/meta")
    public ResponseEntity<String> meta() {
        return json(service.meta());
    }

    @GetMapping("/diseases")
    public ResponseEntity<String> diseases() {
        return json(service.diseases());
    }

    @GetMapping("/signs")
    public ResponseEntity<String> signs(@RequestParam(defaultValue = "owner") String audience) {
        return json(service.signs(audience));
    }

    @PostMapping("/diagnose")
    public ResponseEntity<String> diagnose(@RequestBody Map<String, Object> body) {
        return json(service.diagnose(body));
    }

    @PostMapping("/cases/{id}/outcome")
    public ResponseEntity<String> outcome(@PathVariable UUID id, @RequestBody Map<String, Object> body) {
        Object fd = body.get("final_diagnosis");
        Object note = body.get("note");
        DiagnosisCase c = service.recordOutcome(id, fd == null ? null : fd.toString(), note == null ? null : note.toString());
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON)
                .body(service.casesToJson(java.util.List.of(c)));
    }

    @GetMapping("/cases")
    public ResponseEntity<String> cases() {
        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON)
                .body(service.casesToJson(service.listCases()));
    }

    @GetMapping(value = "/cases/export.csv", produces = "text/csv;charset=UTF-8")
    public ResponseEntity<String> exportCsv() {
        return ResponseEntity.ok().contentType(MediaType.parseMediaType("text/csv;charset=UTF-8"))
                .body(service.exportConfirmedCasesCsv());
    }
}
