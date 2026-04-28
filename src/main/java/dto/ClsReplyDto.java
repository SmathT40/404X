package dto;

import java.util.List;

import lombok.Data;

@Data
public class ClsReplyDto {
    private int cls_reply_no;
    private String user_id;
    private String user_name; // JOIN으로 가져올 이름
    private int class_id;
    private Integer lec_id;   // NULL 허용을 위해 Integer
    private String cls_reply_content;
    private int cls_reply_private;
    private String cls_reply_reg_date;
    private Integer cls_parent_id; // NULL 허용을 위해 Integer
    private Integer board_no;
    private String board_title;
    private int board_type;
    
    private List<ClsReplyDto> replyList;
    
}