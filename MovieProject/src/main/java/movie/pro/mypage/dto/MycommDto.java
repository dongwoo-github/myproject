package movie.pro.mypage.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MycommDto {

	private int comm_no;
	private String comm_id;//작성자 아이디
	private String comm_content;
	private Date comm_regdate;
	
}
