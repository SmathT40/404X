package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.ClassDto;
import dto.User;
import service.InstructorMyClassService;

@Controller
public class InstructorMyClassController {

	@Autowired
	private InstructorMyClassService instructorMyClassService;
	
	@GetMapping("/mypage/instructor/myClass")
	public String showMyClassList(HttpSession session,
								Model model,
								@RequestParam(value = "page", defaultValue = "1") int page) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		String user_id = loginUser.getUser_id();
		
		List<ClassDto> myClassList = instructorMyClassService.getMyClassList(user_id);
		
		int totalPage = instructorMyClassService.getTotalPage(user_id);
		
		model.addAttribute("myClassList", myClassList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		
		return "user/mypage/instructor/myClass";
	}
}
