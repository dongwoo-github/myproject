<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>예매 내역</title>
<style>
	#body{width:1000px;margin:40px auto; position:relative;}
	#poster,#info{display:inline-block; width:49%;}
	#info {margin-:auto;position:absolute;right:0px;top:5%;}
	#poster img {margin:auto;}
	#info ul li {margin-top:20px;font-weight:bold;font-size:16px;}
	ul li {list-style:none; width:99%;}
	#seat {margin-top:20px; width:270px;}
        
    #seat div {display:inline-block; background-color:#C3D1F1; font-size:20px; width:50px; height: 40px; text-align:center; line-height:40px;}
        
    #seat div{margin:5px;}
        
    #selectPeople{margin: 20px auto;text-align:center;font-weight:bold;}
        
    #selectSeat{text-align:center;margin:20px auto;}
        
    #title{font-weight:bold;font-size:30px;}
        
    #pay_msg {font-weight:bold; font-size:30px;}
        
    .p , #pay_msg{display:inline-block;}
        
     #btn_div {margin-top:30px;}
     
     #btntable {width: 200px; margin-left: auto; margin-right: auto;}
	
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	let api_key = "3f1a9babda761564c4e03796bac0c3e9";

	$(function(){
	
		let today = new Date().toISOString().substr(0,10);
		let show_hour = new Date().getHours()+1;
		let show_minute = new Date().getMinutes();
		
	$.ajax({
			url:"https://api.themoviedb.org/3/movie/"+${dto.mov_no}+"?api_key="+api_key,
			type:"get",
			dataType:"json"
		}).done(function(data){
			let img="";
			if(data.poster_path!=null){
				img = "https://image.tmdb.org/t/p/original/"+data.poster_path;
			}else{
				img = "/images/noImg.JPG";
			}//if
					
			$("#poster").append("<img class='poster' width=350 height=500 src="+img+">");
			
			})//ajax 포스터 변경
			
			$.ajax({
				url:"../ticketInfo",
				type:"get",
				data:"tk_no="+"${dto.tk_no}",
				dataType:"json"
			}).done(function(data){
				
				let date = data.show_date.substr(0,10);
				
				if(date>=today){
					$("#btn_div").prepend("<button id='delBtn' >예매취소</button>");
				}
				})//ajax
	
	
	$("#delBtn").click(function(){
		
		let select = confirm("정말 취소하시겠습니까?");
		
		if(select==true){
			
			$.ajax({
				url:"../../ticket/deleteTicket",
				data:{
					"tk_a":${dto.tk_a},
					"tk_c":${dto.tk_c},
					"show_no":${dto.show_no},
					"tk_no":${dto.tk_no}
				},
				method:"delete"
			}).done(function(data){
					alert("취소가 완료되었습니다.");
					location.href="../../mytkList";
				})//ajax 포스터 변경
			
		}//if
		
	})//click
	
	})//ready
		
	
	$(function(){
		
		$("#mytk").click(function(){
			
			location.href="/../../mytkList";
			
		})//click
		
	})//ready	
	
</script>
<body>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="user" />
	<c:if test="${user.username==dto.tk_id}">
	<div id="container">
		<div id="body">
			<div id="poster">
			
			</div>
			<div id="info">
				<ul>
					<li><div id="title">${dto.mov_title}</div></li>
					<li><div id="th_no">${dto.cine_name} / ${dto.th_no}관</div></li>
					<li><div id="show_date"><fmt:formatDate value="${dto.show_date}" pattern="yyyy년 MM월 dd일"/></div></li>
					<li><div id="show_time">${dto.show_h}시 ${dto.show_m}분</div></li>
					<li>선택좌석<div id="seat"><c:forEach items="${dto.tk_seat}" var="seat"><div class="seat">${seat}</div></c:forEach></div><input type="hidden" id="tk_seat" name="tk_seat" value="${dto.tk_seat}"></li>
					<li><div id="people">성인 ${dto.tk_a}명 청소년 ${dto.tk_c}명</div></li>
					<li><div id="pay_msg">결제금액 ${dto.tk_pay}</div><input type="hidden" id="tk_pay" name="tk_pay"></li>
				</ul>
			</div>
			<table id = btntable>
				<td><div align="center" id="btn_div"> <button id="mytk">내 예매 정보 확인</button></div></td>
				<td><div align="center" id="btn_div"> <button id="delBtn">취소</button></div></td>
			</table>
		</div>
	</div>
	</c:if>
	</sec:authorize>
</body>
</html>