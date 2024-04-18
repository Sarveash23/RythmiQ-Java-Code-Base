package com.app.service;

import com.app.dto.SaveChatBody;
import com.app.model.Chat;
import com.app.model.User;
import com.app.other.Other;
import com.app.repository.ChatRepo;
import com.app.repository.UserRepository;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

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

    @Override
    public void saveChat(SaveChatBody body, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("loggedInUser");

        InputStream pdfFile = getClass().getResourceAsStream("/static/music/music.pdf");
        InputStream audioFile = getClass().getResourceAsStream("/static/music/audio.mp3");

        File userDir = new File(new File(".").getAbsolutePath() + File.separator + "user_data");
        if (!userDir.exists()) {
            userDir.mkdirs();
        }

        File destinationPdf = new File(userDir.getAbsolutePath() + File.separator + "music-" + user.getId() + "__" + new SimpleDateFormat("YYYY-MM-dd-HH:mm:ss").format(new Date()) + ".pdf");
        File destinationAudio = new File(userDir.getAbsolutePath() + File.separator + "audio-" + user.getId() + "__" + new SimpleDateFormat("YYYY-MM-dd-HH:mm:ss").format(new Date()) + ".mp3");
        try {
            Files.copy(pdfFile, destinationPdf.toPath(), StandardCopyOption.REPLACE_EXISTING);
            Files.copy(audioFile, destinationAudio.toPath(), StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Chat chat = new Chat();
        chat.setUser(user);
        chat.setTitle(body.getTitle());
        chat.setMusic_path("/user_data/" + destinationAudio.getName());
        chat.setSheet_path("/user_data/" + destinationPdf.getName());
        chat.setCreatedAt(LocalDateTime.now());
        chatRepo.save(chat);
    }

}
