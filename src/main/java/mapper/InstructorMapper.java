package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import dto.Cls;
import dto.Instructor;

@Mapper
public interface InstructorMapper {

	@Select("SELECT " +
	        "user_id AS userId, " +
	        "user_name AS userName, " +
	        "host_intro AS hostIntro, " +
	        "host_description AS hostDescription, " +
	        "host_profile_img AS hostProfileImg " +
	        "FROM users WHERE user_role = 1")
	List<Instructor> getInstructorList();
	
	@Select("SELECT " +
	        "class_id AS classId, " +
	        "user_id AS userId, " +
	        "cls_title AS clsTitle, " +
	        "cls_thumbnail AS clsThumbnail " +
	        "FROM cls")
	List<Cls> getAllClasses();
}
