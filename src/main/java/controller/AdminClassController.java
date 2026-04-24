package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.ClassDto;
import service.AdminClassService;
import service.ClassService;

@Controller
@RequestMapping("/admin/class")
public class AdminClassController {
	@Autowired
	ClassService classService;
	@Autowired
	AdminClassService adminClassService;
	
    @GetMapping("/list")
    public String listPage(@RequestParam(value="searchType", required=false) String searchType, 
				    		@RequestParam(value="searchContent", required=false) String searchContent,
				    		@RequestParam(value="status", required=false) Integer status,Model model) {
    	List<ClassDto> classlist = adminClassService.getClassList(searchType, searchContent,status);
        model.addAttribute("classList", classlist);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchContent", searchContent);
        model.addAttribute("status", status);
        return "admin/class/list"; 
    }
    
    @PostMapping({"/{action}"})
    @ResponseBody
    public Map<String, Object> updateStatus(@PathVariable("action") String action,@RequestParam("classIds") String classIds) {
        Map<String, Object> response = new HashMap<>();
        int status = 0;
        if ("approve".equals(action)) status = 1;
        else if ("reject".equals(action)) status = 0;
        else if ("delete".equals(action)) status = -1;
        try {
            adminClassService.updateStatuses(classIds,status);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
        }
        return response;
    }

}
