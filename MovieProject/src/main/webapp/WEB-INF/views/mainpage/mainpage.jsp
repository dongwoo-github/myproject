<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>메인페이지</title>
<style>
#body {margin-bottom:30px;}

#boxOffice table tr td ul li {list-style:none;} 

.poster {cursor:pointer;}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	function gotoMain() {
	  location.href="/mainpage";
	}//gotoMain
	
	function gotoService(){
		location.href="/inqubd/list";
	}//gotoService
	
	function gotoQna(){
		location.href="/qnabd/list";
	}//gotoQna
	
	
	$(function(){
		
		let api_key = "3f1a9babda761564c4e03796bac0c3e9";
	
		$.ajax({
			url:"https://api.themoviedb.org/3/movie/popular?api_key="+api_key+"&language=ko-KR&page=${page}",
			type:"get",
			dataType:"json"
		}).done(function(data){
			
			let str = "";
			str += "<table id='movTable'>"
			for(let i in data.results){
				let b = Number(i)+1;
				
				if(b%4==1){
					str += "<tr>";
					
					$.ajax({
						url:"https://api.themoviedb.org/3/movie/"+data.results[i].id+"/videos?api_key="+api_key+"&language=ko-KR",
						type:"get",
						dataType:"json"
					}).done(function(data){
						if(data.results!=""){
							let str = "";
								let url = "https://www.youtube.com/embed/"+data.results[0].key+"?autoplay=1&amp;mute=1";
								str += "<iframe width='1195' height='672' src="+url+
								" frameborder='0' gesture='media' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
					
							$("#trailer").append(str);
						}//if
						
					})//trailerAjax
					
				}
				
				if(data.results[i].poster_path!=null){
					img = "https://image.tmdb.org/t/p/original/"+data.results[i].poster_path;
				}else{
					img = "/images/noImg.JPG";
				}
				let id = data.results[i].id;
				str += "<td><ul><li><img class='poster' id="+id+" width=270 height=355 margin=50 src="+img+"></il></ul></td>";
				
				if(b%4==0){
					str += "</tr>";
					break;
				}
			}//for
			
			str += "</table>";
			$("#boxOffice").append(str);
			
		});//ajax
		
		$("#boxOffice").on("click",".poster",function(){
			let id = $(this).attr("id");
			location.href="../movie/movieInfo/"+id;
		});//posterclick
		
	});//ready
	
</script>
</head>
<body>

<div id="container">
	
	<jsp:include page="/header" flush="true"/>
	
	<div id="body">
	
	<div id="trailer" align="center"></div>
	<div id="boxOffice" align="center"></div>
	
	
	</div>
	<jsp:include page="/footer" flush="true"/>
</div>
</body>
</html>