package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Pay;
import mapper.AdminPaymentMapper;

@Repository
public class AdminPaymentDao {

    @Autowired
    private SqlSessionTemplate template;

    private Class<AdminPaymentMapper> cls = AdminPaymentMapper.class;

    public int getKakaoPayTotal() { return template.getMapper(cls).selectKakaoPayTotal(); }
    public int getMonthSales() { return template.getMapper(cls).selectMonthSales(); }
    public int getRefundCount() { return template.getMapper(cls).selectRefundCount(); }
    public int getPendingCount() { return template.getMapper(cls).selectPendingCount(); }
    public List<Pay> getPendingList() { return template.getMapper(cls).selectPendingList(); }
    public List<Pay> getRecentPayList() { return template.getMapper(cls).selectRecentPayList(); }

    public List<Pay> getPayList(int pageNum, int limit, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);
        param.put("keyword", keyword);
        return template.getMapper(cls).selectPayList(param);
    }

    public int countPayList(String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        return template.getMapper(cls).countPayList(param);
    }

    public List<Pay> getAllPayList(int pageNum, int limit, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);
        param.put("keyword", keyword);
        return template.getMapper(cls).selectAllPayList(param);
    }

    public int countAllPayList(String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        return template.getMapper(cls).countAllPayList(param);
    }

    public Pay getPayOne(int pay_no) { return template.getMapper(cls).selectPayOne(pay_no); }

    public void updatePayStatus(int pay_no, int status) {
        template.getMapper(cls).updatePayStatus(pay_no, status);
    }
}