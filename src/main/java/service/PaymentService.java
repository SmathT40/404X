package service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import dao.PaymentDao;
import dto.ClassDto;
import dto.Pay;
import dto.User;
import mapper.ClassMapper;

@Service
public class PaymentService {

    @Autowired
    private PaymentDao paymentDao;

    @Autowired
    private ClassMapper classMapper;

    // 카카오페이 설정
    private static final String SECRET_KEY = "DEV56C9E07E5725687B8934EB1FE8A6B1BF4CA5D";
    private static final String CID = "TC0ONETIME";
    private static final String APPROVE_URL = "http://localhost:8081/404X/payment/kakao/approve";
    private static final String CANCEL_URL = "http://localhost:8081/404X/payment/cart";
    private static final String FAIL_URL = "http://localhost:8081/404X/payment/cart";

    // =========================================================================
    // --- 장바구니 ---
    // =========================================================================

    // 장바구니 담기
    public void addCart(int class_id, HttpSession session) throws Exception {
        List<ClassDto> cart = (List<ClassDto>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        // 중복 체크
        for (ClassDto item : cart) {
            if (item.getClass_id() == class_id) {
                throw new Exception("이미 장바구니에 담긴 강의입니다.");
            }
        }

        ClassDto cls = classMapper.selectClassDetail(class_id);
        if (cls == null) throw new Exception("강의를 찾을 수 없습니다.");

        cart.add(cls);
        session.setAttribute("cart", cart);
    }

    // 장바구니 개별 삭제
    public void deleteCart(int cartIdx, HttpSession session) {
        List<ClassDto> cart = (List<ClassDto>) session.getAttribute("cart");
        if (cart != null && cartIdx < cart.size()) {
            cart.remove(cartIdx);
            session.setAttribute("cart", cart);
        }
    }

    // 장바구니 선택 삭제
    public void deleteCartMulti(String cartIds, HttpSession session) {
        List<ClassDto> cart = (List<ClassDto>) session.getAttribute("cart");
        if (cart == null) return;

        List<Integer> idxList = Arrays.stream(cartIds.split(","))
                .map(Integer::parseInt)
                .sorted((a, b) -> b - a) // 뒤에서부터 삭제
                .collect(Collectors.toList());

        for (int idx : idxList) {
            if (idx < cart.size()) cart.remove(idx);
        }
        session.setAttribute("cart", cart);
    }

    // 결제 페이지용 선택 항목 가져오기
    public List<ClassDto> getCheckoutList(String cartIds, HttpSession session) {
        List<ClassDto> cart = (List<ClassDto>) session.getAttribute("cart");
        if (cart == null) return new ArrayList<>();

        List<Integer> idxList = Arrays.stream(cartIds.split(","))
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        List<ClassDto> checkoutList = new ArrayList<>();
        for (int idx : idxList) {
            if (idx < cart.size()) checkoutList.add(cart.get(idx));
        }
        return checkoutList;
    }

    // =========================================================================
    // --- 카카오페이 ---
    // =========================================================================

    // 카카오페이 결제 준비
    public String kakaoReady(String cartIds, HttpSession session) throws Exception {
        List<ClassDto> checkoutList = getCheckoutList(cartIds, session);

        int total = 0;
        String goods = "";
        for (ClassDto item : checkoutList) {
            total += item.getCls_price();
            goods += item.getCls_title() + ",";
        }
        if (goods.endsWith(",")) goods = goods.substring(0, goods.length() - 1);

        String orderId = "ORDER_" + System.currentTimeMillis();

     // ⭐ 1. 여기서 userId를 가장 먼저 생성합니다. (순서가 제일 중요!)
        User loginUser = (User) session.getAttribute("loginUser");
        String userId = loginUser != null ? loginUser.getUser_id() : "testUser";
        
        // 세션에 저장
        session.setAttribute("kakaoCartIds", cartIds);
        session.setAttribute("kakaoOrderId", orderId);
        session.setAttribute("kakaoGoods", goods);
        session.setAttribute("kakaoTotal", total);
        session.setAttribute("kakaoUserId", userId);

        // 카카오페이 API 호출
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + SECRET_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> params = new HashMap<>();
        params.put("cid", CID);
        params.put("partner_order_id", orderId);
        //4월 24일 수정
  
        params.put("partner_user_id", userId);
        params.put("item_name", goods);
        params.put("quantity", checkoutList.size());
        params.put("total_amount", total);
        params.put("tax_free_amount", 0);
        params.put("approval_url", APPROVE_URL);
        params.put("cancel_url", CANCEL_URL);
        params.put("fail_url", FAIL_URL);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        Map<String, Object> response = rt.postForObject(
            "https://open-api.kakaopay.com/online/v1/payment/ready",
            entity,
            Map.class
        );

        // tid 세션 저장
        session.setAttribute("kakaoTid", response.get("tid"));

        return (String) response.get("next_redirect_pc_url");
    }

    // 카카오페이 결제 승인
    @Transactional
    public void kakaoApprove(String pgToken, HttpSession session) throws Exception {
        String tid = (String) session.getAttribute("kakaoTid");
        String orderId = (String) session.getAttribute("kakaoOrderId");
        // 4월 24일 수정
        String userId = (String) session.getAttribute("kakaoUserId");
        String goods = (String) session.getAttribute("kakaoGoods");
        int total = (int) session.getAttribute("kakaoTotal");
        String cartIds = (String) session.getAttribute("kakaoCartIds");

        // 카카오페이 승인 API 호출
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + SECRET_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> params = new HashMap<>();
        params.put("cid", CID);
        params.put("tid", tid);
        params.put("partner_order_id", orderId);
        params.put("partner_user_id", userId);
        params.put("pg_token", pgToken);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        rt.postForObject(
            "https://open-api.kakaopay.com/online/v1/payment/approve",
            entity,
            Map.class
        );

        // DB 저장
        Pay pay = new Pay();
        pay.setPay_uid(tid);
        pay.setPay_amount(total);
        pay.setPay_method("KAKAO");
        pay.setUser_id(userId);
        pay.setPay_status(1);
        pay.setPay_goods(goods);
        paymentDao.insertPay(pay);

        // 수강 상태 등록
        List<ClassDto> checkoutList = getCheckoutList(cartIds, session);
        for (ClassDto item : checkoutList) {
            if (paymentDao.existsClass(item.getClass_id(), userId) == 0) {
                paymentDao.insertClassState(item.getClass_id(), userId);
            }
        }

        // 장바구니에서 결제한 항목 삭제
        deleteCartMulti(cartIds, session);

        // 카카오페이 세션 정리
        session.removeAttribute("kakaoTid");
        session.removeAttribute("kakaoOrderId");
        session.removeAttribute("kakaoGoods");
        session.removeAttribute("kakaoTotal");
        session.removeAttribute("kakaoCartIds");
    }
    
        // =========================================================================
       // --- 결제내역 조회 추가 4월 24일---
      // =========================================================================
      public List<Pay> getPayList(String userId, int pageNum, int limit) {
      return paymentDao.getPayList(userId, pageNum, limit);
    }

      public int getPayTotalPage(String userId, int limit) {
      int count = paymentDao.countPay(userId);
      return (int) Math.ceil((double) count / limit);
   }
}