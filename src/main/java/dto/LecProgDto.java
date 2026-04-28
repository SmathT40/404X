package dto;

import lombok.Data;

@Data
public class LecProgDto {
	private String user_id;
	private int lec_id;
	private int lec_prog_status;
    private int stay_time;
    private int goal_time;
}
