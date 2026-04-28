package mapper;

import org.apache.ibatis.annotations.Update;

import dto.LecProgDto;

public interface LecProgMapper {
	
	@Update("INSERT INTO lec_progress (lec_id, user_id, stay_time, lec_prog_status) " +
	        "VALUES (#{lec_id}, #{user_id}, #{stay_time}, 0) " +
	        "ON DUPLICATE KEY UPDATE " +
	        "stay_time = stay_time + VALUES(stay_time), " +
	        "lec_prog_status = CASE " +
	        "    WHEN stay_time >= #{goal_time} THEN 1 " +
	        "    ELSE lec_prog_status " +
	        "END")
	void upsertProg(LecProgDto dto);
}
