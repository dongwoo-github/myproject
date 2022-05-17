package movie.pro.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.admin.dao.CinemaDao;
import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.TheaterDto;

@Service
public class CinemaService {
	
	@Autowired
	CinemaDao dao;
	
	public int insertCinema(CinemaDto dto) {
		return dao.insertCinema(dto);
	}//insertCinema
	
	public int updateCinema(CinemaDto dto) {
		return dao.updateCinema(dto);
	}//updateCinema
	
	public int deleteCinema(int cine_no) {
		return dao.deleteCinema(cine_no);
	}//deleteCinema
	
	public List<TheaterDto> thList(){
		return dao.thList();
	}//thList
	
	public List<CinemaDto> cineList(){
		return dao.cineList();
	}//cineList
	
	public CinemaDto cineOne(int cine_no) {
		return dao.cineOne(cine_no);
	}//cineOne
	
}
