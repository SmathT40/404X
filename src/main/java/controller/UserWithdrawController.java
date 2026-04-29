package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.User;
import service.UserWithdrawService;

@Controller
public class UserWithdrawController {

	@Autowired
	private UserWithdrawService userWithdrawService;
	
	@PostMapping("/user/withdraw")
	@ResponseBody
	public Map<String, Object> withdrawMyAccount(
			@RequestParam("user_pw") String user_pw, HttpSession session) {
		
		Map<String, Object> response = new HashMap<>();
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			response.put("success", false);
			response.put("message", "로그인 정보가 없습니다.");
			return response;
		}
		
		try {
			boolean isDeleted = userWithdrawService.withdrawUser(loginUser.getUser_id(), user_pw);
			
			if (isDeleted) {
				session.invalidate();
				response.put("success", true);
			} else {
				response.put("success", false);
				response.put("message", "비밀번호가 올바르지 않습니다.");
			}
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "탈퇴 처리 중 오류가 발생했습니다.");
		}
		
		return response;
	}
}
