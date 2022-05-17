package movie.pro.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.TheaterDto;

@Mapper
public interface CinemaDao {
	
	int insertCinema(CinemaDto dto);
	int updateCinema(CinemaDto dto);
	int deleteCinema(int cine_no);
	List<CinemaDto> cineList();
	List<TheaterDto> thList();
	CinemaDto cineOne(int cine_no);
	
}
