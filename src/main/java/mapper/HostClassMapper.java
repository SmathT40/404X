package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.ClassDto;
import dto.LecDto;

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
	
	@Insert("INSERT INTO cls (user_id, category_code, cls_title, cls_exp, cls_price, cls_thumbnail, cls_content) " +
	        "VALUES (#{user_id}, #{category_code}, #{cls_title}, #{cls_exp}, #{cls_price}, #{cls_thumbnail}, #{cls_content})")
	int insertClass(ClassDto dto);

	@Insert("INSERT INTO lec (lec_title,lec_time,lec_url,lec_no,lec_content,class_id) " +
			"VALUES (#{lec_title},#{lec_time},#{lec_url},#{lec_no},#{lec_content},#{class_id})")
	int insertLec(LecDto dto);

	@Update("""
		    UPDATE lec 
		    SET 
		        lec_no = #{lec_no},
		        lec_title = #{lec_title},
		        lec_url = #{lec_url},
		        lec_content = #{lec_content},
		        lec_time = #{lec_time}
		    WHERE 
		        lec_id = #{lec_id}
		""")
	void updateLec(LecDto dto);
}
