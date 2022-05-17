<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>극장 정보</title>
</head>
<style>
	#body{width:1400px; margin:auto;}
	#select_area {margin: 40px auto 60px auto;}
	#select_area .selected {background-color:#29468A;}
	#select_area div {display:inline-block; margin:10px 0px; padding:0px; width:14%; text-align:center; height:60px; line-height:60px;background-color:#789BED;}
	#select_area div a {font-weight:bold;font-size:20px;color:white;}
	#select_area div a:link{text-decoration:none;}
	#select_area div a:visited {text-decoration:none;}
	#select_area div a:hover {text-decoration:underline;}
	#select_area div a:active {text-decoration:underline;}
	
	#insertCinema {margin-top:20px;margin-bottom:20px;}
	
	.line{width:90%; margin:auto; font-weight:bold; font-size:20px;}
	
	details {
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: .5em .5em 0;
    margin-bottom: 1em;
	}
	summary {
	    font-weight: bold;
	    margin: -.5em -.5em 0;
	    padding: .5em;
	    cursor: pointer;
	}
	details[open] {
	    padding: .5em;
	}
	details[open] summary {
	    border-bottom: 1px solid #aaa;
	    margin-bottom: .5em;
	    background-color: #fff0c0;
	    border-radius: 10px 10px 0 0;
	}
	summary::marker{
    content: "+ ";
	}
	details[open] summary::marker {
	    content: "- ";
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		$(".cine_up").click(function(){
			let cine_no = $(this).attr("title");
			location.href="../../admin/cinema/updateCinema/"+cine_no;
		})//cine_upBtn click
		
		$(".cine_del").click(function(){
				let cine_no = $(this).attr("title");
				let select = confirm("정말 삭제하시겠습니까?");
				
				if(select==true){
					$.ajax({
						url:"/admin/cinema/deleteCinema",
						data:"cine_no="+cine_no,
						method:"delete"
					}).done(function(){
						alert("삭제가 완료되었습니다.")
						location.reload();
					})//ajax
				}//if
			})//cine_delBtn click
			
		$(".th_up").click(function(){
			let title = $(this).attr("title");
			let arr = title.split(",");
			let cine_no = arr[0];
			let th_no = arr[1];
			location.href="../../admin/theater/updateTheater/"+cine_no+"/"+th_no;
		})//th_upBtn click
			
		$(".th_del").click(function(){
			let title = $(this).attr("title");
			let arr = title.split(",");
			let cine_no = arr[0];
			let th_no = arr[1];
			
			let select = confirm("정말 삭제하시겠습니까?");
					
			if(select==true){
				$.ajax({
					url:"/admin/theater/deleteTheater",
					data:{"cine_no":cine_no,"th_no":th_no},
					method:"delete"
				}).done(function(){
					alert("삭제가 완료되었습니다.")
					location.reload();
				})//ajax
			}//if
			})//th_delBtn click
		
		$("#insertCinema").click(function(){
			location.href="../../admin/cinema/insertCinema";
		})//insertCinema
		
		$(".insertTheater").click(function(){
			let cine_no=$(this).attr("title");
			location.href="../../admin/theater/insertTheater/"+cine_no;
		})//insertTheater
		
	})//ready
	
</script>
<body>
	<div id="container">
		<div id="body">
			<div id="select_area" align="center">
				<div <c:if test="${cineArea=='서울'}">class='selected'</c:if>><a href="cineList?cineArea=서울">서울</a>
				</div><div <c:if test="${cineArea=='경기'}">class='selected'</c:if>><a href="cineList?cineArea=경기">경기</a>
				</div><div <c:if test="${cineArea=='인천'}">class='selected'</c:if>><a href="cineList?cineArea=인천">인천</a>
				</div><div <c:if test="${cineArea=='대전/충청/세종'}">class='selected'</c:if>><a href="cineList?cineArea=대전/충청/세종">대전/충청/세종</a>
				</div><div <c:if test="${cineArea=='부산/대구/경상'}">class='selected'</c:if>><a href="cineList?cineArea=부산/대구/경상">부산/대구/경상</a>
				</div><div <c:if test="${cineArea=='광주/전라'}">class='selected'</c:if>><a href="cineList?cineArea=광주/전라">광주/전라</a>
				</div><div <c:if test="${cineArea=='강원'}">class='selected'</c:if>><a href="cineList?cineArea=강원">강원</a></div>
			</div>
			<c:forEach items="${dto}" var="dto">
				<c:if test="${cineArea==dto.cine_area}">
				<details class="line">
					<summary>
						극장명 : ${dto.cine_name}
						<button class="cine_up" title="${dto.cine_no}">수정</button>
						<button class="cine_del" title="${dto.cine_no}">삭제</button>
					</summary>
					<c:forEach items="${th_dto}" var="th_dto">
						<c:if test="${dto.cine_no==th_dto.cine_no}">
							<div>상영관 번호 : ${th_dto.th_no}
							<button class="th_up" title="${dto.cine_no},${th_dto.th_no}">수정</button>
							<button class="th_del" title="${dto.cine_no},${th_dto.th_no}">삭제</button></div>
							<div>열 : ${th_dto.th_col} / 행 : ${th_dto.th_row}</div><hr>
						</c:if>
					</c:forEach>
					<div align="center"><button class="insertTheater" title="${dto.cine_no}">상영관 추가</button></div>
				</details>
				</c:if>
			</c:forEach>
			<div align="center"><button id="insertCinema">극장 등록</button></div>
		</div>
	</div>
</body>
</html>