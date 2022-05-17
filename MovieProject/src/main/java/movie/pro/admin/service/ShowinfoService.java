package movie.pro.admin.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.admin.dao.ShowinfoDao;
import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.ShowinfoDto;
import movie.pro.admin.dto.TheaterDto;

@Service
public class ShowinfoService {
	
	@Autowired
	ShowinfoDao dao;
	
	public int insertShowinfo(ShowinfoDto dto) {
		return dao.insertShowinfo(dto);
	}//insertShowinfo
	
	public int updateShowinfo(ShowinfoDto dto) {
		return dao.updateShowinfo(dto);
	}//updateShowinfo
	
	public int deleteShowinfo(long show_no) {
		return dao.deleteShowinfo(show_no);
	}//deleteShowinfo
	
	public ShowinfoDto showinfoOne(long show_no) {
		return dao.showinfoOne(show_no);
	}//showinfoOne
	
	public List<CinemaDto> cineList(String cine_area){
		return dao.cineList(cine_area);
	}//cineList
	
	public List<TheaterDto> thList(int cine_no){
		return dao.thList(cine_no);
	}//thList
	
}
