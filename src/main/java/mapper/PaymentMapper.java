package mapper;

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

}