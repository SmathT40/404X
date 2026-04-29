package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.Pay;

public interface PaymentMapper {
	
	//hto 0429
	@Insert("INSERT INTO pay (order_id, pay_uid, pay_amount, pay_method, user_id, pay_status, pay_goods) " +
	        "VALUES (#{order_id}, #{pay_uid}, #{pay_amount}, #{pay_method}, #{user_id}, #{pay_status}, #{pay_goods})")
	@Options(useGeneratedKeys = true, keyProperty = "pay_no")
	void insertPay(Pay pay);

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
 
 //hto 0429
 @Insert("INSERT INTO pay_detail (pay_no, class_id, detail_price) " +
	        "VALUES (#{pay_no}, #{class_id}, #{detail_price})")
 void insertPayDetail(@Param("pay_no") int pay_no, 
	                     @Param("class_id") int class_id, 
	                     @Param("detail_price") int detail_price);

}