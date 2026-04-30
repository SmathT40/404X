package mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.User;

@Mapper
public interface InstructorMypageMapper {

	@Select("select * from users where user_id = #{user_id}")
	User getInstructorInfo(String user_id);

	// 강사 정보 수정
	@Update("update users set "
			+ "user_name = #{user_name}, "
			+ "user_phone = #{user_phone}, "
			+ "user_email = #{user_email}, "
			+ "host_intro = #{host_intro}, "
			+ "host_bank_name = #{host_bank_name}, "
			+ "host_bank_account = #{host_bank_account}, "
			+ "host_account_owner = #{host_account_owner} "
			+ "where user_id = #{user_id}")
	void updateInstructorInfo(User user);

	// 신규 강사 등록
	@Update("update users set "
			+ "user_name = #{user_name}, "
			+ "user_phone = #{user_phone}, "
			+ "user_email = #{user_email}, "
			+ "host_intro = #{host_intro}, "
			+ "host_bank_name = #{host_bank_name}, "
			+ "host_bank_account = #{host_bank_account}, "
			+ "host_account_owner = #{host_account_owner}, "
			+ "host_status = #{host_status} " // 여기서 1 추가
			+ "where user_id = #{user_id}")
	void registerInstructor(User user);

}
