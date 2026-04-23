package dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Instructor {
	private String userId;
	private String userName;
	private String hostIntro;
	private String hostDescription;
	private String hostProfileImg;
	
	private List<Cls> classList;
}
