package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.ClassDto;

public interface HostClassMapper {
	@Select("""
            <script>
                SELECT 
                    c.*, 
                    u.user_name
                FROM cls c
                JOIN users u ON c.user_id = u.user_id
                <where>
                    c.user_id = #{userId}
                    <if test="status != null">
                        AND c.cls_status = #{status}
                    </if>
                    <if test="searchContent != null and searchContent != ''">
                        AND c.cls_title LIKE CONCAT('%', #{searchContent}, '%')
                    </if>
                </where>
                ORDER BY c.cls_reg_date DESC
            </script>
            """)
    List<ClassDto> getClassList(
        @Param("searchContent") String searchContent,
        @Param("userId") String userId,
        @Param("status") Integer status
    );
}
