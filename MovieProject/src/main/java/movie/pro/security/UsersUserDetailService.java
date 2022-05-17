package movie.pro.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import movie.pro.member.dao.MemberDao;
import movie.pro.member.dto.MemberDto;

@Service
public class UsersUserDetailService implements UserDetailsService {

	@Autowired
	MemberDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		
		MemberDto user = dao.findById(mem_id);
		
		if(user==null) {
			throw new UsernameNotFoundException(mem_id+"사용자 없음");
		}else {
			return new SecurityUser(user);
		}
		
	}

}
