package dto;

import lombok.Data;

@Data
public class Pay {

    private int pay_no;

    private String pay_uid;

    private String pay_date;

    private int pay_amount;

    private String pay_method;

    private String user_id;

    private int pay_status;

    private String pay_goods;

}