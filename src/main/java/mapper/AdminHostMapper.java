package mapper;

import java.util.List;
import org.apache.ibatis.annotations.*;
import dto.User;

@Mapper
public interface AdminHostMapper {
	
    @Select("""
        <script>
        SELECT * FROM users
        <where>
            <if test="user_role != null">
                AND user_role = #{user_role}
            </if>
            <if test="host_status != null">
                AND host_status = #{host_status}
            </if>
            <if test="keyword != null and keyword != ''">
                AND user_name LIKE CONCAT('%', #{keyword}, '%')
            </if>
        </where>
        ORDER BY user_join_date DESC
        </script>
    """)
    List<User> selectHostList(@Param("keyword") String keyword,
    		@Param("user_role") Integer user_role, 
    		@Param("host_status") Integer host_status
    );

    @Update("UPDATE users SET user_role = #{user_role} WHERE user_id = #{user_id}")
    int updateUserRole(@Param("user_id") String user_id, @Param("user_role") int user_role);

    @Update("UPDATE users SET host_status = #{host_status} WHERE user_id = #{user_id}")
    int updateHostStatus(@Param("user_id") String user_id, @Param("host_status") int host_status);

    @Update("UPDATE users SET user_role = 1, host_status = 2 WHERE user_id = #{user_id}")
    int approveHostRequest(String user_id);
}