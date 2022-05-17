package movie.pro.manbd.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ManbdDto {
	private int manbd_no;
	private String manbd_cinema;
	private String manbd_title;
	private String manbd_div;
	private String manbd_content;
	private Date manbd_regdate;
	
}
