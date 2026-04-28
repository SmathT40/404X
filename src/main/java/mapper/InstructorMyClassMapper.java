package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import dto.ClassDto;

@Mapper
public interface InstructorMyClassMapper {

	@Select("select * from cls where user_id = #{user_id} order by cls_reg_date desc")
	List<ClassDto> getMyClassList(String user_id);

}
