package com.app.service;

/**
 *
 * @author Sarveashwaran
 */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;

@Component
public class CustomInterceptor implements HandlerInterceptor {
    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        final String contPath = request.getContextPath();
        String urlPrefix = "http://" + request.getServerName() + ":" + request.getServerPort() + contPath;
        // Check if the user is already logged in
        boolean isLoggedIn = userService.isLogin(request);
        if (isLoggedIn) {
            // Redirect authenticated users away from the login page
            response.sendRedirect("/main");
            return false; // Return false to stop further processing
        }
        return true; // Allow the request to proceed
    }



    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        // This method is empty, but you can override it if needed
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
                                Exception ex) throws Exception {
        // This method is empty, but you can override it if needed
    }


}
