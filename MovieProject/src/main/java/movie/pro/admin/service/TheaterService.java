package movie.pro.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.admin.dao.TheaterDao;
import movie.pro.admin.dto.TheaterDto;

@Service
public class TheaterService {
	
	@Autowired
	TheaterDao dao;
	
	public int insertTheater(TheaterDto dto) {
		return dao.insertTheater(dto);
	}//insertTheater
	
	public int updateTheater(TheaterDto dto) {
		return dao.updateTheater(dto);
	}//updateTheater
	
	public int deleteTheater(int cine_no,int th_no) {
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("cine_no", cine_no);
		m.put("th_no", th_no);
		
		return dao.deleteTheater(m);
	}//deleterTheater
	
	public TheaterDto thOne(int cine_no,int th_no) {
		
		Map<String,Object> m = new HashMap<String, Object>();
		m.put("cine_no", cine_no);
		m.put("th_no", th_no);
		
		return dao.thOne(m);
	}
	
}
