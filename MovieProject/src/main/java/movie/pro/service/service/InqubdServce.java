package movie.pro.service.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.servicecenter.dao.InqubdDao;
import movie.pro.servicecenter.dto.InqubdDto;

@Service
public class InqubdServce {
	
	@Autowired
	InqubdDao dao;
	
	public int insertInqu(InqubdDto dto) {
		return dao.insertInqu(dto);
	}//insertInqu
	
	public int updateInqu(InqubdDto dto) {
		return dao.updateInqu(dto);
	}//updateInqu
	
	public int updateComm(InqubdDto dto) {
		return dao.updateComm(dto);
	}//updateComm
	
	public int deleteComm(int inqubd_no) {
		return dao.deleteComm(inqubd_no);
	}//deleteComm
	
	public int deleteInqu(int inqubd_no) {
		return dao.deleteInqu(inqubd_no);
	}//deleteInqu
	
	public int countInqu() {
		return dao.countInqu();
	}//countInqu
	
	public InqubdDto selectInqu(int inqubd_no) {
		return dao.selectInqu(inqubd_no);
	}//selectInqu
	
	public List<CinemaDto> cinemaList(){
		return dao.cinemaList();
	}//cinemaList
	
	public List<InqubdDto> inqubdList(int start,int end){
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("end", end);
		return dao.inqubdList(m);
	}//inqubdList
	
	
	
}
