package movie.pro.ticket.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class JoinShowinfoDto {

	private long show_no;
	private int cine_no;
	private int mov_no;
	private int th_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date show_date;
	private int show_h;
	private int show_m;
	private int th_col;
	private int th_row;
	private int th_extra;
	private String mov_title;
	private String cine_name;
	private String cine_area;
	
}
