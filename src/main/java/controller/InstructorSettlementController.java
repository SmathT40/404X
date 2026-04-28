package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.Settlement;
import dto.User;
import service.InstructorSettlementService;

@Controller
public class InstructorSettlementController {
	
	@Autowired
	private InstructorSettlementService instructorSettlementService;
	
	@GetMapping("/mypage/instructor/settlement")
	public String showSettlementList(HttpSession session,
									Model model,
									@RequestParam(value = "page", defaultValue = "1") int page) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		String user_id = loginUser.getUser_id();
		
		int pageSize = 10;
		int offset = (page - 1) * pageSize;
		
		int totalCount = instructorSettlementService.getSettlementCount(user_id);
		
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		if (totalPage == 0) {
			totalPage = 1;
		}
		
		List<Settlement> settlementList = instructorSettlementService.getSettlementList(user_id, offset, pageSize);

		model.addAttribute("settlementList", settlementList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", 1);
		
		return "user/mypage/instructor/settlement";
	}
	// ***************************나중에 페이징 로직 넣어야 함***************************
	
	
	@GetMapping("/mypage/instructor/settlement/form")
	public String showSettlementForm(HttpSession session,
									Model model,
									@RequestParam(value = "id", defaultValue = "0") int settle_id) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
			// 나중에 여기에다가 관리자만 가능하게 하는 로직 추가해야 함.
			// 일단 지금은 강사도 쓸 수 있게 해서 테스트할 생각
		}
		
		if (settle_id > 0) {
			Settlement st = instructorSettlementService.getSettlementDetail(settle_id);
			model.addAttribute("st", st);
		}
		return "user/mypage/instructor/settlementForm";
	}
	
	
	@GetMapping("/mypage/instructor/settlement/detail")
	public String showSettlementDetail(HttpSession session,
									Model model,
									@RequestParam("id") int settle_id) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		Settlement detail = instructorSettlementService.getSettlementDetail(settle_id);
		
		model.addAttribute("st", detail);
		
		return "user/mypage/instructor/settlementDetail";
	}
	
	
	@PostMapping("/mypage/instructor/settlement/register")
	public String registerSettlement(Settlement st, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
		}
		
		st.setUser_id(loginUser.getUser_id());
		
		if (st.getSettle_id() > 0) {
			instructorSettlementService.updateSettlement(st);		// 점심 먹고 여기서부터
		} else {
			instructorSettlementService.insertSettlement(st);
		}
		
		instructorSettlementService.insertSettlement(st);
		
		return "redirect:/mypage/instructor/settlement";
	}
	
	@PostMapping("/mypage/instructor/settlement/delete")
	@ResponseBody
	public Map<String, Object> deleteSettlement(@RequestParam("settle_id") int settle_id) {
		Map<String, Object> result = new HashMap<>();
		try {
			instructorSettlementService.deleteSettlement(settle_id);
			result.put("success", true);
		} catch (Exception e) {
			result.put("success", false);
		}
		return result;
	}
}
