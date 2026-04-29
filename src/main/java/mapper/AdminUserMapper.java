package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.User;

@Mapper
public interface AdminUserMapper {

	@Select("<script>"
			+ "select count(*) from users "
			+ "<if test='keyword != null and keyword != \"\"'> "
			+ "where user_name like concat('%', #{keyword}, '%') "
			+ "</if>"
			+ "</script>")
	int getUserCount(@Param("keyword") String keyword);

	@Select("<script>"
			+ "select "
			+ "u.user_id, "
			+ "u.user_name, "
			+ "u.user_email, "
			+ "u.user_join_date, "
			+ "u.user_role, "
			+ "(select count(*) from cls_state c where c.user_id = u.user_id) as class_count "
			+ "from users u "
			+ "<if test='keyword != null and keyword != \"\"'> "
			+ "where u.user_name like concat('%', #{keyword}, '%') "
			+ "</if> "
			+ "order by u.user_join_date desc "
			+ "limit #{pageSize} offset #{offset} "
			+ "</script>")
	List<User> getUserList(@Param("keyword") String keyword, 
						   @Param("offset") int offset, 
						   @Param("pageSize") int pageSize);

}
