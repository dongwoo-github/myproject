package movie.pro.ticket.dto;

import java.util.Date;

import lombok.Data;

@Data
public class TicketDto {

	private long tk_no;
	private long show_no;
	private int tk_pay;
	private Date pay_time;
	private String tk_id;
	private int tk_a;
	private int tk_c;
	private String tk_seat;
	
}
