package movie.pro.ticket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.ticket.dto.JoinShowinfoDto;
import movie.pro.ticket.dto.JoinTicketDto;
import movie.pro.ticket.dto.TicketDto;

@Mapper
public interface TicketDao {
	
	int insertTicket(TicketDto dto);
	int deleteTicket(long tk_no);
	int updateSeat(TicketDto dto);
	int deleteSeat(TicketDto dto);
	JoinTicketDto selectTkinfo(long tk_no);
	List<String> selectSeat(long show_no);
	JoinShowinfoDto selectShowinfo(long show_no);
	List<JoinShowinfoDto> showinfoCineList(Map<String, Object> m);
	List<JoinShowinfoDto> showinfoMovList(Map<String, Object> m);
	
}
