package movie.pro.movbd.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.movbd.dto.BoardDto;


@Mapper
public interface BoardDao {
	int insert(BoardDto dto);
	List<BoardDto> boardList(Map<String, Object> m);
	int count();//전체 글 갯수
	BoardDto boardOne(int movbd_no);
	int updateBoard(BoardDto dto);
	int deleteBoard(int movbd_no);
	int readcnt(int movbd_no);
	List<BoardDto> boardListSearch(Map<String, Object> m);
	int countSearch(Map<String, Object> m);//검색 글 갯수
	List<String> movList(String tk_id);
	int likecnt(int movbd_no);
}