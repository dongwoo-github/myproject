package movie.pro.mypage.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyticketDto {
	
	 private long show_no; //상영번호
	
	 private long tk_no; //예매번호
	 private String tk_id; //결제 아이디
	 private int tk_a; // 성인수
	 private int tk_c; // 청소년 수
	 private String tk_seat; // 티켓자리
	 private int tk_pay; //결제금액
	 private Date tk_pay_time; //결제시간
	
	 private String mov_title;//영화제목
	 private String cine_name; //극장이름
	 private String cine_area; //극장지역
	 private int show_h;
	 private int show_m;
	 private int th_no;
	 private int mov_no;
	 private Date show_date;//상영시간


	 
}

