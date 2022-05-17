package movie.pro.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.mypage.dto.MyticketDto;
import movie.pro.ticket.dto.JoinShowinfoDto;
import movie.pro.ticket.dto.JoinTicketDto;
import movie.pro.ticket.dto.TicketDto;



@Mapper
public interface MyticketDao {
	
	//예약목록//
	List<MyticketDto> mytkList(String tk_id);
	
}
