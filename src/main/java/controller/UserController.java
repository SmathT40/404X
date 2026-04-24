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

import dto.Board;
import dto.User;
import service.BoardService;
import service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // [csw 팀원이 추가한 서비스]
    @Autowired
    private BoardService boardService;

    // ================= [공통 회원가입/로그인] =================
    @GetMapping("/user/join")
    public String joinForm() {
        return "user/join";
    }

    @GetMapping("/user/login")
    public String loginForm() {
        return "user/login";
    }

    @PostMapping("/user/checkId")
    @ResponseBody
    public Map<String, Boolean> checkId(String user_id) {
        Map<String, Boolean> res = new HashMap<>();
        boolean isAvailable = userService.isIdAvailable(user_id);
        res.put("available", isAvailable);
        return res;
    }

    @PostMapping("/user/join")
    public String joinProcess(User user) {
        System.out.println("가입 데이터 : " + user.toString());
        userService.joinUser(user);
        return "redirect:/user/login";
    }

    // ================= [상현이가 짠 핵심 로직] =================
    // 🚨 JS 코드에 맞춰서 주소 앞에 "/user"를 추가했어!
    @PostMapping("/user/login")
    public String login(String user_id, String user_pw, HttpSession session, Model model) {
        User loginUser = userService.loginCheck(user_id, user_pw);
        
        if (loginUser != null) {
            session.setAttribute("loginUser", loginUser);
            return "redirect:/"; // 로그인 성공
        } else {
            model.addAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "user/login";
        }
    }
    
    @PostMapping("/user/findId")
    @ResponseBody
    public Map<String, Object> findId(String user_name, String user_email) {
        Map<String, Object> result = new HashMap<>();
        String user_id = userService.findId(user_name, user_email);
        
        if (user_id != null) {
            result.put("success", true);
            result.put("user_id", user_id);
        } else {
            result.put("success", false);
        }
        return result;
    }
    
    @PostMapping("/user/findPw")
    @ResponseBody
    public Map<String, Object> findPw(String user_id, String user_name, String user_email) {
        Map<String, Object> result = new HashMap<>();
        
        boolean isSuccess = userService.issueTempPassword(user_id, user_name, user_email);
        result.put("success", isSuccess);
        
        return result;
    }

    // ================= [csw 팀원이 짠 마이페이지 로직] =================
    @GetMapping("/mypage/myPost")
    public String myPost(@RequestParam(defaultValue="1") int postPage,
                         @RequestParam(defaultValue="1") int cmtPage,
                         HttpSession session, Model model) {

        // 로그인 세션 연동
        String userId = (String) session.getAttribute("user_id");

        // 내가 쓴 게시글
        List<Board> myPostList = boardService.getMyPostList(userId, postPage, 10);
        int postTotalPage = boardService.getMyPostTotalPage(userId, 10);

        model.addAttribute("myPostList", myPostList);
        model.addAttribute("postPage", postPage);
        model.addAttribute("postTotalPage", postTotalPage == 0 ? 1 : postTotalPage);

        // 내가 쓴 댓글 (댓글 팀원 완성 후 연동)
        model.addAttribute("cmtPage", cmtPage);
        model.addAttribute("cmtTotalPage", 1);

        return "user/mypage/myPost";
    }
}