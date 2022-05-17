package movie.pro.servicecenter.controller;

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

import movie.pro.service.service.QnabdService;
import movie.pro.servicecenter.dto.QnabdDto;

@Controller
public class QnabdController {
	
	@Autowired
	QnabdService service;
	
	@RequestMapping("/qnabd/list")
	public String list(@RequestParam(name="p",defaultValue="1") int page, Model m) {
		
		int count = service.count();
		//글이 있는지 체크
			
		if(count>0) {
			int perPage = 10; // 한 페이지에서 보일 글의 갯수 고정값으로 가려면 final
			int startRow = (page-1) * perPage +1; 
			//로우넘은 1부터 시작하기때문! List를 통채로 사용할 경우는 0부터 시작하기 때문에 +1 안해도 됨!
			int endRow = page*perPage; 
			//마찬가지로 list를 통으로 가져워서 사용할 경우 -1해줘야함( 0부터 시작하기때문! )
			List<QnabdDto> qnabdList = service.qnaboardList(startRow, endRow);			
			m.addAttribute("list",qnabdList);
			
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
		m.addAttribute("page",page);
		m.addAttribute("count", count);
		return "qnabd/qnabdList";	
	}//list
	
	@GetMapping("qnabd/insert")
	public String insert() {
		return "qnabd/write";
	}//insert
	
	@GetMapping("qnabd/update/{qnabd_no}")
	public String updateForm(@PathVariable int qnabd_no, Model m) {
		QnabdDto dto = service.selectOne(qnabd_no);
		m.addAttribute("dto",dto);
		return "qnabd/updateForm";
	}//updateForm
	
	@PutMapping("/qnabd/update/{qnabd_no}")
	public String update(QnabdDto dto) {
		service.updateQna(dto);
		return "redirect:/qnabd/list";
	}//update
	
	@PostMapping("qnabd/insert")
	public String insertQna(QnabdDto dto) {
	
		service.insertQna(dto);
		
		return "redirect:/qnabd/list";
	}//insertQna
	
	@DeleteMapping("/qnabd/delete")
	@ResponseBody
	public String delete(int no) {
		int i = service.deleteQna(no);
		return ""+i;
	}//delete
	
	
}
