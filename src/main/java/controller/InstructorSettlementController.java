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
	                                // 🚀 1. 파라미터로 target_id를 받을 수 있게 추가!
	                                @RequestParam(value = "target_id", required = false) String target_id,
	                                @RequestParam(value = "page", defaultValue = "1") int page) {
	    
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/user/login";
	    }
	    
	    // 어떤 목록을 보여줄 지를 결정하는 것.
	    // target_id가 없으면(강사 본인 접속) 로그인한 아이디를 쓰고, 
	    // target_id가 있으면(관리자가 특정 강사 페이지 접속) 그 아이디를 써야 해.
	    String searchId = (target_id == null || target_id.isEmpty()) ? loginUser.getUser_id() : target_id;
	    
	    int pageSize = 10;
	    int offset = (page - 1) * pageSize;
	    
	    // 대상자 아이디 던질 것.
	    int totalCount = instructorSettlementService.getSettlementCount(searchId);
	    
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
	    if (totalPage == 0) {
	        totalPage = 1;
	    }
	    
	    // 대상자 아이디로 가져올 것.
	    List<Settlement> settlementList = instructorSettlementService.getSettlementList(searchId, offset, pageSize);

	    model.addAttribute("settlementList", settlementList);
	    model.addAttribute("currentPage", page);
	    
	    // 이제는 페이징 되지롱
	    model.addAttribute("totalPage", totalPage);
	    
	    // 글쓰기 할 때 target_id에 대상자 이름 집어 넣기
	    model.addAttribute("target_id", searchId);
	    
	    return "user/mypage/instructor/settlement";
	}
	
	
	@GetMapping("/mypage/instructor/settlement/form")
	public String showSettlementForm(HttpSession session,
									Model model,
									@RequestParam(value = "target_id", required = false) String target_id,
									@RequestParam(value = "id", defaultValue = "0") int settle_id) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/user/login";
			// 나중에 여기에다가 관리자만 가능하게 하는 로직 추가해야 함.
			// 일단 지금은 강사도 쓸 수 있게 해서 테스트할 생각
		}
		
		if (settle_id > 0) {
			// 이거슨 수정이여!
			Settlement st = instructorSettlementService.getSettlementDetail(settle_id);
			model.addAttribute("st", st);
		} else {
			// 이거슨 신규 등록이여!
			model.addAttribute("target_id", target_id);
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
