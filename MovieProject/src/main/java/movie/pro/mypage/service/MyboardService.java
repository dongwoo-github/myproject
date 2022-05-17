package movie.pro.mypage.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import movie.pro.mypage.dao.MyboardDao;
import movie.pro.mypage.dto.MyboardDto;
import movie.pro.mypage.dto.MycommDto;
import movie.pro.mypage.dto.MyinqubdDto;

@Service
public class MyboardService {

	@Autowired
	MyboardDao dao;
	
	public int count() {
		return dao.count();
	}//countmyBoard
	
	
	public List<MyboardDto> myboardList(String movbd_id/* int start,int end*/) {
		return dao.myboardList(movbd_id);
	}//myboardList
	
	public List<MyinqubdDto> myinquList(String inqubd_id){
		return dao.myinquList(inqubd_id);
	}//myinquList
	
	public List<MycommDto> mycommList(String comm_id){
		return dao.mycommList(comm_id);
	}//mycommDto
	
}
