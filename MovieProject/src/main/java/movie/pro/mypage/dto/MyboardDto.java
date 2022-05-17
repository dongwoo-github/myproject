package movie.pro.mypage.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MyboardDto {

	 private int movbd_no;
	 private String movbd_mov;
	 private String movbd_id;	 
	 private String movbd_title;
	 private String movbd_content;
	 private Date movbd_regdate;
	 private int movbd_readcnt;	
	 private int movbd_recommend;
	 
}
