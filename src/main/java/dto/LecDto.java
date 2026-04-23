package dto;

import lombok.Data;

@Data
public class LecDto {
	private int lec_id;
	private int lec_no;
	private int class_id; 
	private String lec_title;
	private String lec_time;
	private String lec_url;
	private String lec_content;
    private String cls_title; //cls table join
    private String user_name; //users table join
}
