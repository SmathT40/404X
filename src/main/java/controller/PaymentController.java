package controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PaymentController {

    // 1. 장바구니 목록 조회
    @GetMapping("/payment/cart")
    public String cartList(Model model) {
        // model.addAttribute("cartList", paymentService.getCartList(userId));
        return "payment/cart"; 
    }

    // 2. 장바구니 선택 삭제 (AJAX)
    @ResponseBody
    @PostMapping("/cart/deleteMulti")
    public String deleteMulti(@RequestParam("cartIds") String cartIds) {
        // int result = paymentService.deleteMulti(cartIds);
        return "{\"success\":true}"; 
    }

    // 3. 장바구니 개별 삭제 (AJAX)
    @ResponseBody
    @PostMapping("/cart/delete")
    public String deleteItem(@RequestParam("cartId") int cartId) {
        // int result = paymentService.delete(cartId);
        return "{\"success\":true}";
    }

    // 4. 결제 페이지 이동
    @GetMapping("/payment/checkout")
    public String checkout(@RequestParam("cartIds") String cartIds, Model model) {
        // model.addAttribute("checkoutList", paymentService.getCheckoutList(cartIds));
        return "payment/checkout";
    }
    
 // 5. 결제 실행 (AJAX 요청 대응)
    @ResponseBody
    @PostMapping("/payment/pay")
    public String doPay(@RequestParam("cartIds") String cartIds, 
                        @RequestParam("payMethod") String payMethod,
                        HttpSession session) {
        
        // 여기에 결제 로직 (DB pay 테이블 insert 등) 구현
        // UserVO user = (UserVO) session.getAttribute("loginUser");
        
        return "{\"success\":true}"; // 결제 성공 시
    }
}