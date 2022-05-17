package movie.pro.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.dto.TheaterDto;
import movie.pro.admin.service.CinemaService;

@Controller
public class CinemaController {

	@Autowired
	CinemaService service;
	
	@GetMapping("/admin/cinema/insertCinema")
	public String insertForm() {
		return "admin/cinema/insertCinema";
	}//insertForm
	
	@PostMapping("/admin/cinema/insertCinema")
	public String insertCinema(CinemaDto cine_dto,Model m) {
		service.insertCinema(cine_dto);
		return "redirect:/admin/cinema/cineList";
	}//insertCinema
	
	@GetMapping("admin/cinema/updateCinema/{cine_no}")
	public String updateForm(@PathVariable int cine_no,Model m) {
		
		CinemaDto dto = service.cineOne(cine_no);
		m.addAttribute("dto", dto);
		return "admin/cinema/updateCinema";
	
	}//updateForm
	
	@PutMapping("admin/cinema/updateCinema/{cine_no}")
	public String updateCinema(CinemaDto dto) {
		
		service.updateCinema(dto);
		
		return "redirect:/admin/cinema/cineList";
	}//updateCinema
	
	@DeleteMapping("admin/cinema/deleteCinema")
	@ResponseBody
	public String deleteCinema(int cine_no) {
		int i = service.deleteCinema(cine_no);
		return i+"";
	}//deleteCinema
	
	@GetMapping("admin/cinema/cineList")
	public String cineList(@RequestParam(name="cineArea",defaultValue="서울") String cineArea,Model m) {
		
		List<TheaterDto> th_dto = service.thList();
		List<CinemaDto> dto = service.cineList();
		m.addAttribute("cineArea",cineArea);
		m.addAttribute("dto",dto);
		m.addAttribute("th_dto",th_dto);
		
		return "admin/cinema/cineList";
	}//cineList
	
}