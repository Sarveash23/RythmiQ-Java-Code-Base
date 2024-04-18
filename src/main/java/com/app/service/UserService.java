package com.app.service;

import com.app.dto.SaveChatBody;
import com.app.model.User;

import javax.servlet.http.HttpServletRequest;

public interface UserService {
    void save(User user);
    void update(User user, HttpServletRequest request);

    User findByUsername(String username);
    public void login(String username, String password, HttpServletRequest request);
    public boolean isLogin( HttpServletRequest request);
    public User loginUser( HttpServletRequest request);
    public void updateSession( HttpServletRequest request, User user);
    public void saveChat(SaveChatBody body, HttpServletRequest request);

}
