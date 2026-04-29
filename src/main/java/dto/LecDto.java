package dto;

import lombok.Data;

@Data
public class LecDto {
	private int lec_id;
	private int lec_no;
	private int class_id; 
	private String lec_title;
	private int lec_time; //hto 0428 int로 타입변경  
	private String lec_url;
	private String lec_content;
    private String cls_title; //cls table join
    private String user_name; //users table join
    private String lec_time_str; //hto 0428 화면입력용 string
    
    // hto 0428 추가
    public void setLec_time_str(String lec_time_str) {
        this.lec_time_str = lec_time_str;
        if (lec_time_str != null && lec_time_str.contains(":")) {
            String[] parts = lec_time_str.split(":");
            try {
                int min = Integer.parseInt(parts[0].trim());
                int sec = Integer.parseInt(parts[1].trim());
                this.lec_time = (min * 60) + sec;
            } catch (NumberFormatException e) {
                this.lec_time = 0;
            }
        }
    }
    public String getLec_time_str() {
        if (this.lec_time_str != null && !this.lec_time_str.isEmpty()) {
            return this.lec_time_str;
        }
        if (this.lec_time > 0) {
            int min = this.lec_time / 60;
            int sec = this.lec_time % 60;
            
            return String.format("%02d:%02d", min, sec);
        }
        return "00:00";
    }
}
