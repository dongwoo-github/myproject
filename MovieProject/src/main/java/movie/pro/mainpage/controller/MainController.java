package movie.pro.mainpage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/mainpage")
	public String main() {
		return "/mainpage/mainpage";
	}//main
	
	@GetMapping("/login")
	public String loginForm() {
		return "login/login";
	}//loginFrom
	
	@GetMapping("/joinForm")
	public String joinFrom() {
		return"/join/joinForm";
	}//joinForm

	@GetMapping("header")
	public String header() {
		return "menu/header";
	}//header
	
	@GetMapping("footer")
	public String footer() {
		return "menu/footer";
	}//footer
	
}
