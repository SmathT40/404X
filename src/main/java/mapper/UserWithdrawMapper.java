package mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserWithdrawMapper {

	@Delete("delete from users where user_id = #{user_id} and user_pw = #{user_pw}")
	int withdrawUser(@Param("user_id") String user_id, @Param("user_pw") String user_pw);

	
}
