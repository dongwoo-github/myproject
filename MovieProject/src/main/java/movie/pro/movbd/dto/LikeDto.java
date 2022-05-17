package movie.pro.movbd.dto;

import lombok.Data;

@Data
public class LikeDto {

	private String movbd_id;
	private int movbd_no;
	private int ltlike;
	private int count;//좋아요가 눌린 상태인가 아닌가.
}
