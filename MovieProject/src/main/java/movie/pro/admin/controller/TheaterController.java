package movie.pro.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.admin.dto.TheaterDto;
import movie.pro.admin.service.TheaterService;

@Controller
public class TheaterController {

	@Autowired
	TheaterService service;
	
	@GetMapping("admin/theater/insertTheater/{cine_no}")
	public String insertForm(@PathVariable int cine_no,Model m) {
		m.addAttribute("cine_no",cine_no);
		return "admin/theater/insertTheater";
	}//insertForm
	
	@PostMapping("admin/theater/insertTheater")
	public String insertTheater(TheaterDto dto) {
		
		service.insertTheater(dto);
		
		return "redirect:/admin/cinema/cineList";
	}//insertTheater
	
	@GetMapping("admin/theater/updateTheater/{cine_no}/{th_no}")
	public String updateForm(@PathVariable int cine_no,@PathVariable int th_no,Model m) {
		
		TheaterDto dto = service.thOne(cine_no, th_no);
		m.addAttribute("dto",dto);
		System.out.println(dto);
		
		return "admin/theater/updateTheater";
	}//updateForm
	
	@PutMapping("admin/theater/updateTheater")
	public String updateTheater(TheaterDto dto) {
		
		service.updateTheater(dto);
		
		return "redirect:/admin/cinema/cineList";
	}//updateTheater
	
	@DeleteMapping("admin/theater/deleteTheater")
	@ResponseBody
	public String deleteTheater(int cine_no,int th_no) {
	
		int i = service.deleteTheater(cine_no, th_no);
		
		return ""+i;
	}//deleteTheater
	
}
