package movie.pro.ticket.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.pro.ticket.dto.JoinShowinfoDto;
import movie.pro.ticket.dto.JoinTicketDto;
import movie.pro.ticket.dto.TicketDto;
import movie.pro.ticket.service.TicketService;

@Controller
public class TicketController {
	
	@Autowired
	TicketService service;
	
	@GetMapping("ticket/ticketing/{show_no}")
	public String ticketingForm(@PathVariable long show_no,Model m) {
		
		JoinShowinfoDto dto = service.selectShowinfo(show_no);
		m.addAttribute("dto", dto);
		
		return "ticket/ticketing";
		
	}//ticketingForm
	
	@PostMapping("ticket/ticketing/{show_no}")
	public String ticketing(TicketDto dto) {
		service.insertTicket(dto);
		service.updateSeat(dto);
		return "redirect:/ticket/ticketPage/"+dto.getTk_no();
	}//ticketing
	
	@GetMapping("ticket/ticketPage/{tk_no}")
	public String ticketPage(@PathVariable long tk_no,Model m) {
		
		JoinTicketDto dto = service.selectTkinfo(tk_no);
		m.addAttribute("dto",dto);
		return "ticket/ticketPage";
	}//ticketPage
	
	@GetMapping("ticket/ticketInfo")
	@ResponseBody
	public JoinTicketDto selectTicket(long tk_no) {
		return service.selectTkinfo(tk_no);
	}//selectTicket
	
	@GetMapping("ticket/selectSeat")
	@ResponseBody
	public List<String> selectSeat(long show_no) {
		return service.selectSeat(show_no);
	}//selectSeat
	
	@DeleteMapping("ticket/deleteTicket")
	@ResponseBody
	public String deleteTicket(TicketDto dto) {
		service.deleteTicket(dto.getTk_no());
		service.deleteSeat(dto);
		return "";
	}//deleteTicket
	
	@GetMapping("ticket/showinfoMovList")
	public String showinfoMovList() {
		return "ticket/showinfoMovList";
	}//showinfoMovList
	
	@GetMapping("ticket/showinfoCineList")
	public String showinfoCineList() {
		return "ticket/showinfoCineList";
	}//showinfoCineList
	
	@GetMapping("showinfo/showinfoCineList")
	@ResponseBody
	public List<JoinShowinfoDto> showCineList(String show_date,int cine_no){
		return service.showinfoCineList(show_date, cine_no);
	}//showCineList
	
	@GetMapping("showinfo/showinfoMovList")
	@ResponseBody
	public List<JoinShowinfoDto> showMovList(int mov_no,String show_date,String cine_area){
		return service.showinfoMovList(mov_no,show_date,cine_area);
	}//showCineList
	
}
