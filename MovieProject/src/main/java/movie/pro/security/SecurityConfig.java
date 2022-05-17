package movie.pro.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	UsersUserDetailService usersUserDetailService;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.authorizeRequests().antMatchers("/admin/**").hasRole("ADMIN");
		http.authorizeRequests().antMatchers("/qnabd/insert","qnabd/udate/**").hasRole("ADMIN");
		http.authorizeRequests().antMatchers("/ticket/ticketing/**").hasRole("MEMBER");
		http.authorizeRequests().antMatchers("/mypage").hasRole("MEMBER");
		http.authorizeRequests().antMatchers("/updateMember").hasRole("MEMBER");
		http.authorizeRequests().antMatchers("/mytkList").hasRole("MEMBER");
		http.authorizeRequests().antMatchers("/myboardList").hasRole("MEMBER");
		http.authorizeRequests().antMatchers("/movbd/**").authenticated();
		http.authorizeRequests().antMatchers("/**").permitAll();
		http.csrf().disable();
		http.formLogin().loginPage("/login").defaultSuccessUrl("/mainpage");
		http.exceptionHandling();
		http.logout().invalidateHttpSession(true).deleteCookies().logoutSuccessUrl("/mainpage");
		
		http.userDetailsService(usersUserDetailService);
		
		http.headers().frameOptions().sameOrigin();
	}
	
	  @Bean public PasswordEncoder passwordEncoder() { 
		  return PasswordEncoderFactories.createDelegatingPasswordEncoder(); 
	  }
	 
}
