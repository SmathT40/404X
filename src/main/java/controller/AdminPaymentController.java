package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dto.Pay;
import service.AdminPaymentService;

@Controller
@RequestMapping("/admin/payment")
public class AdminPaymentController {

    @Autowired
    private AdminPaymentService adminPaymentService;

    @GetMapping("/main")
    public String main(Model model) {
        model.addAttribute("activeTab", "main");
        model.addAttribute("monthSales", adminPaymentService.getMonthSales());
        model.addAttribute("kakaoPayTotal", adminPaymentService.getKakaoPayTotal());
        model.addAttribute("refundCount", adminPaymentService.getRefundCount());
        model.addAttribute("pendingCount", adminPaymentService.getPendingCount());
        model.addAttribute("pendingList", adminPaymentService.getPendingList());
        model.addAttribute("recentPayList", adminPaymentService.getRecentPayList());
        return "admin/payment/list";
    }

    @GetMapping("/approval")
    public String approval(@RequestParam(defaultValue="1") int page,
                           @RequestParam(defaultValue="") String keyword,
                           Model model) {
        model.addAttribute("activeTab", "approval");
        model.addAttribute("payList", adminPaymentService.getPayList(page, 10, keyword));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", adminPaymentService.getPayTotalPage(10, keyword));
        return "admin/payment/list";
    }

    @GetMapping("/history")
    public String history(@RequestParam(defaultValue="1") int page,
                          @RequestParam(defaultValue="") String keyword,
                          Model model) {
        model.addAttribute("activeTab", "history");
        model.addAttribute("payList", adminPaymentService.getAllPayList(page, 10, keyword));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", adminPaymentService.getAllPayTotalPage(10, keyword));
        return "admin/payment/list";
    }

    @ResponseBody
    @PostMapping("/refund")
    public Map<String, Object> refund(@RequestParam int pay_no) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminPaymentService.refund(pay_no);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("msg", e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @PostMapping("/refundMulti")
    public Map<String, Object> refundMulti(@RequestParam String pay_nos) {
        Map<String, Object> result = new HashMap<>();
        try {
            for (String no : pay_nos.split(",")) {
                adminPaymentService.refund(Integer.parseInt(no.trim()));
            }
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("msg", e.getMessage());
        }
        return result;
    }
}