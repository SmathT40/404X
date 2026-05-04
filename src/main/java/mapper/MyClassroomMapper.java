package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.myClassDto;

@Mapper
public interface MyClassroomMapper {

	@Select("""
		    SELECT 
		        s.cls_state_status,
		        s.cls_statereg_date,
		        c.class_id,
		        c.cls_title,
		        c.user_id,
		        u.user_name,       
		        c.cls_exp,
		        (SELECT COUNT(*) FROM lec WHERE class_id = c.class_id) AS total_cnt,
		        (SELECT COUNT(*) 
		         FROM lec_progress lp 
		         JOIN lec l ON lp.lec_id = l.lec_id 
		         WHERE l.class_id = c.class_id 
		           AND lp.user_id = s.user_id 
		           AND lp.lec_prog_status = 1) AS complete_cnt
		    FROM 
		        cls_state s
		    JOIN 
		        cls c ON s.classno = c.class_id
		    JOIN 
		        users u ON c.user_id = u.user_id
		    WHERE 
		        s.user_id = #{user_id} 
		        AND s.cls_state_status IN (0, 1)
		    """)
	List<myClassDto> selectMyClass(String user_id);
	
	@Select("""
		    SELECT 
		        s.cls_state_status, 
		        s.cls_statereg_date, 
		        s.classno AS class_id,
		        c.cls_exp
		    FROM cls_state s
		    JOIN cls c ON s.classno = c.class_id
		    WHERE s.user_id = #{user_id} AND s.classno = #{class_id}
		""")
	myClassDto selectEnrollmentCheck(@Param("user_id") String user_id, @Param("class_id") int class_id);

	@Select("""
		    SELECT 
		        s.cls_state_status, 
		        s.cls_statereg_date, 
		        s.classno AS class_id,
		        c.cls_exp
		    FROM cls_state s
		    JOIN cls c ON s.classno = c.class_id
		    WHERE s.user_id = #{user_id}
		""")
	List<myClassDto> selectAllEnroll(String user_id);

}
