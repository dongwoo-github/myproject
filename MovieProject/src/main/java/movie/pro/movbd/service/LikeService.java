package movie.pro.movbd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import movie.pro.movbd.dao.LikeDao;
import movie.pro.movbd.dto.LikeDto;

@Service
public class LikeService {
	@Autowired
	LikeDao likedao;
	
	public int ltlikecount(LikeDto likedto) {
		return likedao.ltlikecount(likedto);
	}
	
	public int ltlikegetinfo(LikeDto likedto) {
		return likedao.ltlikegetinfo(likedto);
	}
	
	public void likeinsert(LikeDto likedto) {
		likedao.likeinsert(likedto);
	}
	
	public void likeupdate(LikeDto likedto) {
		likedao.likeupdate(likedto);
	}
}
