package controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.MailService;

@Controller
@RequestMapping("/admin/mail")
public class AdminMailController {

    @Autowired
    private MailService mailService;

    @GetMapping("/form")
    public String mailForm(@RequestParam(required=false) String emails, Model model) {
        model.addAttribute("emails", emails);
        return "admin/member/mailForm";
    }

    @ResponseBody
    @PostMapping("/send")
    public Map<String, Object> sendMail(@RequestParam String emails,
                                         @RequestParam String subject,
                                         @RequestParam String content) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<String> emailList = Arrays.asList(emails.split(","));
            mailService.sendAdminMail(emailList, subject, content);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
}