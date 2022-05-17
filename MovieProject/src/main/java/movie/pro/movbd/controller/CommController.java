package movie.pro.movbd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.movbd.dto.CommDto;
import movie.pro.movbd.service.CommService;


@Controller
public class CommController {
	@Autowired
	CommService service;
	
	@GetMapping("/comm/insert")
	@ResponseBody
	public String insertComm(CommDto dto) {
		int i = service.insertComm(dto);
		return i+"";
	}
	
	@GetMapping("/comm/delete/{comm_no}")
	@ResponseBody
	public String deleteComm(@PathVariable int comm_no) {
		int i = service.deleteComm(comm_no);
		return i+"";
	}
}