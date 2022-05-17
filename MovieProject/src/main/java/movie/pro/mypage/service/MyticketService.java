package movie.pro.mypage.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import movie.pro.mypage.dao.MyticketDao;
import movie.pro.mypage.dto.MyticketDto;
import movie.pro.ticket.dto.JoinTicketDto;



@Service
public class MyticketService {

	@Autowired
	MyticketDao dao;
	
	public List<MyticketDto> mytkList(String tk_id) {
		return dao.mytkList(tk_id);
	}//
	
	
}
