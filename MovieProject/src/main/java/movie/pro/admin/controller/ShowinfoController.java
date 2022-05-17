package movie.pro.admin.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.ShowinfoDto;
import movie.pro.admin.dto.TheaterDto;
import movie.pro.admin.service.ShowinfoService;

@Controller
public class ShowinfoController {
	
	@Autowired
	ShowinfoService service;

	@GetMapping("admin/showinfo/insertShowinfo")
	public String insertForm() {
		return "admin/showinfo/insertShowinfo";
	}//insertForm
	
	@PostMapping("admin/showinfo/insertShowinfo")
	public String insertShowinfo(ShowinfoDto dto) {
		
		service.insertShowinfo(dto);
		
		return "redirect:/ticket/showinfoMovList";
	}//insertShowinfo
	
	@GetMapping("admin/showinfo/updateShowinfo")
	public String updateForm(long show_no,Model m) {
		ShowinfoDto dto = service.showinfoOne(show_no);
		m.addAttribute("dto", dto);
		
		return "admin/showinfo/updateShowinfo";
	}//updateForm
	
	@PutMapping("admin/showinfo/updateShowinfo")
	public String updateShowinfo(ShowinfoDto dto) {
		service.updateShowinfo(dto);
		return "redirect:/ticket/showinfoMovList";
	}//updateShowinfo
	
	@GetMapping("admin/showinfo/deleteShowinfo")
	@ResponseBody
	public String deleteShowinfo(long show_no) {
		int i = service.deleteShowinfo(show_no);
		return ""+i;
	}//deleteShowinfo
	
	@GetMapping("showinfo/cineList")
	@ResponseBody
	public List<CinemaDto> cineList(String cine_area){
		
		List<CinemaDto> dto = service.cineList(cine_area);
		
		return dto;
	}//cineList
	
	@GetMapping("showinfo/thList")
	@ResponseBody
	public List<TheaterDto> thList(int cine_no){
		
		List<TheaterDto> dto = service.thList(cine_no);
		
		return dto;
	}//thList
	
}
