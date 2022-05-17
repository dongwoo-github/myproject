package movie.pro.servicecenter.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.servicecenter.dto.QnabdDto;



@Mapper
public interface QnabdDao {

	
	int insertQna(QnabdDto dto);
	int updateQna(QnabdDto dto);
	int count();
	QnabdDto selectOne(int qnabd_no);
	List<QnabdDto> qnaboardList(Map<String, Object> m);
	int deleteQna(int no);
	
}
