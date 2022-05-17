package movie.pro.admin.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ShowinfoDto {

	long show_no;
	int cine_no;
	int mov_no;
	int th_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date show_date;
	int show_h;
	int show_m;
	int th_col;
	int th_row;
	int th_extra;
	String mov_title;
	
}
