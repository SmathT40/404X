package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Pay;

@Repository
public class PaymentDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "mapper.PaymentMapper.";

    // 결제 정보 저장
    public void insertPay(Pay pay) {
        sqlSession.insert(NAMESPACE + "insertPay", pay);
    }

    // 수강 중복 체크
    public int existsClass(int classId, String userId) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("classId", classId);
        param.put("userId", userId);
        return sqlSession.selectOne(NAMESPACE + "existsClass", param);
    }

    // 수강 상태 등록
    public void insertClassState(int classId, String userId) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("classId", classId);
        param.put("userId", userId);
        sqlSession.insert(NAMESPACE + "insertClassState", param);
    }
    
 // =========================================================================
 // --- 결제내역 조회 추가 4월 24일---
 // =========================================================================
  public List<Pay> getPayList(String userId, int pageNum, int limit) {
     java.util.Map<String, Object> param = new java.util.HashMap<>();
     param.put("userId", userId);
     param.put("startrow", (pageNum - 1) * limit);
     param.put("limit", limit);
     return sqlSession.selectList(NAMESPACE + "selectPayList", param);
 }

 public int countPay(String userId) {
     return sqlSession.selectOne(NAMESPACE + "countPay", userId);
 }

 //hto 0429
 public void insertPayDetail(int pay_no, int class_id, int price) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("pay_no", pay_no);
	    param.put("class_id", class_id);
	    param.put("detail_price", price);
	    sqlSession.insert(NAMESPACE + "insertPayDetail", param);
	}
}