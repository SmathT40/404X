package controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String mainPage() {
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
}