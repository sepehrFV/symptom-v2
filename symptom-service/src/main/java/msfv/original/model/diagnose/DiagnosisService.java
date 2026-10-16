package msfv.original.model.diagnose;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.RequiredArgsConstructor;
import msfv.original.model.disease.Disease;
import msfv.original.model.disease.DiseaseRepo;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.*;

/**
 * Diagnosis is computed by the Python engine (rule-based + AI model, one knowledge base).
 * This service only validates/forwards the request, links each result to the Disease rows of the database
 * and logs finished cases for later validation. It never invents scores.
 */
@Service
@RequiredArgsConstructor
public class DiagnosisService {

    private static final ObjectMapper MAPPER = new ObjectMapper();
    private static final Set<String> FORWARDED = Set.of(
            "species", "age_group", "breed_group", "audience", "answers", "mode", "top_k", "initial");
    private static final Set<String> NON_DISEASE_OUTCOMES = Set.of("non_cardiac", "other");

    private final PredictorClient predictor;
    private final DiseaseRepo diseaseRepo;
    private final DiagnosisCaseRepo caseRepo;

    // ------------------------------------------------------------------ pass-through reads
    public PredictorClient.Response meta() {
        return predictor.get("/meta");
    }

    public PredictorClient.Response diseases() {
        return predictor.get("/diseases");
    }

    public PredictorClient.Response signs(String audience) {
        String a = (audience == null || audience.isBlank()) ? "owner" : audience.toLowerCase(Locale.ROOT);
        return predictor.get("/signs?audience=" + URLEncoder.encode(a, StandardCharsets.UTF_8));
    }

    // ------------------------------------------------------------------ diagnose
    /**
     * @param req body from the client; besides the engine fields it may contain
     *            {@code finalize: true} (store the case) and {@code petName}.
     */
    public PredictorClient.Response diagnose(Map<String, Object> req) {
        Map<String, Object> forward = new LinkedHashMap<>();
        for (String k : FORWARDED) {
            if (req.get(k) != null) forward.put(k, req.get(k));
        }
        boolean finalizeCase = Boolean.TRUE.equals(req.get("finalize"));

        PredictorClient.Response res = predictor.post("/diagnose", toJson(forward));
        if (res.status() != 200) return res;

        ObjectNode root;
        try {
            JsonNode parsed = MAPPER.readTree(res.body());
            if (!(parsed instanceof ObjectNode obj)) return res;
            root = obj;
        } catch (IOException e) {
            return res;
        }

        enrichWithDatabaseDiseases(root);

        if (finalizeCase) {
            DiagnosisCase saved = saveCase(req, forward, root);
            root.put("case_id", saved.getId().toString());
        }
        return new PredictorClient.Response(200, root.toString());
    }

    /** adds diseaseId / per_name of the matching DB row (null when the KB disease has no DB row yet) */
    private void enrichWithDatabaseDiseases(ObjectNode root) {
        JsonNode ranking = root.get("ranking");
        if (ranking == null || !ranking.isArray()) return;

        Set<String> names = new HashSet<>();
        for (JsonNode item : ranking) {
            for (JsonNode n : item.path("db_names")) names.add(n.asText().toLowerCase(Locale.ROOT));
        }
        Map<String, Disease> byName = new HashMap<>();
        if (!names.isEmpty()) {
            for (Disease d : diseaseRepo.findAllByLowerNameIn(names)) {
                if (d.getName() != null) byName.put(d.getName().toLowerCase(Locale.ROOT), d);
            }
        }
        for (JsonNode item : ranking) {
            if (!(item instanceof ObjectNode node)) continue;
            Disease match = null;
            for (JsonNode n : item.path("db_names")) {
                match = byName.get(n.asText().toLowerCase(Locale.ROOT));
                if (match != null) break;
            }
            if (match != null) {
                node.put("disease_id", match.getId());
                node.put("disease_name_per", match.getPer_name());
            } else {
                node.putNull("disease_id");
            }
        }
    }

    // ------------------------------------------------------------------ case log
    private DiagnosisCase saveCase(Map<String, Object> req, Map<String, Object> forward, ObjectNode result) {
        DiagnosisCase c = new DiagnosisCase();
        c.setCreatedAt(Instant.now());
        Object pet = req.get("petName");
        if (pet != null) c.setPetName(truncate(pet.toString(), 100));
        c.setSpecies(str(forward.get("species")));
        c.setAgeGroup(str(forward.get("age_group")));
        c.setBreedGroup(str(forward.get("breed_group")));
        c.setAudience(str(forward.get("audience")));
        c.setMode(str(forward.get("mode")));
        c.setKbVersion(result.path("kb_version").asText(null));
        c.setAnswersJson(toJson(forward.getOrDefault("answers", Map.of())));
        c.setResultJson(result.toString());
        c.setTriage(result.path("triage").path("level").asText(null));
        c.setTopRule(topBy(result.path("ranking"), "rule_score"));
        c.setTopAi(topBy(result.path("ranking"), "ai_score"));
        return caseRepo.save(c);
    }

    private static String topBy(JsonNode ranking, String field) {
        String best = null;
        double bestScore = -1;
        for (JsonNode item : ranking) {
            if (item.hasNonNull(field) && item.get(field).asDouble() > bestScore) {
                bestScore = item.get(field).asDouble();
                best = item.path("id").asText(null);
            }
        }
        return best;
    }

    public DiagnosisCase recordOutcome(UUID id, String finalDiagnosis, String note) {
        if (finalDiagnosis == null || finalDiagnosis.isBlank())
            throw new IllegalArgumentException("final_diagnosis is required");
        String fd = finalDiagnosis.trim().toLowerCase(Locale.ROOT);
        if (!NON_DISEASE_OUTCOMES.contains(fd) && !knownDiseaseIds().contains(fd))
            throw new IllegalArgumentException("final_diagnosis must be a KB disease id, 'non_cardiac' or 'other'");
        DiagnosisCase c = caseRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("case not found"));
        c.setFinalDiagnosis(fd);
        c.setOutcomeNote(note == null ? null : truncate(note, 2000));
        c.setOutcomeAt(Instant.now());
        return caseRepo.save(c);
    }

    private Set<String> knownDiseaseIds() {
        PredictorClient.Response r = predictor.get("/diseases");
        Set<String> ids = new HashSet<>();
        if (r.status() != 200) return ids;
        try {
            for (JsonNode d : MAPPER.readTree(r.body())) ids.add(d.path("id").asText());
        } catch (IOException ignored) {
            // empty set -> outcome rejected, caller sees a 400
        }
        return ids;
    }

    public List<DiagnosisCase> listCases() {
        return caseRepo.findAllByOrderByCreatedAtDesc();
    }

    /** CSV in the format read by symptom-model/evaluate_cases.py (confirmed cases only) */
    public String exportConfirmedCasesCsv() {
        StringBuilder sb = new StringBuilder("species,age_group,breed_group,audience,answers_json,final_diagnosis\n");
        for (DiagnosisCase c : caseRepo.findAllByFinalDiagnosisIsNotNullOrderByCreatedAtAsc()) {
            sb.append(csv(c.getSpecies())).append(',')
                    .append(csv(c.getAgeGroup())).append(',')
                    .append(csv(c.getBreedGroup())).append(',')
                    .append(csv(c.getAudience())).append(',')
                    .append(csv(c.getAnswersJson())).append(',')
                    .append(csv(c.getFinalDiagnosis())).append('\n');
        }
        return sb.toString();
    }

    public String casesToJson(List<DiagnosisCase> cases) {
        ArrayNode arr = MAPPER.createArrayNode();
        for (DiagnosisCase c : cases) {
            ObjectNode n = arr.addObject();
            n.put("id", c.getId().toString());
            n.put("created_at", c.getCreatedAt().toString());
            n.put("pet_name", c.getPetName());
            n.put("species", c.getSpecies());
            n.put("age_group", c.getAgeGroup());
            n.put("audience", c.getAudience());
            n.put("mode", c.getMode());
            n.put("triage", c.getTriage());
            n.put("top_rule", c.getTopRule());
            n.put("top_ai", c.getTopAi());
            n.put("final_diagnosis", c.getFinalDiagnosis());
            n.put("outcome_note", c.getOutcomeNote());
        }
        return arr.toString();
    }

    // ------------------------------------------------------------------ helpers
    private static String toJson(Object o) {
        try {
            return MAPPER.writeValueAsString(o);
        } catch (IOException e) {
            throw new IllegalArgumentException("request cannot be serialised");
        }
    }

    private static String str(Object o) {
        return o == null ? null : o.toString();
    }

    private static String truncate(String s, int max) {
        return s.length() <= max ? s : s.substring(0, max);
    }

    private static String csv(String s) {
        if (s == null) return "";
        return "\"" + s.replace("\"", "\"\"") + "\"";
    }
}
