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
import dto.ClsReplyDto;
import dto.User;
import service.BoardService;
import service.ClsReplyService;
import service.PaymentService;
import service.UserService;

import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import java.util.UUID;

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

/*
    @PostMapping("/user/join")
    public String joinProcess(User user) {
        System.out.println("가입 데이터 : " + user.toString());
        userService.joinUser(user);
        return "redirect:/user/login";
    }
    // 여기까지는 보안 개구림. 아래 걸로 수정해서 보안 개쩔게 업그레이드 시킴 ㅋ
*/
    @PostMapping("/user/join")
    public String joinProcess(User user, Model model,
    						@RequestParam(value="agreePrivacy", defaultValue="off") String agreePrivacy) {
    	
    	// 가입하다가 한 개 빼먹었다고 다 날아가는, 개빡치는 사태를 방지하기 위한 로직
    	model.addAttribute("user", user);
    	
    	// 약관 미동의 시 컷 하는 로직
    	if (!"on".equals(agreePrivacy)) {
    		model.addAttribute("errorMsg", "필수 약관에 동의하셔야 합니다.");
    		return "user/join";
    	}
    	
    	// 1단계 넌 모찌나간다!
    	if (user.getUser_id() == null || user.getUser_id().trim().isEmpty()
    		|| user.getUser_pw() == null || user.getUser_pw().trim().isEmpty()
    		|| user.getUser_name() == null || user.getUser_name().trim().isEmpty()) {
    		
    		model.addAttribute("errorMsg", "필수 입력값이 누락되었습니다. 다시 확인해 주세요.");
    		return "user/join";
    	}
    	
    	// 2단계 너언 모오찌나가안다!
    	boolean isAvailable = userService.isIdAvailable(user.getUser_id());
    	if (!isAvailable) {
    		model.addAttribute("errorMsg", "이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
    		return "user/join";
    	}
    	
        System.out.println("가입 데이터 안전하게 통과 완료 : " + user.getUser_id());
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
 // =========================================================================
 // --- 내가 쓴 댓글 연동 추가 0427 ---
 // =========================================================================
 @Autowired
 private ClsReplyService clsReplyService;

 // ================= [csw 팀원이 짠 마이페이지 로직] =================
 @GetMapping("/mypage/myPost")
 public String myPost(@RequestParam(defaultValue="1") int postPage,
                      @RequestParam(defaultValue="1") int cmtPage,
                      HttpSession session, Model model) {

     // 로그인 세션 연동
     User loginUser = (User) session.getAttribute("loginUser");
     String userId = loginUser != null ? loginUser.getUser_id() : null;

     // 내가 쓴 게시글
     List<Board> myPostList = boardService.getMyPostList(userId, postPage, 10);
     int postTotalPage = boardService.getMyPostTotalPage(userId, 10);

     model.addAttribute("myPostList", myPostList);
     model.addAttribute("postPage", postPage);
     model.addAttribute("postTotalPage", postTotalPage == 0 ? 1 : postTotalPage);

     // 내가 쓴 댓글 0427 연동
     List<ClsReplyDto> myCommentList = clsReplyService.getMyCommentList(userId, cmtPage, 10);
     int cmtTotalPage = clsReplyService.getMyCommentTotalPage(userId, 10);

     model.addAttribute("myCommentList", myCommentList);
     model.addAttribute("cmtPage", cmtPage);
     model.addAttribute("cmtTotalPage", cmtTotalPage == 0 ? 1 : cmtTotalPage);

     return "user/mypage/myPost";
 }
    @Autowired
    private PaymentService paymentService;

 // =========================================================================
 // --- 결제내역 추가 4월 24일---
 // =========================================================================
    @GetMapping("/mypage/payment")
    public String payment(@RequestParam(defaultValue="1") int page,
                          HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        String userId = loginUser != null ? loginUser.getUser_id() : null;

        model.addAttribute("payList", paymentService.getPayList(userId, page, 10));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", paymentService.getPayTotalPage(userId, 10));
        return "user/mypage/payment";
    }
    
    @GetMapping("/user/logout")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "redirect:/";
    }
    
 // =========================================================================
 // --- 네이버 로그인 추가 0427---
 // =========================================================================
 private static final String NAVER_CLIENT_ID = "37Y_6Jg0f0lNq3EcSSpo";
 private static final String NAVER_CLIENT_SECRET = "Ox3uMJoxE1";
 private static final String NAVER_REDIRECT_URI = "http://localhost:8081/404X/user/naver/callback";

 @GetMapping("/user/naver/login")
 public String naverLogin(HttpSession session) {
     String state = UUID.randomUUID().toString();
     session.setAttribute("naverState", state);
     String url = "https://nid.naver.com/oauth2.0/authorize"
             + "?response_type=code"
             + "&client_id=" + NAVER_CLIENT_ID
             + "&redirect_uri=" + NAVER_REDIRECT_URI
             + "&state=" + state;
     return "redirect:" + url;
 }

 @GetMapping("/user/naver/callback")
 public String naverCallback(@RequestParam String code,
                              @RequestParam String state,
                              HttpSession session, Model model) {
     try {
         String savedState = (String) session.getAttribute("naverState");
         if (!state.equals(savedState)) return "redirect:/user/login";

         RestTemplate rt = new RestTemplate();
         String tokenUrl = "https://nid.naver.com/oauth2.0/token"
                 + "?grant_type=authorization_code"
                 + "&client_id=" + NAVER_CLIENT_ID
                 + "&client_secret=" + NAVER_CLIENT_SECRET
                 + "&code=" + code
                 + "&state=" + state;

         Map<String, Object> tokenRes = rt.getForObject(tokenUrl, Map.class);
         String accessToken = (String) tokenRes.get("access_token");

         HttpHeaders headers = new HttpHeaders();
         headers.add("Authorization", "Bearer " + accessToken);
         HttpEntity<String> entity = new HttpEntity<>(headers);

         Map<String, Object> profileRes = rt.exchange(
             "https://openapi.naver.com/v1/nid/me",
             org.springframework.http.HttpMethod.GET,
             entity, Map.class
         ).getBody();

         Map<String, Object> response = (Map<String, Object>) profileRes.get("response");
         String naverId = "naver_" + (String) response.get("id");
         String userName = (String) response.get("name");
         String userEmail = (String) response.get("email");
         String userPhone = (String) response.get("mobile");
         String birthday = (String) response.get("birthday"); // MM-DD 형식
         String birthyear = (String) response.get("birthyear"); // YYYY 형식
         
         String userBirth = (birthyear != null && birthday != null) ? birthyear + "-" + birthday : null;
         
         User existUser = userService.findByUserId(naverId);
         if (existUser == null) {
             User newUser = new User();
             newUser.setUser_id(naverId);
             newUser.setUser_pw("NAVER_LOGIN");
             newUser.setUser_name(userName);
             newUser.setUser_email(userEmail != null ? userEmail : "");
             newUser.setUser_phone(userPhone != null ? userPhone : "");
             newUser.setUser_birth(userBirth);
             newUser.setUser_role(0);
             newUser.setUser_login_type("NAVER");
             userService.joinUser(newUser);
             existUser = userService.findByUserId(naverId);
         }

         session.setAttribute("loginUser", existUser);
         return "redirect:/";

     } catch (Exception e) {
         e.printStackTrace();
         return "redirect:/user/login";
     }
 }
}