package msfv.original;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import msfv.original.enums.SymptomEnum;
import msfv.original.model.disease.Disease;
import msfv.original.model.disease.DiseaseRepo;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.*;
import java.util.logging.Logger;

@Component
@RequiredArgsConstructor
public class Initialize {

    private static final Logger LOG = Logger.getLogger("TestLogger");

//    private final UserRepo userRepository;

    private final DiseaseRepo diseaseRepo;

//    private final RoleRepo roleRepository;

//    private final PasswordEncoder passwordEncoder;

//    private final ExcelUtils excelUtils;

//    private final DiagnosticService diagnosticService;

//    private final DiseaseService diseaseService;

//    private final JsonUtils jsonUtils;


    @Transactional
    @PostConstruct
    public void init() {

        try {

//            initDisease();
//            initAdmin();
//
//            String secret = JwtUtil.jwtSecretGenerator();
//            LOG.info("secret : " + secret);

//            Path excelPath = Path.of("C:\\Users\\pc\\Desktop\\SymptomCheckerProject\\large_veterinary_heart_diseases.xlsx");
//            excelUtils.extractDataFromExcel(excelPath);


//            jsonUtils.parseDiseaseJson("F:\\Java\\Symptom\\src\\main\\resources\\disease.json");


        } catch (Exception exception) {
            System.out.println("Error(s) occurred during starting up...");
            exception.printStackTrace();
        }
    }

//    public void initAdmin() {
//        // Check if any users exist
//        if (userRepository.count() == 0) {
//            // Create an admin role if it doesn't exist
//            Role adminRole = roleRepository.findByName("ROLE_ADMIN");
//            if (adminRole == null) {
//                adminRole = new Role();
//                adminRole.setName("ROLE_ADMIN");
//                roleRepository.save(adminRole);
//            }
//
//            // Create an admin user
//            User adminUser = new User();
//            adminUser.setUsername("admin");
//            adminUser.setPassword(passwordEncoder.encode("hello"));
//            adminUser.setEnabled(true);
//
//            // Assign the admin role to the admin user
//            Set<Role> roles = new HashSet<>();
//            roles.add(adminRole);
//            adminUser.setRoles(roles);
//
//            userRepository.save(adminUser);
//            System.out.println("Admin user created with username: admin and password: hello");
//        }
//    }

//    public void initDisease() {
//        if (diseaseRepo.count() > 0)
//            return;
//
//        System.out.println("Running code after application startup...");
//        List<Disease> diseases = new ArrayList<>();
//        try {
//            HttpClient client = HttpClient.newHttpClient();
//            HttpRequest request = HttpRequest.newBuilder()
//                    .uri(URI.create("http://localhost:5000/get_map"))
//                    .header("Content_Type", "application/json")
//                    .GET().build();
//
//            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//
//            ObjectMapper mapper = new ObjectMapper();
//            Map<String, List<String>> diseaseMap = mapper.readValue(
//                    response.body(),
//                    new TypeReference<>() {
//                    }
//            );
//
//            diseaseMap.forEach((key, value) -> {
//
//                Disease d = new Disease();
//                d.setName(key);
//                d.setMainSymptom(SymptomEnum.findByEnglishValue(value.get(0)));
//                Set<SymptomEnum> symptomEnums = new HashSet<>();
//                value.forEach(s -> {
//                    SymptomEnum symptom = SymptomEnum.findByEnglishValue(s);
//                    symptomEnums.add(symptom);
//                });
//                d.setSymptoms(new ArrayList<>(symptomEnums));
//                diseases.add(d);
//            });
//
//            diseaseRepo.saveAll(diseases);
//
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//
//
//    }
}

