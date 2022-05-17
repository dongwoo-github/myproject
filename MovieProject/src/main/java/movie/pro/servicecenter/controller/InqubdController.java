package movie.pro.servicecenter.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.member.dto.MemberDto;
import movie.pro.service.service.InqubdServce;
import movie.pro.servicecenter.dto.InqubdDto;

@Controller
public class InqubdController {

	@Autowired
	InqubdServce service;
	
	@RequestMapping("/inqubd/list")
	public String list(@RequestParam(name="p",defaultValue="1") int page, Model m) {
		
		int count = service.countInqu();
		//글이 있는지 체크
			
		if(count>0) {
			int perPage = 10; // 한 페이지에서 보일 글의 갯수 고정값으로 가려면 final
			int startRow = (page-1) * perPage +1; 
			//로우넘은 1부터 시작하기때문! List를 통채로 사용할 경우는 0부터 시작하기 때문에 +1 안해도 됨!
			int endRow = page*perPage; 
			//마찬가지로 list를 통으로 가져워서 사용할 경우 -1해줘야함( 0부터 시작하기때문! )
			List<InqubdDto> inqubdList = service.inqubdList(startRow, endRow);			
			m.addAttribute("list",inqubdList);
			
			int pageNum = 5;
			int totalPages = count /perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수 
			//나머지가 있다면 한페이지 추가
			
			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum - 1;
			if(end > totalPages) {
				end = totalPages;
			}
			m.addAttribute("begin", begin);
			m.addAttribute("end",end);
			m.addAttribute("pageNum", pageNum);
			m.addAttribute("totalPages", totalPages);
		}
		m.addAttribute("nowPage",page);
		m.addAttribute("count", count);
		return "inqubd/inqubdList";
		
	}//list
	
	@GetMapping("inqubd/content/{inqubd_no}")
	public String contentForm(@RequestParam(name="p",defaultValue="1") int page,@ModelAttribute("user") MemberDto user,@PathVariable int inqubd_no, Model m) {
		
		InqubdDto dto = service.selectInqu(inqubd_no);
		m.addAttribute("dto", dto);
		int count = service.countInqu();
		//글이 있는지 체크
			
		if(count>0) {
			int perPage = 10; // 한 페이지에서 보일 글의 갯수 고정값으로 가려면 final
			int startRow = (page-1) * perPage +1; 
			//로우넘은 1부터 시작하기때문! List를 통채로 사용할 경우는 0부터 시작하기 때문에 +1 안해도 됨!
			int endRow = page*perPage; 
			//마찬가지로 list를 통으로 가져워서 사용할 경우 -1해줘야함( 0부터 시작하기때문! )
			List<InqubdDto> inqubdList = service.inqubdList(startRow, endRow);			
			m.addAttribute("list",inqubdList);
			
			int pageNum = 5;
			int totalPages = count /perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수 
			//나머지가 있다면 한페이지 추가
			
			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum - 1;
			if(end > totalPages) {
				end = totalPages;
			}
			m.addAttribute("begin", begin);
			m.addAttribute("end",end);
			m.addAttribute("pageNum", pageNum);
			m.addAttribute("totalPages", totalPages);
		}
		m.addAttribute("nowPage",page);
		m.addAttribute("count", count);
		
		return "inqubd/content";
	}//contentForm
	
	@GetMapping("inqubd/insert")
	public String insert(Model m) {
		
		List<CinemaDto> cineList = service.cinemaList();
		m.addAttribute("cineList",cineList);
		
		return "inqubd/write";
	}//insert
	
	@PostMapping("inqubd/insert")
	public String insertInqu(InqubdDto dto) {
		
		service.insertInqu(dto);
		return "redirect:/inqubd/list";
	}//insertInqu
	
	@GetMapping("inqubd/update/{inqubd_no}/{page}")
	public String updateForm(@PathVariable int page,@PathVariable int inqubd_no, Model m) {
		List<String> div = new ArrayList<String>();
		div.add("분실물");
		div.add("예매");
		div.add("기타");
		m.addAttribute("divi", div);
		List<CinemaDto> cineList = service.cinemaList();
		m.addAttribute("cineList",cineList);
		
		InqubdDto dto = service.selectInqu(inqubd_no);
		m.addAttribute("dto",dto);
		return "inqubd/updateForm";
	}//updateForm
	
	@PutMapping("/inqubd/update/{inqubd_no}/{page}")
	public String update(InqubdDto dto,@PathVariable int page) {
		service.updateInqu(dto);
		return "redirect:/inqubd/content/"+dto.getInqubd_no()+"?p="+page;
	}//update
	
	@PutMapping("/inqubd/comm")
	@ResponseBody
	public String comm(InqubdDto dto) {
		int i = service.updateComm(dto);
		return i+"";
	}//comm
	
	@PutMapping("/inqubd/delComm")
	@ResponseBody
	public String delComm(int inqubd_no) {
		int i = service.deleteComm(inqubd_no);
		return i+"";
	}//delComm
	
	@DeleteMapping("/inqubd/delete")
	@ResponseBody
	public String delete(int inqubd_no) {
		int i = service.deleteInqu(inqubd_no);
		return ""+i;
	}//delete
	
}
