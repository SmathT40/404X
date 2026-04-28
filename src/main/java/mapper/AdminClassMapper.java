package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.ClassDto;

@Mapper
public interface AdminClassMapper {
	@Select("""
		    <script>
		        SELECT 
		            c.*, 
		            u.user_name
		        FROM cls c
		        JOIN users u ON c.user_id = u.user_id
		        <where>
		            <if test="clsStatus != null">
		                AND c.cls_status = #{clsStatus}
		            </if>
		            <if test="searchContent != null and searchContent != ''">
		                <choose>
		                    <when test="searchType == 'title'">
		                        AND c.cls_title LIKE CONCAT('%', #{searchContent}, '%')
		                    </when>
		                    <when test="searchType == 'instructor'">
		                        AND u.user_name LIKE CONCAT('%', #{searchContent}, '%')
		                    </when>
		                </choose>
		            </if>
		        </where>
		        ORDER BY c.cls_reg_date DESC
		    </script>
		    """)
	List<ClassDto> getClassList(@Param("searchType") String searchType,@Param("searchContent") String searchContent,@Param("clsStatus") Integer clsStatus);

	@Update("""
		    <script>
		        UPDATE cls 
		        SET cls_status = #{status} 
		        WHERE class_id IN 
		        <foreach collection="idList" item="id" open="(" separator="," close=")">
		            #{id}
		        </foreach>
		        AND cls_status != #{status}
		    </script>
		""")
	void updateStatuses(@Param("idList") List<String> idList, @Param("status") int status);
	
	@Select("SELECT c.*, u.user_name FROM cls c JOIN users u ON c.user_id = u.user_id WHERE c.cls_status = 0 ORDER BY c.cls_reg_date DESC LIMIT 5")
	List<ClassDto> selectPendingClassList();
}
