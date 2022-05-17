package movie.pro.mypage.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MyinqubdDto {
	
	 int inqubd_no;
	String inqubd_title;
	String inqubd_div;
	String inqubd_cinema;
	String inqubd_content;
	@DateTimeFormat(pattern = "yy/MM/dd")
	Date inqubd_regdate;
	String inqubd_comm;
	String inqubd_id;
	@DateTimeFormat(pattern = "yy/MM/dd")
	Date inqubd_comm_regdate;
	String inqubd_a;
	
}
