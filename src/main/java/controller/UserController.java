package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.User;
import service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/join")
	public String joinForm() {
		return "user/join";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "user/login";
	}
	
	@PostMapping("/checkId")
	@ResponseBody
	public Map<String, Boolean> checkId(String user_id) {
		Map<String, Boolean> res = new HashMap<>();
		
		boolean isAvailable = userService.isIdAvailable(user_id);
		res.put("available", isAvailable);
		
		return res;
	}
	
	@PostMapping("/join")
	public String joinProcess(User user) {
		
		System.out.println("가입 데이터 : " + user.toString());
		
		userService.joinUser(user);
		
		return "redirect:/user/login";
	}
}
