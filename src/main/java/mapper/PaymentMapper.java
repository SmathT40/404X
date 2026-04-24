package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Pay;

public interface PaymentMapper {
    @Insert(
      "INSERT INTO pay (" +
      "pay_uid," +
      "pay_amount," +
      "pay_method," +
      "user_id," +
      "pay_status," +
      "pay_goods" +
      ") VALUES (" +
      "#{pay_uid}," +
      "#{pay_amount}," +
      "#{pay_method}," +
      "#{user_id}," +
      "#{pay_status}," +
      "#{pay_goods}" +
      ")"
    )
    void insertPay(
        Pay pay
    );

    @Select(
      "SELECT COUNT(*) " +
      "FROM cls_state " +
      "WHERE classno=#{classId} " +
      "AND user_id=#{userId}"
    )
    int existsClass(
        @Param("classId") int classId,
        @Param("userId") String userId
    );

    @Insert(
      "INSERT INTO cls_state (" +
      "classno," +
      "user_id," +
      "cls_state_status" +
      ") VALUES (" +
      "#{classId}," +
      "#{userId}," +
      "1" +
      ")"
    )
    void insertClassState(
        @Param("classId") int classId,
        @Param("userId") String userId
    );
 // =========================================================================
 // --- 결제내역 조회 추가 4월 24일---
 // =========================================================================
 @Select("SELECT * FROM pay WHERE user_id = #{userId} ORDER BY pay_no DESC LIMIT #{startrow}, #{limit}")
 List<Pay> selectPayList(@Param("userId") String userId,
                         @Param("startrow") int startrow,
                         @Param("limit") int limit);

 @Select("SELECT COUNT(*) FROM pay WHERE user_id = #{value}")
 int countPay(String userId);

}