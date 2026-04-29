package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.LecProgDto;
import dto.User;
import service.LecProgService;

@Controller
@RequestMapping("/progress")
public class LecProgController {

    @Autowired
    private LecProgService lecProgService;
    
    @ResponseBody
    @PostMapping("/update")
    public String updateProgress(LecProgDto dto, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        dto.setUser_id(user.getUser_id());
        try {
            lecProgService.upsertProgress(dto);
            return "success"; 
        } catch (Exception e) {
            return "error";
        }
    }
}