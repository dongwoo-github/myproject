<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#movieMenu ul li{display:inline-block;}
	 
	#searchList {width:1500px; overflow:hidden;border-radius:10px;border:1px solid;}
	 
	#mov_list tr td ul li{list-style:none; font-weight:bold;}
	 
	#mov_list tr {border:none;}
	
	#mov_list tr td {border:none;}
	 
	#mov_list tr td ul .title{font-size:20px; line-height:2;} 
	
	#mov_list tr td ul .reg_date{line-height:3;}
	
	#mov_list {border:1px solid black; border-radius:10px; border-collapse:collapse;}
	
	.poster {cursor:pointer; margin-left:20px; margin-right:10px; margin-top:20px;margin-bottom:5px;}
	
	#info{font-weight:bold;}
	
	.line-gr{background-color:#C3D1F1;}
</style>
<link href="/css/nav.css" rel="stylesheet">
<link href="/css/pager.css" rel="stylesheet">
<link href="/css/movieMenu.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	$(function(){
		
			let api_key = "3f1a9babda761564c4e03796bac0c3e9";
			let totalPages= 0;
			
			$.ajax({
				url:"https://api.themoviedb.org/3/search/movie?api_key="+api_key+"&query=${key}&language=ko-KR&page=${page}",
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let list = "<div id='searchList'><table id='mov_list'>";
				
				for (let i in data.results){
					let img = "";
					if(data.results[i].poster_path!=null){
						img = "https://image.tmdb.org/t/p/original/"+data.results[i].poster_path;
					}else{
						img = "/images/noImg.JPG";
					}
					let id = data.results[i].id;
					let title = data.results[i].title;
					let reg_date = data.results[i].release_date;
					let overview = data.results[i].overview;
					if(i%2==0){
						list += "<tr class='line-wh'><td class='posterTd'><img class='poster' width=100 height=120 src="+img+" id="+id+" class='poster'></td>";
					}
					if(i%2==1){
						list += "<tr class='line-gr'><td class='posterTd'><img class='poster' width=100 height=120 src="+img+" id="+id+" class='poster'></td>";
					}
					
					list += "<td class='infoTd'><ul><li class='title'>"+title+"</li>";
					if(reg_date!=""){
						list += "<li class='reg_date'>"+reg_date+"</li>";
					}
					if(overview!=""){
						list += "<li class='overview'>"+overview+"</li>";
					}
				}
				
				list += "</ul></td></tr></table></div>";
				
				$("#searchList").append(list);
				
				
			});//ajax
			
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
			
			$("#searchList").on("click",".poster",function(){
				let id = $(this).attr("id");
				location.href="../../movieInfo/"+id;
			});//posterclick
			
	});
</script>
<script>
//
</script>
<title>검색 결과</title>
</head>
<body>
<div id="container">
<div id="body">
	<div id="movieMenu" align="center">
		<div class="boxOffice"><a href="/movie/boxOffice">박스오피스</a>
		</div><div class="upComming"><a href="/movie/upComming">최신 개봉 영화</a>
		</div><div class="search" align="center"><input id="key" class="search-input" name="key" size="10"><button id="search">검색</button></div>
	</div>
	<c:if test="${totalPages==0}">
		<h3>검색 결과가 없습니다.</h3>
	</c:if>
	<c:if test="${totalPages!=0}">
		<div align="center"><h2 id="info">포스터를 클릭하면 상세정보로 이동합니다.</h2></div>
		<div id="searchList">
			
		</div>
		<div id="page" align="center" class="pagination-wrapper">
			<div class="pagination">
			<c:if test="${begin > pageNum }">
				<a class="prev page-numbers" href="?p=${begin-1}">이전</a>
			</c:if>
			<c:forEach begin="${begin}" end="${end}" var="i">
				<c:if test="${page==i}"><a aria-current="page" class="page-numbers current" href="?p=${i}">${i}</a></c:if>
				<c:if test="${page!=i}"><a class="page-numbers" href="?p=${i}">${i}</a></c:if>
			</c:forEach>
			<c:if test="${end<totalPages}">
				<a class="next page-numbers" href="?p=${end+1}">다음</a>
			</c:if>
			</div>
		</div>
	</c:if>
</div>
</div>
</body>
</html>