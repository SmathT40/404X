package dto;

import lombok.Data;

@Data
public class myClassDto {
    private int cls_state_status;   // 수강 상태 (1:수강중, 2:완강)
    private String cls_statereg_date;
    private int class_id;
    private String cls_title;
    private String user_id;
    private String user_name;
    private int cls_exp;
    private String cls_end_date;
}
