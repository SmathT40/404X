package controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dto.User;
import service.AdminHostService;

@Controller
@RequestMapping("/admin/host")
public class AdminHostController {

    @Autowired
    private AdminHostService adminHostService;
    @GetMapping("/{type}")
    public String hostManager(
            @PathVariable("type") String type,
            @RequestParam(value="keyword", required=false) String keyword,
            Model model) {
        
        List<User> hostList;
        
        if ("request".equals(type)) {
            hostList = adminHostService.getHostList(keyword, 0, 1);
            model.addAttribute("activeTab", "request");
        } else {
            hostList = adminHostService.getHostList(keyword, 1, null);
            model.addAttribute("activeTab", "list");
        }

        model.addAttribute("hostList", hostList);
        model.addAttribute("keyword", keyword);

        return "admin/host/list";
    }
    
    @ResponseBody
    @PostMapping("/approve")
    public Map<String, Object> approveOne(@RequestParam("user_id") String user_id) {
        Map<String, Object> result = new HashMap<>();
        try {
            // user_role을 1로, host_status를 2(승인완료)로 변경
            adminHostService.updateToHost(user_id);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("msg", "승인 처리 중 오류 발생");
        }
        return result;
    }
    
    @ResponseBody
    @PostMapping("/reject")
    public Map<String, Object> rejectOne(@RequestParam("user_id") String user_id) {
        Map<String, Object> result = new HashMap<>();
        try {
            // host_status를 3(거절)으로 변경
            adminHostService.rejectHostRequest(user_id);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
    
    @ResponseBody
    @PostMapping("/delete")
    public Map<String, Object> deleteHost(@RequestParam("user_id") String user_id) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 다시 일반 유저(0)로 변경
            adminHostService.demoteToUser(user_id);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
}