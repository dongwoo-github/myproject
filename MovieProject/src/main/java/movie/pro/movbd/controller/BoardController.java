package movie.pro.movbd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.member.dto.MemberDto;
import movie.pro.movbd.dto.BoardDto;
import movie.pro.movbd.dto.CommDto;
import movie.pro.movbd.dto.LikeDto;
import movie.pro.movbd.service.BoardService;
import movie.pro.movbd.service.CommService;
import movie.pro.movbd.service.LikeService;
import movie.pro.security.SecurityUser;

@Controller
public class BoardController {

	@Autowired
	LikeService lservice;
	
	@Autowired
    BoardService service;

	@Autowired
	CommService c_service;
	
	@GetMapping("/movbd/write")
	public String writeForm(@AuthenticationPrincipal SecurityUser principal, Model m) {
		MemberDto mem_dto =  principal.getDto();
		List<String> mov_list = service.movList(mem_dto.getMem_id());
		m.addAttribute("mov_list",mov_list);
		return "movbd/write";
	}
	
	@PostMapping("/movbd/write")
	public String write(BoardDto dto) {
		service.insert(dto);
		return "redirect:list";// 글목록
	}
	
	//요청 page 번호를 받아서 페이지에 맞는 글을 갯수에 맞게 꺼내옴
	//전체 글 갯수에 맞춰 페이징 처리
	@RequestMapping("/movbd/list")
	public String list(@RequestParam(name="p", defaultValue = "1") int page, Model m ) {
		
		//글이 있는지 체크
		int count = service.count();
		System.out.println(count);
		if(count > 0) {
		
		int perPage = 10; // 한 페이지에 보일 글의 갯수
		int startRow = (page - 1) * perPage + 1;
		int endRow = page * perPage;
	
		List<BoardDto> boardList = service.boardList(startRow, endRow);
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
		return "movbd/list";
	}
		
	@GetMapping("movbd/content/{no}")
	public String content( @PathVariable("no") int movbd_no, Model m, @AuthenticationPrincipal SecurityUser principal) {
		
		MemberDto user = principal.getDto();
		m.addAttribute("user", user);
		LikeDto likedto = new LikeDto();
		likedto.setMovbd_no(movbd_no);
		likedto.setMovbd_id(user.getMem_id());
		
		int ltlike = 0;
		System.out.println(likedto);
		int check = lservice.ltlikecount(likedto);
		System.out.println("check::"+check);
		if(check == 0) {
			
			lservice.likeinsert(likedto);
			
		}else if(check==1) {
			
			ltlike = lservice.ltlikegetinfo(likedto);
		}
		
		m.addAttribute("ltlike", ltlike);	
		
		//조회수 추가하는 update 
		service.readcnt(movbd_no);
		BoardDto dto = service.boardOne(movbd_no);
		m.addAttribute("dto", dto);
		List<CommDto> cList = c_service.selectComm(movbd_no);//글번호에 맞는 코멘트 꺼내오고  
		m.addAttribute("cList", cList);//모델에 cList라는 이름으로 추가
		return "movbd/content";
	}
	
	@GetMapping("movbd/update/{movbd_no}")
	public String updateForm(@PathVariable int movbd_no, Model m) {
		BoardDto dto = service.boardOne(movbd_no);
		m.addAttribute("dto", dto);
		List<CommDto> cList = c_service.selectComm(movbd_no);
		m.addAttribute("cList", cList);
		return "movbd/updateForm";
	}
	
	@PutMapping("/movbd/update")
	public String update(BoardDto dto) {
		service.updateBoard(dto);
		return "redirect:list";
	}
	
	@DeleteMapping("/movbd/delete")
	@ResponseBody
	public String delete(int movbd_no) {
		int i = service.deleteBoard(movbd_no); 
		return ""+i;
	}
	
	@GetMapping("/movbd/search")
	public String search(int searchn, String search,@RequestParam(name="p", defaultValue = "1") int page, Model m) {
		int count = service.countSearch(searchn,search);
		if(count > 0) {
		
		int perPage = 10; // 한 페이지에 보일 글의 갯수
		int startRow = (page - 1) * perPage + 1;
		int endRow = page * perPage;
		
		List<BoardDto> boardList = service.boardListSearch(searchn,search,startRow, endRow);
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
		
		return "movbd/search";
	}
	
	
}
