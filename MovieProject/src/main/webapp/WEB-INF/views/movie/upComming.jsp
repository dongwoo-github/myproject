<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>최신 개봉작</title>
</head>
<link href="/css/pager.css" rel="stylesheet">
<link href="/css/movieMenu.css" rel="stylesheet">
<style>
	img { 
		cursor:pointer;
	 }
	 
	 .ticekting{
	 display:block;
	 margin:auto;
	 }
	 
	#upComming {margin:auto;}
	#upComming ul li{list-style:none;}
	 
</style>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	$(function(){
		
			let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/upcoming?api_key="+api_key+"&language=ko-KR&page=${page}",
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let str = "";
				str += "<table>"
				for(let i in data.results){
					let b = Number(i)+1;
					
					if(b%4==1){
						str += "<tr>";
					}
					
					if(data.results[i].poster_path!=null){
						img = "https://image.tmdb.org/t/p/original/"+data.results[i].poster_path;
					}else{
						img = "/images/noImg.JPG";
					}
					let id = data.results[i].id;
					str += "<td><ul><li><img class='poster' id="+id+" width=300 height=400 margin=50 src="+img+"></il></ul></td>";
					
					if(b%4==0){
						str += "</tr>";
					}
				}//for
				str += "</table>";
				$("#upComming").append(str);
				
			});//ajax
			
			$("#upComming").on("click",".poster",function(){
				let id = $(this).attr("id");
				location.href="../movie/movieInfo/"+id;
			});//posterclick
			
			$("#search").click(function(){
				let key = $("#key").val();
				if(!key){
					alert("검색어를 입력하세요!");
				}else{
					
					$.ajax({
						url:"https://api.themoviedb.org/3/search/movie?api_key="+api_key+"&query="+key+"&language=ko-KR",
						type:"get",
						dataType:"json"
					}).done(function(data){
						let totalPages = data.total_pages;
						location.href="/movie/searchList/"+key+"/"+totalPages;
					});//ajax
					
				}
			})//search click
			
	});
</script>
<body>
<div id="container">

<jsp:include page="/header" flush="true"/>

<div id="body">
	<div id="movieMenu" align="center">
		<div class="boxOffice"><a href="/movie/boxOffice">박스오피스</a>
		</div><div class="selected upComming"><a href="/movie/upComming">최신 개봉 영화</a>
		</div><div class="search" align="center"><input id="key" class="search-input" name="key" size="10"><button id="search">검색</button></div>
	</div>
	<div id="upComming" align="center">
	
	</div>
	<div class="pagination-wrapper">
  		<div class="pagination">
			<c:forEach begin="1" end="5" var="i">
				<c:if test="${page==i}"><a aria-current="page" class="page-numbers current" href="?p=${i}">${i}</a></c:if>
				<c:if test="${page!=i}"><a class="page-numbers" href="?p=${i}">${i}</a></c:if>
			</c:forEach>
		</div>
	</div>
</div>

<jsp:include page="/footer" flush="true"/>

</div>
</body>
</html>