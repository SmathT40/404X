package dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	
	private Integer user_role;
	
	private String user_birth;
	private String user_email;
	
	private Date user_join_date;
	
	private String host_intro;
	private String host_description;
	private String host_bank_name;
	private String host_bank_account;
	private String host_account_owner;
	private String host_profile_img;
	
	// 추가, 회원관리에서 써먹을 거
	private int class_count;
	private String user_login_type;
}

