package mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.User;

public interface UserMapper {
	@Select("select count(*) from users where user_id = #{user_id}")
	int checkId(String user_id);
	
	@Insert("insert into users (user_id, user_pw, user_name, user_phone, "
			+ "user_birth, user_email, user_role, user_join_date)"
			+ "values (#{user_id}, #{user_pw}, #{user_name}, #{user_phone}, "
			+ "#{user_birth}, #{user_email}, 0, NOW())")
	void insertUser(User user);
}
