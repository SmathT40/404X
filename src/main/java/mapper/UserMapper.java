package mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.User;

public interface UserMapper {
	@Select("select count(*) from users where user_id = #{user_id}")
	int checkId(String user_id);
	
	@Insert("insert into users (user_id, user_pw, user_name, user_phone, "
			+ "user_birth, user_email, user_role, user_join_date)"
			+ "values (#{user_id}, #{user_pw}, #{user_name}, #{user_phone}, "
			+ "#{user_birth}, #{user_email}, 0, NOW())")
	void insertUser(User user);

	@Select("select * from users where user_id = #{user_id} and user_pw = #{user_pw}")
	User loginCheck(@Param("user_id") String user_id, @Param("user_pw") String user_pw);

	@Select("select user_id from users where user_name = #{user_name} and user_email = #{user_email}")
	String findId(@Param("user_name") String user_name, @Param("user_email") String user_email);

	@Select("select count(*) from users where user_id = #{user_id} "
			+ "and user_name = #{user_name} and user_email = #{user_email}")
	int checkUserExist(@Param("user_id") String user_id, @Param("user_name") String user_name, @Param("user_email") String user_email);

	@Update("update users set user_pw = #{tempPw} where user_id = #{user_id}")
	void updateTempPw(@Param("user_id") String user_id, @Param("tempPw") String tempPw);

	
}
