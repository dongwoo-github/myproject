package movie.pro.manbd.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.manbd.dao.ManbdDao;
import movie.pro.manbd.dto.ManbdDto;

@Service
public class ManbdService {
	
	@Autowired
	ManbdDao dao;
	
	public int count() {
		return dao.count();
	}
	
	public List<ManbdDto> boardList(int start, int end){
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("end", end);
		return dao.boardList(m);
	}
	
	
public List<ManbdDto> noticeList(int start, int end){
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("end", end);
		return dao.noticeList(m);
	}

public List<ManbdDto> eventList(int start, int end){
	
	Map<String, Object> m = new HashMap<String, Object>();
	m.put("start", start);
	m.put("end", end);
	return dao.eventList(m);
}
	
	public int insert(ManbdDto dto) {
		return dao.insert(dto);
	}
	public ManbdDto boardOne(int no) {
		return dao.boardOne(no);
	}
	public int updateBoard(ManbdDto dto) {
		return dao.updateBoard(dto);
	}
	public int deleteBoard(int no) {
		return dao.deleteBoard(no);
	}
	
	public List<ManbdDto> boardListSearch(int searchn, String search,int start, int end){
		Map<String,Object> m = new HashMap<String, Object>();
		m.put("searchn",searchn);
		m.put("search", search);
		m.put("start", start);
		m.put("end", end);
		
		return dao.boardListSearch(m);
	}
	public int countSearch(int searchn, String search) {
		System.out.println(searchn+search);
		Map<String,Object> m = new HashMap<String, Object>();
		m.put("searchn",searchn);
		m.put("search", search);
		return dao.countSearch(m);
	}

	
}