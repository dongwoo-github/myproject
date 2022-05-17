package movie.pro.movbd.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDto {
	private int movbd_no;
	private String movbd_id;
	private String movbd_title;
	private String movbd_mov;
	private String movbd_content; 
	private Date movbd_regdate;
	private int movbd_readcnt;
	private int movbd_up;
}
