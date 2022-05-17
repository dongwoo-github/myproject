package movie.pro.ticket.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.ticket.dao.TicketDao;
import movie.pro.ticket.dto.JoinShowinfoDto;
import movie.pro.ticket.dto.JoinTicketDto;
import movie.pro.ticket.dto.TicketDto;

@Service
public class TicketService {
	
	@Autowired
	TicketDao dao;
	
	public int insertTicket(TicketDto dto) {
		return dao.insertTicket(dto);
	}//insertTicket
	
	public int deleteTicket(long tk_no) {
		return dao.deleteTicket(tk_no);
	}//deleteTicket
	
	public int updateSeat(TicketDto dto) {
		return dao.updateSeat(dto);
	}//updateSeat
	
	public int deleteSeat(TicketDto dto) {
		return dao.deleteSeat(dto);
	}//deleteSeat
	
	public JoinTicketDto selectTkinfo(long tk_no) {
		return dao.selectTkinfo(tk_no);
	}//selectTkinfo
	
	public List<String> selectSeat(long show_no){
		return dao.selectSeat(show_no);
	}//selectSeat
	
	public JoinShowinfoDto selectShowinfo(long show_no){
		return dao.selectShowinfo(show_no);
	}//selectShowinfo
	public List<JoinShowinfoDto> showinfoCineList(String show_date,int cine_no){
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("show_date",show_date);
		m.put("cine_no", cine_no);
		return dao.showinfoCineList(m);
	}//showinfoCineList
	
	public List<JoinShowinfoDto> showinfoMovList(int mov_no,String show_date,String cine_area){
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("mov_no", mov_no);
		m.put("show_date",show_date);
		m.put("cine_area", cine_area);
		return dao.showinfoMovList(m);
	}//showinfoCineList

}
