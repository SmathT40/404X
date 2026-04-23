package dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Board {
    private int board_no;
    private String board_title;
    private String board_content;
    private int board_private;
    private MultipartFile board_file_path;  // 업로드용
    private String fileurl;                  // DB 저장용
    private String user_id;
    private String board_reg_date;
    private int board_cnt;
    private int board_type;
    private int board_status;



}