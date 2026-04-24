package mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.*;
import dto.Pay;

@Mapper
public interface AdminPaymentMapper {

    // 카카오페이 총 결제금액
    @Select("SELECT COALESCE(SUM(pay_amount), 0) FROM pay WHERE pay_method = 'KAKAO' AND pay_status = 1")
    int selectKakaoPayTotal();

    // 이번달 매출
    @Select("SELECT COALESCE(SUM(pay_amount), 0) FROM pay WHERE pay_status = 1 AND DATE_FORMAT(pay_date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')")
    int selectMonthSales();

    // 환불완료 건수
    @Select("SELECT COUNT(*) FROM pay WHERE pay_status = -1")
    int selectRefundCount();

    // 결제 대기 수
    @Select("SELECT COUNT(*) FROM pay WHERE pay_status = 0")
    int selectPendingCount();

    // 결제 대기 목록 (메인용 5개)
    @Select("SELECT * FROM pay ORDER BY pay_no DESC LIMIT 5")
    List<Pay> selectPendingList();

    // 최근 결제내역 (메인용 5개)
    @Select("SELECT * FROM pay ORDER BY pay_no DESC LIMIT 5")
    List<Pay> selectRecentPayList();

    // 결제승인 탭 목록
    @Select("<script>" +
            "SELECT * FROM pay WHERE pay_status != 0 " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "AND pay_uid LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "ORDER BY pay_no DESC LIMIT #{startrow}, #{limit}" +
            "</script>")
    List<Pay> selectPayList(Map<String, Object> param);

    @Select("<script>" +
            "SELECT COUNT(*) FROM pay WHERE pay_status != 0 " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "AND pay_uid LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "</script>")
    int countPayList(Map<String, Object> param);

    // 전체 결제내역
    @Select("<script>" +
            "SELECT * FROM pay " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "WHERE pay_goods LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "ORDER BY pay_no DESC LIMIT #{startrow}, #{limit}" +
            "</script>")
    List<Pay> selectAllPayList(Map<String, Object> param);

    @Select("<script>" +
            "SELECT COUNT(*) FROM pay " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "WHERE pay_goods LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "</script>")
    int countAllPayList(Map<String, Object> param);

    // pay_uid 조회 (환불용)
    @Select("SELECT * FROM pay WHERE pay_no = #{value}")
    Pay selectPayOne(int pay_no);

    // 결제 상태 변경
    @Update("UPDATE pay SET pay_status = #{status} WHERE pay_no = #{pay_no}")
    void updatePayStatus(@Param("pay_no") int pay_no, @Param("status") int status);
}