package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminWithdrawMapper {

	@Delete("DELETE FROM users WHERE user_id = #{user_id}")
    void withdrawUser(@Param("user_id") String user_id);

	@Delete("<script>"
			+ "delete from users where user_id in "
			+ "<foreach item='id' collection='user_ids' open='(' separator=',' close=')'>"
			+ "#{id}"
			+ "</foreach>"
			+ "</script>")
	void withdrawMultiUsers(@Param("user_ids") List<String> user_ids);
}
