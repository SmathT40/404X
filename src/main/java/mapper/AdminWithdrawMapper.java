package mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminWithdrawMapper {

	@Delete("DELETE FROM users WHERE user_id = #{user_id}")
    void withdrawUser(@Param("user_id") String user_id);
}
