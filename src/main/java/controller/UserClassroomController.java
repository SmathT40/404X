package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dto.User;
import dto.myClassDto;
import service.UserClassroomService;

@Controller
public class UserClassroomController {
	@Autowired
	private UserClassroomService userClassroomService;
	
	@GetMapping("/mypage/classroom")
	public String classRoom(Model model,HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
	        return "redirect:/login"; 
	    }
		List<myClassDto> myclassList = userClassroomService.getList(loginUser.getUser_id());
		model.addAttribute("myclassList", myclassList);
		return "user/mypage/classroom";
	}

}
