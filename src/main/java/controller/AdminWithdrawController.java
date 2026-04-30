package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import service.AdminWithdrawService;

@Controller
public class AdminWithdrawController {

	@Autowired
	private AdminWithdrawService adminWithdrawService;
	
	@PostMapping("/admin/member/withdraw")
	@ResponseBody
	public Map<String, Object> kickUser(@RequestParam("user_id") String user_id) {
		Map<String, Object> response = new HashMap<>();
		
		try {
			adminWithdrawService.withdrawUser(user_id);
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "강퇴 처리 중 오류가 발생했습니다.");
		}
		return response;
	}
	
	@PostMapping("/admin/member/withdrawMulti")
	@ResponseBody
	public Map<String, Object> withdrawMultiUsers(
					@RequestParam("user_ids") List<String> user_ids) {
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			if (user_ids != null && !user_ids.isEmpty()) {
				adminWithdrawService.withdrawMultiUsers(user_ids);
			}
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "선택 삭제 중 오류가 발생했습니다.");
		}
		
		return response;
	}
}
