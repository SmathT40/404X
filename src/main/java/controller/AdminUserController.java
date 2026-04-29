package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dto.User;
import service.AdminUserService;

@Controller
public class AdminUserController {
	
	@Autowired
	private AdminUserService adminUserService;
	
	@GetMapping("/admin/member/list")
	public String showUserList(HttpSession session,
							Model model,
							@RequestParam(value = "keyword", required = false) String keyword,
							@RequestParam(value = "page", defaultValue = "1") int page) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		if (loginUser.getUser_role() != 2) {
			return "redirect:/";
		}
		
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		
		int totalCount = adminUserService.getUserCount(keyword);
		
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		if (totalPage == 0) {
			totalPage = 1;
		}
		
		List<User> userList = adminUserService.getUserList(keyword, offset, pageSize);
		
		model.addAttribute("userList", userList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("keyword", keyword);
		
		return "admin/member/list";
	}
}
