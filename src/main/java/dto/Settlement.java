package dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Settlement {
	private int settle_id;
	private String user_id;
	private int pay_amount;
	private String settle_content;
	private Date settle_date;
	private String target_id;
}
