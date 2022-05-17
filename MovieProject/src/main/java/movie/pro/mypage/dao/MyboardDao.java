package movie.pro.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.mypage.dto.MyboardDto;
import movie.pro.mypage.dto.MycommDto;
import movie.pro.mypage.dto.MyinqubdDto;

@Mapper
public interface MyboardDao {
	
	List<MyboardDto> myboardList(String movbd_id);//내글목록
	
	int count();//전체 글 갯수
	
	List<MyinqubdDto> myinquList(String inqubd_id);
	
	List<MycommDto> mycommList(String comm_id);

}
