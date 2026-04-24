package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import dao.AdminPaymentDao;
import dto.Pay;

@Service
public class AdminPaymentService {

    @Autowired
    private AdminPaymentDao adminPaymentDao;

    private static final String SECRET_KEY = "DEV56C9E07E5725687B8934EB1FE8A6B1BF4CA5D";
    private static final String CID = "TC0ONETIME";

    public int getKakaoPayTotal() { return adminPaymentDao.getKakaoPayTotal(); }
    public int getMonthSales() { return adminPaymentDao.getMonthSales(); }
    public int getRefundCount() { return adminPaymentDao.getRefundCount(); }
    public int getPendingCount() { return adminPaymentDao.getPendingCount(); }
    public List<Pay> getPendingList() { return adminPaymentDao.getPendingList(); }
    public List<Pay> getRecentPayList() { return adminPaymentDao.getRecentPayList(); }

    public List<Pay> getPayList(int pageNum, int limit, String keyword) {
        return adminPaymentDao.getPayList(pageNum, limit, keyword);
    }

    public int getPayTotalPage(int limit, String keyword) {
        int count = adminPaymentDao.countPayList(keyword);
        return (int) Math.ceil((double) count / limit);
    }

    public List<Pay> getAllPayList(int pageNum, int limit, String keyword) {
        return adminPaymentDao.getAllPayList(pageNum, limit, keyword);
    }

    public int getAllPayTotalPage(int limit, String keyword) {
        int count = adminPaymentDao.countAllPayList(keyword);
        return (int) Math.ceil((double) count / limit);
    }

    // 카카오페이 환불
    public void refund(int pay_no) throws Exception {
        Pay pay = adminPaymentDao.getPayOne(pay_no);
        if (pay == null) throw new Exception("결제 정보를 찾을 수 없습니다.");
        if (pay.getPay_status() == -1) throw new Exception("이미 환불된 결제입니다.");

        RestTemplate rt = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "SECRET_KEY " + SECRET_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, Object> params = new HashMap<>();
        params.put("cid", CID);
        params.put("tid", pay.getPay_uid());
        params.put("cancel_amount", pay.getPay_amount());
        params.put("cancel_tax_free_amount", 0);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);

        rt.postForObject(
            "https://open-api.kakaopay.com/online/v1/payment/cancel",
            entity,
            Map.class
        );

        // DB 상태 변경 (-1 = 환불)
        adminPaymentDao.updatePayStatus(pay_no, -1);
    }
}