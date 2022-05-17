package movie.pro.mypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.TheaterDto;
import movie.pro.mypage.dto.MyticketDto;
import movie.pro.mypage.service.MyticketService;
import movie.pro.security.SecurityUser;




@Controller
public class MyticketController {

	@Autowired
	MyticketService service;
	
	@GetMapping("/mytkList")
	public String mytkList(@AuthenticationPrincipal SecurityUser user , MyticketDto dto, Model m) {		 
		String id = user.getDto().getMem_id();
		List<MyticketDto> list = service.mytkList(id);
		m.addAttribute("list", list);
		m.addAttribute("dto", dto);
		m.addAttribute("tk_id", id);
		return "mypage/ticketList";
	}
	
}