package com.app.controller;

import com.app.dto.SaveChatBody;
import com.app.model.Chat;
import com.app.model.User;
import com.app.other.Other;
import com.app.repository.ChatRepo;
import com.app.service.UserService;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by: arif hosain Created at : 4/13/2024
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
        LocalDateTime today12AM = LocalDateTime.of(LocalDate.now().getYear(), LocalDate.now().getMonth(), LocalDate.now().getDayOfMonth(), 0, 0, 0);

        LocalDateTime weekstart = LocalDateTime.now().minusDays(7);
        LocalDateTime monthStart = LocalDateTime.now().with(TemporalAdjusters.firstDayOfMonth());

        List<Chat> today = chatRepo.findAll();
        //List<Chat> today = chatRepo.findAllByCreatedAtGreaterThanEqualOrderByCreatedAtDesc(today12AM);
        //List<Chat> thisWeek = chatRepo.findAllByCreatedAtGreaterThanEqualOrderByCreatedAtDesc(weekstart);
        //List<Chat> thisMonth = chatRepo.findAllByCreatedAtGreaterThanEqualOrderByCreatedAtDesc(monthStart);

        
        
        model.addAttribute("today", today);
        //model.addAttribute("thisWeek", thisWeek);
        //model.addAttribute("thisMonth", thisMonth);
        
        return "main";
    }

    @RequestMapping(value = "/save-data", method = {RequestMethod.POST})
    @ResponseBody
    @Procedure(value = "application/json")
    public String saveData(@RequestBody SaveChatBody body, HttpServletRequest request) {
        if (null != body.getTitle() && !body.getTitle().trim().isEmpty()) {
            userService.saveChat(body, request);
            return "{\"saved\":true}";
        }
        return "{\"saved\":false,\"error\":\"Title should not be empty\"}";
    }

}
