package dto;

import java.util.Date;

import lombok.Data;

@Data
public class ClassDto {
    private int class_id;
    private String user_id;
    private int category_code;
    private String cls_title;
    private String cls_thumbnail;
    private Date cls_reg_date;
    private String user_name; // JOIN을 통해 가져올 강사명
    private int cls_no;
    private int cls_featured;
    private int cls_price;
    private String cls_content;
}
