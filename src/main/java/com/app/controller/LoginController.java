package com.app.controller;

import com.app.model.User;
import com.app.other.Other;
import com.app.repository.UserRepository;
import com.app.service.UserService;
import com.app.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by: arif hosain Created at : 4/12/2024
 */
@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, @ModelAttribute("login") User login,
            @RequestParam(value = "check", required = false) boolean check,
            HttpServletRequest request, HttpServletResponse response) {
        
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        
        if (userService.isLogin(request)) {
            return "redirect:/main";
        } else {
            if (check) {
                login.setUsername((String) request.getSession().getAttribute("username"));
            }
            model.addAttribute("validUser", check);
            return "login";
        }

    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginAccess(Model model, @ModelAttribute("login") User login, HttpServletRequest request) {
        User user = userRepository.findByUsername(login.getUsername());
        if (user != null) {
            if (Other.encrypt(getString(login.getPassword())).equals(user.getPassword())) {
                userService.login(login.getUsername(), login.getPassword(), request);
                return "redirect:/main";
            } else {
                model.addAttribute("errorUsername", "");
                model.addAttribute("errorPassword", "Invalid Password");
                return "login";
            }

        } else {
            model.addAttribute("errorUsername", "Invalid username");
            model.addAttribute("errorPassword", "");
            return "login";
        }

    }

    public static boolean isNotEmpty(String str) {
        if (str == null) {
            return false;
        }
        if (str.trim().equals("")) {
            return false;
        }
        return str.trim().length() > 0;
    }

    public static String getString(Object value) {
        if (value == null || value.equals("null") || value.equals("")) {
            return "";
        } else {
            return value.toString().trim();
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }
}
