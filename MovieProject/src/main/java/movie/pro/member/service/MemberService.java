package movie.pro.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import movie.pro.member.dao.MemberDao;
import movie.pro.member.dto.MemberDto;

@Service
public class MemberService {
	
	@Autowired
	MemberDao dao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	public int insertMember(MemberDto dto) {
		
		dto.setMem_pw(encoder.encode(dto.getMem_pw()));
		
		int i = dao.insertMember(dto);
		
		return i;
		
	}//insertMember
	
	public MemberDto findById(String mem_id) {
			return dao.findById(mem_id);
	}//finById
	
	public List<String> idList(String mem_name,String mem_email) {
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("name", mem_name);
		m.put("mail", mem_email);
		
		return dao.idList(m);
		
	}//idList
	
	public int findId(String mem_name,String mem_email) {
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("name", mem_name);
		m.put("mail", mem_email);
		
		return dao.findId(m);
		
	}//findId
	
	public int findPw(String mem_name,String mem_email,String mem_id) {
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("name", mem_name);
		m.put("mail", mem_email);
		m.put("id", mem_id);
		
		return dao.findPw(m);
		
	}//findPw
	
	public int updatePw(String mem_name,String mem_email,String mem_id,String mem_pw) {
		
		String pw = encoder.encode(mem_pw);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("name", mem_name);
		m.put("mail", mem_email);
		m.put("id", mem_id);
		m.put("pw",pw);
		
		return dao.updatePw(m);
		
	}//findPw
	
	
	public int updateMember(MemberDto dto) {
		dto.setMem_pw(encoder.encode(dto.getMem_pw()));	
		return dao.updateMember(dto);
	}
	
	public int deleteMember(String mem_pw, MemberDto dto ) {
		String pw = encoder.encode(mem_pw);
		
		if(pw.equals(mem_pw)) {
			return dao.deleteMember(dto.getMem_id());
		}else {
			return 0;
		}
	}
	
	
}
