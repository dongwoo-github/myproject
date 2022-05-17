package movie.pro.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import movie.pro.member.dto.MemberDto;

@Mapper
public interface MemberDao {
	
	MemberDto findById(String mem_id);
	
	int insertMember(MemberDto dto);
	
	int findId(Map<String, Object> m);
	
	int findPw(Map<String,Object> m);
	
	int updatePw(Map<String,Object> m);
	
	List<String> idList(Map<String,Object> m);

	int updateMember (MemberDto dto);
	
	int deleteMember(String mem_id);
	
	
}
