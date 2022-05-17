package movie.pro.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MovieController {
	
	@GetMapping("movie/boxOffice")
	public String boxOffice(@RequestParam(name="p",defaultValue="1") int page,Model m) {
		m.addAttribute("page",page);
		return "movie/boxOffice";
	}//boxOffice
	
	@GetMapping("movie/upComming")
	public String upComming(@RequestParam(name="p",defaultValue="1") int page,Model m) {
		m.addAttribute("page",page);
		return "movie/upComming";
	}//upComming
	
	@GetMapping("movie/movieInfo/{id}")
	public String movieInfo(@PathVariable int id,Model m) {
		m.addAttribute("id",id);
		return "movie/movieInfo";
	}//movieInfo
	
	@GetMapping("/movie/searchList/{key}/{totalPages}")
	public String searchMovie(@RequestParam(name="p",defaultValue="1") int page,
			@PathVariable String key,@PathVariable int totalPages, Model m) {
		
		if(totalPages>0) {
	
			int pageNum = 10;
			
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
		m.addAttribute("page", page);
		m.addAttribute("key",key);
		
		return "movie/searchList";
	}//movieSearch

}
