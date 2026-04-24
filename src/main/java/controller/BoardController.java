package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

import dto.Board;
import dto.User;
import service.BoardService;

@Controller
@RequestMapping("/community/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    private String getListView(int boardid) {
        switch(boardid) {
            case 0: return "community/notice/list";
            case 1: return "community/free/list";
            case 2: return "community/faq/list";
            case 3: return "community/inquiry/list";
            default: return "community/free/list";
        }
    }

    private String getDetailView(int boardid) {
        switch(boardid) {
            case 0: return "community/notice/detail";
            case 1: return "community/free/detail";
            case 3: return "community/inquiry/detail";
            default: return "community/free/detail";
        }
    }

    private String getFormView(int boardid) {
        switch(boardid) {
            case 0: return "community/notice/form";
            case 1: return "community/free/form";
            case 3: return "community/inquiry/form";
            default: return "community/free/form";
        }
    }

    @GetMapping("/list")
    public String list(@RequestParam int boardid,
                       @RequestParam(defaultValue="1") int pageNum,
                       @RequestParam(defaultValue="") String searchtype,
                       @RequestParam(defaultValue="") String searchcontent,
                       Model model) {
        int totalCount = boardService.getCount(boardid, searchtype, searchcontent);
        int totalPage = (int) Math.ceil((double) totalCount / 10);

        String listAttr = boardid == 0 ? "noticeList" :
                          boardid == 2 ? "faqList" :
                          boardid == 3 ? "inquiryList" : "boardList";

        model.addAttribute(listAttr, boardService.getList(boardid, pageNum, 10, searchtype, searchcontent));
        model.addAttribute("currentPage", pageNum);
        model.addAttribute("totalPage", totalPage == 0 ? 1 : totalPage);
        model.addAttribute("boardid", boardid);
        return getListView(boardid);
    }

    @GetMapping("/detail")
    public String detail(@RequestParam int boardid,
                         @RequestParam int board_no,
                         Model model) {
        model.addAttribute("board", boardService.getDetail(board_no));
        model.addAttribute("prevPost", boardService.getPrev(boardid, board_no));
        model.addAttribute("nextPost", boardService.getNext(boardid, board_no));
        model.addAttribute("boardid", boardid);
        return getDetailView(boardid);
    }

    @GetMapping("/form")
    public String form(@RequestParam int boardid,
                       Integer board_no,
                       Model model) {
        if (board_no != null) {
            model.addAttribute("board", boardService.getDetail(board_no));
        } else {
            model.addAttribute("board", new Board());
        }
        model.addAttribute("boardid", boardid);
        return getFormView(boardid);
    }
    //4월 24일 수정//
    @PostMapping("/insert")
    public String insert(Board board,
                         @RequestParam(value = "boardid", required = false, defaultValue = "1") int boardid,
                         HttpServletRequest request, RedirectAttributes rttr) {
        try {
        	User loginUser = (User) request.getSession().getAttribute("loginUser");
        	if (loginUser != null) board.setUser_id(loginUser.getUser_id());
            board.setBoard_type(boardid);
            boardService.insert(board, request);
            rttr.addFlashAttribute("msg", "등록되었습니다.");
            return "redirect:/community/board/detail?boardid=" + boardid + "&board_no=" + board.getBoard_no();
        } catch (Exception e) {
            e.printStackTrace();
            return getFormView(boardid);
        }
    }

    @PostMapping("/update")
    public String update(Board board,
                         @RequestParam(value = "boardid", required = false, defaultValue = "1") int boardid,
                         HttpServletRequest request) {
        try {
            boardService.update(board, request);
            return "redirect:/community/board/detail?boardid=" + boardid + "&board_no=" + board.getBoard_no();
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/community/board/list?boardid=" + boardid;
        }
    }

    @PostMapping("/delete")
    public String delete(
            @RequestParam int boardid,
            @RequestParam int board_no){

        try{

            boardService.delete(board_no);

        }catch(Exception e){

            e.printStackTrace();
        }

        return "redirect:/community/board/list?boardid=" + boardid;
    }

    @ResponseBody
    @PostMapping("/uploadImage")
    public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file,
                                           HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            response.put("url", boardService.uploadSummernoteImage(file, request));
        } catch (Exception e) {
            response.put("error", "업로드 실패");
        }
        return response;
    }
}