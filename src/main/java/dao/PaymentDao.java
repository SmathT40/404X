package dao;

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
}