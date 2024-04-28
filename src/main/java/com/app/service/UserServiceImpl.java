package com.app.service;

import com.app.dto.SaveChatBody;
import com.app.model.Chat;
import com.app.model.User;
import com.app.other.Other;
import com.app.repository.ChatRepo;
import com.app.repository.UserRepository;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ChatRepo chatRepo;

    @Override
    public void save(User user) {
        user.setPassword(Other.encrypt(user.getPassword()));
        userRepository.save(user);
    }

    @Override
    public void update(User user, HttpServletRequest request) {

        User u = userRepository.getOne(user.getId());
        if (!user.getPassword().trim().isEmpty()) {
            u.setPassword(Other.encrypt(user.getPassword()));
        }
        u.setSchool(user.getSchool());
        userRepository.save(u);
        this.updateSession(request, u);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public void login(String username, String password, HttpServletRequest request) {
        // Check if the username exists in the database
        User user = userRepository.findByUsername(username);

        // Authentication successful, set session attribute and redirect to welcome page
        HttpSession session = request.getSession(true); // Create a new session if it doesn't exist
        session.setAttribute("loggedInUser", user); // Store the logged-in user in the session
    }

    @Override
    public User loginUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("loggedInUser");
    }

    @Override
    public void updateSession(HttpServletRequest request, User user) {
        request.getSession().setAttribute("loggedInUser", user);
    }

    @Override
    public boolean isLogin(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("loggedInUser");
        return user != null;
    }

    // save chat (title , filepath, audiopath, createdTimestamp)
    @Override
    public void saveChat(SaveChatBody body, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("loggedInUser");
    
        // Define the directory within resources
        File userDir = new File(getClass().getResource("/static/music/").getPath());
        if (!userDir.exists() && !userDir.mkdirs()) {
            System.err.println("Failed to create directory: " + userDir);
            return;
        }
    
        // Get current timestamp
        String timestamp = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
    
        // Declare paths for the new destination files outside the try block
        File destinationPdf = null;
        File destinationAudio = null;
    
        try {
            destinationPdf = new File(userDir, "music-" + user.getId() + "__" + timestamp + ".pdf");
            destinationAudio = new File(userDir, "audio-" + user.getId() + "__" + timestamp + ".wav");
    
            // Copy the files
            Files.copy(getClass().getResourceAsStream("/static/music/_music.pdf"), destinationPdf.toPath(), StandardCopyOption.REPLACE_EXISTING);
            Files.copy(getClass().getResourceAsStream("/static/music/_audio.wav"), destinationAudio.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("after renaming files ");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("File conversion Error: "+e.getMessage());
            return;  // Exit if there's a failure in file operations
        }
    
        // Save chat information to the database
        try {
            Chat chat = new Chat();
            chat.setUser(user);
            chat.setTitle(body.getTitle());
            chat.setMusic_path("/music/" + destinationAudio.getName());
            chat.setSheet_path("/music/" + destinationPdf.getName());
            chat.setCreatedAt(LocalDateTime.now());
            chatRepo.save(chat);
        } catch (Exception e) {
            System.out.println( "Chat saving Error: "+e.getMessage());
        }
    }
    
    
}
