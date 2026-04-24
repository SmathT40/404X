package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.User;

@Mapper
public interface UserMypageMapper {

	@Select("select * from users where user_id = #{user_id}")
	User getUserInfo(String user_id);

	@Update("update users set user_name = #{user_name}, "
			+ "user_phone = #{user_phone}, user_email = #{user_email}"
			+ "where user_id = #{user_id}")
	void updateUserInfo(User user);

	@Update("update users set user_pw = #{newPw} where user_id = #{user_id}")
	void updatePw(@Param("user_id") String user_id, @Param("newPw") String newPw);

}
