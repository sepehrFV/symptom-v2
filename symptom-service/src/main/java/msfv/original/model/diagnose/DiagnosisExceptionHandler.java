package msfv.original.model.diagnose;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice(assignableTypes = DiagnosisController.class)
public class DiagnosisExceptionHandler {

    private static ResponseEntity<String> json(HttpStatus status, String fa, String en) {
        String body = "{\"error\":\"" + en + "\",\"error_fa\":\"" + fa + "\"}";
        return ResponseEntity.status(status).contentType(MediaType.APPLICATION_JSON).body(body);
    }

    @ExceptionHandler(PredictorUnavailableException.class)
    public ResponseEntity<String> unavailable(PredictorUnavailableException e) {
        return json(HttpStatus.SERVICE_UNAVAILABLE,
                "سرویس تشخیص در دسترس نیست. کمی بعد دوباره تلاش کنید.",
                "The diagnosis engine is temporarily unavailable.");
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> badRequest(IllegalArgumentException e) {
        String msg = String.valueOf(e.getMessage()).replace("\\", "\\\\").replace("\"", "'");
        return json(HttpStatus.BAD_REQUEST, "درخواست نامعتبر است.", msg);
    }
}
