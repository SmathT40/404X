package controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import service.AdminBoardService;
import service.BoardService;

@Controller
@RequestMapping("/admin/board")
public class AdminBoardController {

    @Autowired
    private AdminBoardService adminBoardService;

    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue="1") int page,
                       @RequestParam(defaultValue="") String keyword,
                       Model model) {
        model.addAttribute("postList", adminBoardService.getAdminPostList(page, 10, keyword));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", adminBoardService.getAdminPostTotalPage(10, keyword));
        model.addAttribute("activeTab", "list");
        return "admin/board/list";
    }

    @ResponseBody
    @PostMapping("/deletePost")
    public Map<String, Object> deletePost(@RequestParam int board_no) {
        Map<String, Object> result = new HashMap<>();
        try {
            boardService.delete(board_no);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

    @ResponseBody
    @PostMapping("/deleteMulti")
    public Map<String, Object> deleteMulti(@RequestParam String board_nos) {
        Map<String, Object> result = new HashMap<>();
        try {
            for (String no : board_nos.split(",")) {
                boardService.delete(Integer.parseInt(no.trim()));
            }
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

    @ResponseBody
    @PostMapping("/approve")
    public Map<String, Object> approve(@RequestParam int board_no) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminBoardService.updateStatus(board_no, 1);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

    @ResponseBody
    @PostMapping("/reject")
    public Map<String, Object> reject(@RequestParam int board_no) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminBoardService.updateStatus(board_no, 0);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
}