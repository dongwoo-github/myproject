package movie.pro.movbd.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import movie.pro.movbd.dto.LikeDto;
import movie.pro.movbd.service.LikeService;

@RestController
public class LikeController {
	@Autowired
	LikeService lservice;   
	
	@PutMapping("/like/likeupdate")
	public Map<String,String> likeupdate(LikeDto likedto){
		System.out.println(likedto);
		Map<String,String> map = new HashMap<String, String>();
		
		try {
			
			lservice.likeupdate(likedto);
			map.put("result", "success");
			  
		}catch(Exception e) {
			
			e.printStackTrace();
			map.put("result", "fail");
		}
		
		return map;
	}
}
