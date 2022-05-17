package movie.pro.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.ShowinfoDto;
import movie.pro.admin.dto.TheaterDto;

@Mapper
public interface ShowinfoDao {
	
	int insertShowinfo(ShowinfoDto dto);
	int updateShowinfo(ShowinfoDto dto);
	int deleteShowinfo(long show_no);
	List<CinemaDto> cineList(String cine_area);
	List<TheaterDto> thList(int cine_no);
	ShowinfoDto showinfoOne(long show_no);
	
}
