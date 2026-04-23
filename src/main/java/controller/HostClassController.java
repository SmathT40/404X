package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.ClassDto;
import dto.User;
import service.ClassService;
import service.HostClassService;

@Controller
@RequestMapping("/host/class")
public class HostClassController {
	@Autowired
	ClassService classService;
	@Autowired
	HostClassService hostClassService;
	
	@GetMapping("list")
	public String listPage( 
    		@RequestParam(value="searchContent", required=false) String searchContent,
    		@RequestParam(value="status", required=false) Integer status,HttpSession session,Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			loginUser = new User();
	        loginUser.setUser_id("kim_teacher");
	        loginUser.setUser_name("KMS");
	        loginUser.setUser_role(2);
	        session.setAttribute("loginUser", loginUser);
	    }
		String userId = loginUser.getUser_id();
		
		List<ClassDto> classlist = hostClassService.getClassList(searchContent,userId,status);
		model.addAttribute("classList", classlist);
        model.addAttribute("searchContent", searchContent);
        model.addAttribute("status", status);
		return "host/class/list"; 
	}
	

}
