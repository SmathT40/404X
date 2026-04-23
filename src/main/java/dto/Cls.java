package dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Cls {
	private int classId;
	private String userId;
	private int categoryCode;
	private String clsTitle;
	private String clsContent;
	private String clsThumbnail;
	private int clsStatus;
	private int clsExp;
	private int clsPrice;
	private String clsRegDate;
}
