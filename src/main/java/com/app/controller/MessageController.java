package com.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.app.service.FileStorageService;
import kong.unirest.HttpResponse;
import kong.unirest.Unirest;
import org.springframework.beans.factory.annotation.Value;

@RestController
@RequestMapping("/api")
public class MessageController {

    @Value("${api.base.url}")
    private String baseUrl;

    @Autowired
    private FileStorageService fileStorageService;

    @PostMapping("/message")
    public ResponseEntity<?> receiveMessage(@RequestBody MessageRequest request) {
        // ensure no conflicts
        Unirest.config().reset();

        Unirest.config()
                .connectTimeout(0) // Sets the connection timeout (0 for infinite)
                .socketTimeout(0); // Sets the socket timeout (0 for infinite)

        HttpResponse<byte[]> response = Unirest.post(baseUrl + "/generate_audio")
                .header("Content-Type", "application/json")
                .body("{\"query\":\"" + request.getMessage() + "\"}")
                .asBytes(); // Handling the response as binary data

        if (response.getStatus() == 200) {
            String filePath = fileStorageService.saveFile(response.getBody());
            return ResponseEntity.ok(new MessageResponse(filePath));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to generate audio");
        }
    }

    static class MessageRequest {
        private String message;

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }

    static class MessageResponse {
        private String message;

        public MessageResponse(String message) {
            this.message = message;
        }

        public String getMessage() {
            return message;
        }
    }
}
