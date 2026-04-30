package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import dto.Pay;
import dto.User;

@Mapper
public interface AdminDashboardMapper {

    // 전체 회원 수
    @Select("SELECT COUNT(*) FROM users")
    int selectTotalMember();

    // 이번달 매출
    @Select("SELECT COALESCE(SUM(pay_amount), 0) FROM pay WHERE pay_status = 1 AND DATE_FORMAT(pay_date, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')")
    int selectMonthSales();

    // 등록 클래스 수
    @Select("SELECT COUNT(*) FROM cls WHERE cls_status = 1")
    int selectTotalClass();

    // 승인 대기 수
    @Select("SELECT COUNT(*) FROM pay WHERE pay_status = 0")
    int selectPendingCount();

    // 최근 결제 내역 5개
    @Select("SELECT * FROM pay ORDER BY pay_no DESC LIMIT 5")
    List<Pay> selectRecentPayList();
    
    @Select("SELECT user_id, user_name, user_email, user_join_date FROM users WHERE host_status = 0 AND user_role = 1 LIMIT 5")
    List<User> selectHostRequestList();

}