package movie.pro.member.dto;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberDto {
	
	@NotNull(message="id가 입력되지 않았습니다.")
	@NotEmpty(message="id가 입력되지 않았습니다.")
	@Size(min=4,max=13,message = "아이디를 4~13글자 사이로 입력해주세요")
	String mem_id;
	
	@NotNull(message="비밀번호가 입력되지 않았습니다.")
	@NotEmpty(message="비밀번호가 입력되지 않았습니다.")
	@Size(min=4,max=13,message = "비밀번호를 4~13글자 사이로 입력해주세요")
	String mem_pw;
	
	@NotNull(message="이름이 입력되지 않았습니다.")
	@NotEmpty(message="이름이 입력되지 않았습니다.")
	@Size(min=2,max=10,message = "이름을 2~10글자 사이로 입력해주세요")
	String mem_name;
	
	@NotNull(message="생년월일이 입력되지 않았습니다.")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date mem_birth;
	
	@NotNull(message="전화번호가 입력되지 않았습니다.")
	@NotEmpty(message="전화번호가 입력되지 않았습니다.")
	@Pattern(regexp = "^01(?:0|1|[6-9])[.-](\\d{3}|\\d{4})[.-](\\d{4})$", message = "전화번호 양식에 어긋납니다.")
	String mem_phone;
	
	@NotNull(message="주소가 입력되지 않았습니다.")
	@NotEmpty(message="주소가 입력되지 않았습니다.")
	String mem_address;
	
	@NotNull(message="이메일주소가 입력되지 않았습니다.")
	@NotEmpty(message="이메일주소가 입력되지 않았습니다.")
	@Email(message="이메일 양식을 맞춰주세요.")
	String mem_email;
	
	@DateTimeFormat(pattern = "yy/MM/dd")
	Date mem_regdate;
	String mem_role;
	Boolean mem_enabled;

}
