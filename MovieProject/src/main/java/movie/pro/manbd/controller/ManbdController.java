package movie.pro.manbd.controller;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import movie.pro.admin.dto.CinemaDto;
import movie.pro.admin.service.CinemaService;
import movie.pro.manbd.dto.ManbdDto;
import movie.pro.manbd.service.ManbdService;


@SessionAttributes("user")
@Controller
public class ManbdController {

	@Autowired
	ManbdService service;
	
	@Autowired
	CinemaService c_service;
	
	@GetMapping("/manbd/write")
	public String writeForm(Model m) {
		//DB에서 cinema 정보 가져와 view
		List<CinemaDto> cList =  c_service.cineList();
		m.addAttribute("cList", cList);
		return "manbd/write";
	}
	
	
	@PostMapping("/manbd/write")
	public String write(ManbdDto dto) {
		System.out.println(dto);
		service.insert(dto);
		return "redirect:/manbd/list";// 글목록
	}
	
	//요청 page 번호를 받아서 페이지에 맞는 글을 갯수에 맞게 꺼내옴
	//전체 글 갯수에 맞춰 페이징 처리
	@RequestMapping("/manbd/list")
	public String list(@RequestParam(name="p", defaultValue = "1") int page, Model m ) {
		
		//글이 있는지 체크
		int count = service.count();
		if(count > 0) {
		
		int perPage = 10; // 한 페이지에 보일 글의 갯수
		int startRow = (page - 1) * perPage + 1;
		int endRow = page * perPage;
		
		List<ManbdDto> boardList = service.boardList(startRow, endRow);
		m.addAttribute("bList", boardList);
		
		List<ManbdDto> noticeList = service.noticeList(startRow, endRow);
		m.addAttribute("nList", noticeList);

		List<ManbdDto> eventList = service.eventList(startRow, endRow);
		m.addAttribute("eList", eventList);


		
		int pageNum = 5;
		int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수
		
		int begin = (page - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum -1;
		if(end > totalPages) {
			end = totalPages;
		}
		 m.addAttribute("begin", begin);
		 m.addAttribute("end", end);
		 m.addAttribute("pageNum", pageNum);
		 m.addAttribute("totalPages", totalPages);
		
		}
		m.addAttribute("count", count);
		return "manbd/list";
	}
	
	@GetMapping("manbd/content/{no}")
	public String content(@RequestParam(name="p", defaultValue = "1") int page, @PathVariable int no, Model m) {
	
			//글이 있는지 체크
			int count = service.count();
			if(count > 0) {
			
			int perPage = 5; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage + 1;
			int endRow = page * perPage;
			
			List<ManbdDto> boardList = service.boardList(startRow, endRow);
			m.addAttribute("bList", boardList);

			int pageNum = 5;
			int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수
			
			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum -1;
			if(end > totalPages) {
				end = totalPages;
			}
			 m.addAttribute("begin", begin);
			 m.addAttribute("end", end);
			 m.addAttribute("pageNum", pageNum);
			 m.addAttribute("totalPages", totalPages);
			
			}
			m.addAttribute("count", count);
		
		ManbdDto dto = service.boardOne(no);
		m.addAttribute("dto", dto);
		return "manbd/content";
	}
	
	@GetMapping("manbd/update/{manbd_no}")
	public String updateForm(@PathVariable int manbd_no, Model m) {
		ManbdDto dto = service.boardOne(manbd_no);
		m.addAttribute("dto", dto);
		
		List<CinemaDto> cList =  c_service.cineList();
		m.addAttribute("cList", cList);
		
		List<String> divi = new ArrayList<String>();
		divi.add("이벤트");
		divi.add("공지사항");
		m.addAttribute("divi",divi);
		
		return "manbd/updateForm";
	}
	
	@PutMapping("/manbd/update")
	public String update(ManbdDto dto) {
		//System.out.println(dto);
		service.updateBoard(dto);
		return "redirect:list";
	}
	
	@DeleteMapping("/manbd/delete")
	@ResponseBody
	public String delete(int no) {
		int i = service.deleteBoard(no); 
		return ""+i;
	}
	
	@GetMapping("/manbd/search")
	public String search(int searchn, String search,@RequestParam(name="p", defaultValue = "1") int page, Model m) {
		int count = service.countSearch(searchn,search);
		if(count > 0) {
		
		int perPage = 10; // 한 페이지에 보일 글의 갯수
		int startRow = (page - 1) * perPage + 1;
		int endRow = page * perPage;
		
		List<ManbdDto> boardList = service.boardListSearch(searchn,search,startRow, endRow);
		m.addAttribute("bList", boardList);

		int pageNum = 5;
		int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); //전체 페이지 수
		
		int begin = (page - 1) / pageNum * pageNum + 1;
		int end = begin + pageNum -1;
		if(end > totalPages) {
			end = totalPages;
		
		}
			
		 m.addAttribute("begin", begin);
		 m.addAttribute("end", end);
		 m.addAttribute("pageNum", pageNum);
		 m.addAttribute("totalPages", totalPages);
		
		}
		m.addAttribute("count", count);
		m.addAttribute("searchn", searchn);
		m.addAttribute("search", search);
		
		return "manbd/search";
	}
	
	
}

	
