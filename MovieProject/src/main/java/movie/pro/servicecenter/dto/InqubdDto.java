package movie.pro.servicecenter.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class InqubdDto {
	
	int inqubd_no;
	String inqubd_id;
	String inqubd_title;
	String inqubd_div;
	String inqubd_cinema;
	String inqubd_content;
	@DateTimeFormat(pattern = "yy/MM/dd")
	Date inqubd_regdate;
	String inqubd_comm;
	@DateTimeFormat(pattern = "yy/MM/dd")
	Date inqubd_comm_reg;
	String inqubd_a;

}
