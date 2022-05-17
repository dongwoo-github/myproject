package movie.pro.movbd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.movbd.dto.CommDto;

@Mapper
public interface CommDao {
	List<CommDto> selectComm(int movbd_no);
	int insertComm(CommDto dto);
	int deleteComm(int comm_no);
}