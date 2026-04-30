package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import dto.User;
import service.InstructorMypageService;

@Controller
public class InstructorMypageController {
	
	@Autowired
	private InstructorMypageService instructorMypageService;
	
	@GetMapping("/mypage/instructor")
	public String showInstructorMypage(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		User info = instructorMypageService.getInstructorInfo(loginUser.getUser_id());
		
		model.addAttribute("instructorInfo", info);
		
		return "user/mypage/instructor/mypage";
	}
	
	@GetMapping("/mypage/instructor/register")
	public String showRegisterForm(Model model) {
		model.addAttribute("mode", "register");
		return "user/mypage/instructor/instrForm";
	}
	
	@GetMapping("/mypage/instructor/editInfo")
	public String showEditForm(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		User info = instructorMypageService.getInstructorInfo(loginUser.getUser_id());
		model.addAttribute("instructorInfo", info);
		model.addAttribute("mode", "edit");
		return "user/mypage/instructor/instrForm";
	}
	
	// 강사 등록용
	@PostMapping("/mypage/instructor/register")
	public String registerInstructor(User user, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 세션 만료되거나 하여튼 로그아웃 된 상태면 로그인으로 꺼지세여! ㅎㅎ 꼬우면 로그인 하던가 ㅎㅎㅎㅎㅎ
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		user.setUser_id(loginUser.getUser_id());
		user.setHost_status(1);
		
		instructorMypageService.registerInstructor(user);
		
		return "redirect:/mypage/instructor";
	}
	
	// 강사 정보 수정용
	@PostMapping("/mypage/instructor/update")
	public String updateInstructor(User user, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) return "redirect:/user/login";
		
		user.setUser_id(loginUser.getUser_id());
		
		instructorMypageService.updateInstructorInfo(user); 
		
		return "redirect:/mypage/instructor";
	}
	
}
