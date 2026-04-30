package controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dao.BoardDao;
import dto.User;
import service.ClassService;
import service.UserClassroomService;

@Controller
public class MainController {

	@Autowired
    private BoardDao boardDao;
	
    @GetMapping("/")
    public String mainPage(Model model, HttpSession session) {
        // =========================================================================
        // --- 메인 공지사항 상단고정 3개 추가 0429 csw ---
        // =========================================================================
        model.addAttribute("recentNoticeList", boardDao.selectFeaturedNotice());
        
        addFeaturedClass(model);
        myClass(model, session);
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
	
	@Autowired
	ClassService classService;
	
	public String addFeaturedClass(Model model) {
		model.addAttribute("bestClassList", classService.getFeaturedClassList());
		return "main";
	}
	@Autowired
	UserClassroomService userClassroomService;
	
	public String myClass(Model model,HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
	        return "main"; 
	    }
		model.addAttribute("myClassList",userClassroomService.getList(loginUser.getUser_id()));
		return "main";
	}
	

}