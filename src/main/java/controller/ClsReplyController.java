package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import dto.ClsReplyDto;
import dto.User;
import service.ClsReplyService;

@RestController
@RequestMapping("/class/comment")
public class ClsReplyController {

    @Autowired
    private ClsReplyService clsReplyService;

    @PostMapping("/insert")
    @ResponseBody // 혹은 @RestController 사용 (JSON 리턴을 위해 필수!)
    public Map<String, Object> insertReply(@RequestBody ClsReplyDto dto, HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();
        
        // 1. 세션 체크 (로그인 여부)
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            resultMap.put("success", false);
            resultMap.put("message", "로그인이 필요합니다.");
            return resultMap;
        }
        
        // 2. 데이터 세팅 및 서비스 호출
        dto.setUser_id(loginUser.getUser_id());
        int result = clsReplyService.addReply(dto);
        
         // =========================================================================
        // --- 관리자가 문의사항 댓글 달면 자동 답글완료 처리 추가 0428 1223 csw ---
        // =========================================================================
        if (result > 0 && dto.getBoard_no() != null && loginUser.getUser_role() >= 2) {
            clsReplyService.updateBoardStatus(dto.getBoard_no(), 1);
        }
        // 3. 결과 반환
        resultMap.put("success", result > 0);
        return resultMap;
    }
    @GetMapping("/detail")
    public String detail(@RequestParam("id") int class_id, Model model) {
        // 2. 댓글 목록 가져오기
        List<ClsReplyDto> replyList = clsReplyService.getReplyList(class_id,null);
        model.addAttribute("replyList", replyList); // JSP의 c:forEach items="${replyList}"와 일치해야 함
        
        return "class/detail";
    }
    @PostMapping("/delete")
    @ResponseBody // AJAX 요청이므로 페이지 이동이 아닌 JSON 응답을 보냄
    public Map<String, Object> delete(@RequestParam("cls_reply_no") int cls_reply_no, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        boolean isDeleted = clsReplyService.deleteComment(cls_reply_no, loginUser.getUser_id(), loginUser.getUser_role());
        if (isDeleted) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("message", "삭제 권한이 없거나 실패했습니다.");
        }
        return result;
    }
}
