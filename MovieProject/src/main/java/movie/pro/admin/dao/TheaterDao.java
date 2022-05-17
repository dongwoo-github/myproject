package movie.pro.admin.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.admin.dto.TheaterDto;

@Mapper
public interface TheaterDao {
	
	int insertTheater(TheaterDto dto);
	int updateTheater(TheaterDto dto);
	int deleteTheater(Map<String, Object> m);
	TheaterDto thOne(Map<String, Object> m);

}
