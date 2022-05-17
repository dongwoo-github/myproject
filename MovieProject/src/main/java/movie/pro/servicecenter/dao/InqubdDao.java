package movie.pro.servicecenter.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.servicecenter.dto.InqubdDto;

@Mapper
public interface InqubdDao {

	int insertInqu(InqubdDto dto);
	int updateInqu(InqubdDto dto);
	int deleteInqu(int inqubd_no);
	int countInqu();
	int updateComm(InqubdDto dto);
	int deleteComm(int inqubd_no);
	InqubdDto selectInqu(int inqubd_no);
	List<InqubdDto> inqubdList(Map<String, Object> m);
	List<CinemaDto> cinemaList();
	
}
