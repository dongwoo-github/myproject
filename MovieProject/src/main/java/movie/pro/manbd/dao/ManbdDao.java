package movie.pro.manbd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.manbd.dto.ManbdDto;

@Mapper
public interface ManbdDao {
	int insert(ManbdDto dto);
	List<ManbdDto> boardList(Map<String, Object> m);
	List<ManbdDto> noticeList(Map<String, Object> m);
	List<ManbdDto> eventList(Map<String, Object> m);
	
	int count();//전체 글 갯수
	ManbdDto boardOne(int no);
	int updateBoard(ManbdDto dto);
	int deleteBoard(int no);
	List<ManbdDto> boardListSearch(Map<String, Object> m);
	int countSearch(Map<String, Object> m);//검색 글 갯수	
	
	
}
