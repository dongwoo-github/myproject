package movie.pro.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import movie.pro.member.dto.MemberDto;

public class SecurityUser extends User {

	private static final long serialVersionUID = 1L;
	private MemberDto dto;
	
	public SecurityUser(MemberDto dto) {
		super(dto.getMem_id(),dto.getMem_pw(),AuthorityUtils.createAuthorityList(dto.getMem_role()));
		this.dto = dto;
	}
	
	public MemberDto getDto() {
		return dto;
	}
	
}
