package controller;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dto.ClassDto;
import service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    // =========================================================================
    // --- 장바구니 ---
    // =========================================================================

    // 장바구니 목록
    /*
    @GetMapping("/cart")
    public String cartList(HttpSession session, Model model) {
        List<ClassDto> cartList = (List<ClassDto>) session.getAttribute("cart");
        model.addAttribute("cartList", cartList);
        return "payment/cart";
    }
    */
    @GetMapping("/cart")
    public String cartList(HttpSession session, Model model) {
        
        List<ClassDto> cartList = (List<ClassDto>) session.getAttribute("cart");
        model.addAttribute("cartList", cartList);
        return "payment/cart";
    } 
    
    // 장바구니 담기
    @ResponseBody
    @PostMapping("/cart/add")
    public Map<String, Object> cartAdd(@RequestParam int class_id,
                                        HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            paymentService.addCart(class_id, session);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("msg", e.getMessage());
        }
        return result;
    }

    // 장바구니 개별 삭제
    @ResponseBody
    @PostMapping("/cart/delete")
    public Map<String, Object> cartDelete(@RequestParam int cartIdx,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            paymentService.deleteCart(cartIdx, session);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

    // 장바구니 선택 삭제
    @ResponseBody
    @PostMapping("/cart/deleteMulti")
    public Map<String, Object> cartDeleteMulti(@RequestParam String cartIds,
                                                HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            paymentService.deleteCartMulti(cartIds, session);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }

    // =========================================================================
    // --- 결제 ---
    // =========================================================================

    // 결제 페이지
    @GetMapping("/checkout")
    public String checkout(@RequestParam(required = false) String cartIds,
                           HttpSession session, Model model) {
    	List<ClassDto> checkoutList = paymentService.getCheckoutList(cartIds, session);
        model.addAttribute("checkoutList", checkoutList);
        model.addAttribute("cartIds", cartIds);
        return "payment/checkout";
        //테스트용
    	 /*
        List<ClassDto> checkoutList = (List<ClassDto>) session.getAttribute("cart");
        if(checkoutList == null) checkoutList = new ArrayList<>();
        
        model.addAttribute("checkoutList", checkoutList);
        model.addAttribute("cartIds", cartIds != null ? cartIds : "");
        return "payment/checkout";
        */        
    }

    // 카카오페이 결제 준비
    @ResponseBody
    @PostMapping("/kakao/ready")
    public Map<String, Object> kakaoReady(@RequestParam String cartIds,
                                           @RequestParam String payMethod,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            String redirectUrl = paymentService.kakaoReady(cartIds, session);
            result.put("success", true);
            result.put("redirectUrl", redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("msg", "결제 준비 실패");
        }
        return result;
    }

    // 카카오페이 결제 승인
    @GetMapping("/kakao/approve")
    public String kakaoApprove(@RequestParam("pg_token") String pgToken,
                                HttpSession session) {
        try {
            paymentService.kakaoApprove(pgToken, session);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/mypage/classroom";
    }
    
}