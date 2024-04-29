package com.app.controller;

import com.app.dto.SaveChatBody;
import com.app.model.Chat;
import com.app.model.User;
import com.app.repository.ChatRepo;
import com.app.service.FileStorageService;
import com.app.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;

import kong.unirest.HttpResponse;
import kong.unirest.Unirest;

import java.util.List;
import java.util.Optional;

import org.apache.catalina.connector.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;


/**
 *
 * @author Sarveashwaran
 */

@Controller
public class MainController {

    @Autowired
    private ChatRepo chatRepo;
    @Autowired
    private UserService userService;

    @RequestMapping("/main")
    public String main(HttpServletRequest request, Model model) {
        if (!userService.isLogin(request)) {
            return "redirect:/login";
        }
        User user = (User) request.getSession().getAttribute("loggedInUser");
        List<Chat> today = chatRepo.findAllByUserId(user.getId());

        model.addAttribute("today", today);
        return "main";
    }

    // process the request get audio
    @Value("${api.base.url}")
    private String baseUrl;

    @Autowired
    private FileStorageService fileStorageService;

    @PostMapping("/message")
    public ResponseEntity<?> receiveMessage(@RequestBody SaveChatBody request) {
        try {
            String filePath = generateAudio(request);
            return ResponseEntity.ok(new AudioResponse(filePath)); // file path sent back to client
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/history/{chatId}")
    public ResponseEntity<?> getHistory(@PathVariable Long chatId) {
        try {

            // query db for the chat return 
            Optional<Chat> chat = chatRepo.findById(chatId);
            if (chat.isPresent()) {
                return ResponseEntity.ok(chat.get());
            }else{
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Chat with ID "+chatId+" not found!");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }



    @RequestMapping(value = "/save-data", method = { RequestMethod.POST })
    @ResponseBody
    @Procedure(value = "application/json")
    public ResponseEntity<?> saveData(@RequestBody SaveChatBody body, HttpServletRequest request) {
        // call api convert midi | call api convert png
        try {
            // Assuming you have two different endpoints for MIDI and PNG (assuming PDF was
            // a typo)
            String midiResponse = convertMidi(baseUrl + "/conv_to_midi");
            MessageResponse midi = new ObjectMapper().readValue(midiResponse, MessageResponse.class);

            String pdfPath = generatePDF(baseUrl + "/convert_to_sheet");
            // Example logic to save the chat if title is present
            if (body.getTitle() != null && !body.getTitle().trim().isEmpty()) {
                userService.saveChat(body, request);
                return ResponseEntity.ok("{\"saved\":true, \"midiFile\":\"" + midi.getMessage() + "\", \"pdfFile\":\""
                        + pdfPath + "\"}");
            } else {
                return ResponseEntity.ok("{\"saved\":false, \"error\":\"Title is required\"}");
            }
        } catch (Exception e) {
            System.out.println("Save data general Error: "+e.getMessage());
            // return
            // ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Conversion
            // error: " + e.getMessage());
            return ResponseEntity
                    .ok("{\"saved\":false, \"error\":\"Something went wrong ! Please try again !!\"}");
        }

    }

    private String generateAudio(SaveChatBody request) throws Exception {
        Unirest.config().reset();
        Unirest.config()
                .connectTimeout(0) // Sets the connection timeout (0 for infinite)
                .socketTimeout(0); // Sets the socket timeout (0 for infinite)

        HttpResponse<byte[]> response = Unirest.post(baseUrl + "/generate_audio")
                .header("Content-Type", "application/json")
                .body("{\"query\":\"" + request.getTitle() + "\"}")
                .asBytes(); // Handling the response as binary data

        if (response.getStatus() == 200) {
            return fileStorageService.saveFile(response.getBody(), "audio");
        } else {
            throw new RuntimeException("Failed to generate audio. Status: " + response.getStatus());
        }
    }

    private String generatePDF(String urlString) throws Exception {
        Unirest.config().reset();
        Unirest.config()
                .connectTimeout(0) // Sets the connection timeout (0 for infinite)
                .socketTimeout(0); // Sets the socket timeout (0 for infinite)

        HttpResponse<byte[]> response = Unirest.get(urlString)
                .asBytes(); // Handling the response as binary data

        if (response.getStatus() == 200) {
            return fileStorageService.saveFile(response.getBody(), "pdf");
        } else {
            throw new RuntimeException("Failed to generate pdf. Status: " + response.getStatus());
        }
    }

    private String convertMidi(String apiUrl) {
        Unirest.config().reset();
        Unirest.config()
                .connectTimeout(10000) // 10 seconds timeout for connection
                .socketTimeout(60000); // 60 seconds timeout for the response

        HttpResponse<String> response = Unirest.get(apiUrl)
                .header("Accept", "application/json")
                .asString();

        if (response.getStatus() == 200) {
            return response.getBody();
        } else {
            throw new RuntimeException(
                    "Failed to convert data, status: " + response.getStatus() + ", message: " + response.getBody());
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
        private String status;

        public MessageResponse() {}

        public String getMessage() {
            return message;
        }

        public String getStatus() {
            return status;
        }
    }
   static class AudioResponse {
        private String message;

        public AudioResponse(String message) {
            this.message = message;
        }

        public String getMessage() {
            return message;
        }

       
    }
}
