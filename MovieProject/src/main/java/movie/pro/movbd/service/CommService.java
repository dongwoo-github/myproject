package movie.pro.movbd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.movbd.dao.CommDao;
import movie.pro.movbd.dto.CommDto;

@Service
public class CommService {
	@Autowired
	CommDao dao;
	
	public List<CommDto> selectComm(int movbd_no){
		return dao.selectComm(movbd_no);
	}
	public int insertComm(CommDto dto) {
		return dao.insertComm(dto);
	}
	public int deleteComm(int comm_no) {
		return dao.deleteComm(comm_no);
	}
}

