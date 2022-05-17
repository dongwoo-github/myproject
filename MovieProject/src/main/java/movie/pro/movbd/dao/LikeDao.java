package movie.pro.movbd.dao;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import movie.pro.movbd.dto.LikeDto;

@Repository
public class LikeDao {
	@Autowired
	private SqlSessionTemplate sqltemp;
	
	public int ltlikecount(LikeDto likedto) {
		System.out.println(likedto.getMovbd_id());
		return sqltemp.selectOne("like.ltlikecount", likedto);
	}
	
	public int ltlikegetinfo(LikeDto likedto) {
		return sqltemp.selectOne("like.ltlikegetinfo",likedto);
	}
	
	public void likeinsert(LikeDto likedto) {
		sqltemp.insert("like.likeinsert",likedto);
	}
	
	public void likeupdate(LikeDto likedto) {
		sqltemp.update("like.likeupdate",likedto);
	}
}
