package movie.pro.service.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.servicecenter.dao.QnabdDao;
import movie.pro.servicecenter.dto.QnabdDto;

@Service
public class QnabdService {

	@Autowired
	QnabdDao dao;
	
	public int insertQna(QnabdDto dto) {
		return dao.insertQna(dto);
	}
	
	public int updateQna(QnabdDto dto) {
		return dao.updateQna(dto);
	}
	
	public int deleteQna(int no) {
		return dao.deleteQna(no);
	}
	
	public int count() {
		return dao.count();
	}
	
	public QnabdDto selectOne(int qnabd_no) {
		return dao.selectOne(qnabd_no);
	}
	
	public List<QnabdDto> qnaboardList(int start,int end){
		
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("start", start);
		m.put("end", end);
		
		return dao.qnaboardList(m);
	}
	
}
