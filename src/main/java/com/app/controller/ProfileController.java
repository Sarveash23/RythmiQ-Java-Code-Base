package com.app.controller;

import com.app.model.User;
import com.app.service.UserService;
import com.app.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Sarveashwaran
 */


@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @RequestMapping("/profile")
    public String profile(@ModelAttribute("userForm") User userForm, HttpServletRequest request, Model model){
        if(!userService.isLogin(request)) return "redirect:/login";
        userForm = userService.loginUser(request);
        model.addAttribute("userForm", userForm);
        model.addAttribute("edit", false);
        return "profile-new";
    }

    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute("userForm") User userForm, HttpServletRequest request, Model model){
        if(!userService.isLogin(request)) return "redirect:/login";
        userService.update(userForm, request);
        return "redirect:/profile";
    }

    @RequestMapping("/edit-profile")
    public String editProfile(@ModelAttribute("userForm") User userForm, HttpServletRequest request, Model model){
        if(!userService.isLogin(request)) return "redirect:/login";
        userForm = userService.loginUser(request);
        model.addAttribute("userForm", userForm);
        model.addAttribute("edit", true);
        return "profile-new";
    }


}
