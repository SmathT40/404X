package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dao.BoardDao;

@Controller
public class MainController {

	@Autowired
    private BoardDao boardDao;
	
    @GetMapping("/")
    public String mainPage(Model model) {
        // =========================================================================
        // --- 메인 공지사항 상단고정 3개 추가 0429 ---
        // =========================================================================
        model.addAttribute("recentNoticeList", boardDao.selectFeaturedNotice());
        return "main"; // /WEB-INF/views/index.jsp를 호출
    }
    @GetMapping("/reset")
    public String reset(HttpSession session) {
        session.invalidate(); // 세션 완전 초기화
        return "redirect:/";
    }
	@GetMapping("/about")
	public String about(){
		return "board/about";
	}
	
	
//	@GetMapping("/test-login/{role}")
//	public String testLogin(@PathVariable String role, HttpSession session) {
//	    User testUser = new User();
//	    
//	    if ("admin".equals(role)) {
//	        // 1. user_id는 String이므로 따옴표("")로 감싸야 합니다.
//	        testUser.setUser_id("1"); 
//	        testUser.setUser_name("관리자맨");
//	        // 2. user_role은 Integer이므로 숫자를 넣어야 합니다. (관리자 권한 번호 확인 필요)
//	        testUser.setUser_role(2); 
//	    } else {
//	        // 1. String 타입 맞춤
//	        testUser.setUser_id("10"); 
//	        testUser.setUser_name("열혈강사");
//	        // 2. "HOST"라는 문자열은 Integer 타입인 user_role에 들어갈 수 없습니다. 숫자(예: 1)를 넣으세요.
//	        testUser.setUser_role(1); 
//	    }
//	    
//	    session.setAttribute("loginUser", testUser);
//	    System.out.println("--- [TEST LOGIN] " + role + " 모드로 접속 중 ---");
//	    
//	    return "redirect:/" + role + "/class/list";
//	}
}