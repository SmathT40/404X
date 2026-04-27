package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import dto.User;
import service.UserMypageService;

@Controller
public class UserMypageController {

	@Autowired
	private UserMypageService userMypageService;
	
	@GetMapping("/mypage/index")
	public String userMypage(HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		User user = userMypageService.getUserInfo(loginUser.getUser_id());
		model.addAttribute("user", user);
		
		return "user/mypage/index";
	}
	
	@PostMapping("/mypage/updatePw")
	public String updatePw(String currentPw, String newPw, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 아래 이프문은 나중에 암호화 할 거면 필히 바꿔야 함.
		if (!loginUser.getUser_pw().equals(currentPw)) {
			model.addAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
			return "user/mypage/editInfo";
		}
		
		userMypageService.updatePw(loginUser.getUser_id(), newPw);
		
		loginUser.setUser_pw(newPw);
		session.setAttribute("loginUser", loginUser);
		
		return "redirect:/mypage/index?msg=pwSuccess";
	}
	
	@PostMapping("/mypage/updateInfo")
	public String updateInfo(User user, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		user.setUser_id(loginUser.getUser_id());
		
		userMypageService.updateUserInfo(user);
		
		loginUser.setUser_name(user.getUser_name());
		loginUser.setUser_birth(user.getUser_birth());
		loginUser.setUser_phone(user.getUser_phone());
		loginUser.setUser_email(user.getUser_email());
		
		session.setAttribute("loginUser", loginUser);
		
		return "redirect:/mypage/index?msg=infoSuccess";
	}
	
	@GetMapping("/mypage/editInfo")
	public String editInfo(HttpSession session, Model model) {
		
	    User loginUser = (User) session.getAttribute("loginUser");
	    
	    User user = userMypageService.getUserInfo(loginUser.getUser_id());
	    
	    model.addAttribute("user", user);
	    
	    return "user/mypage/editInfo";
	}
}
