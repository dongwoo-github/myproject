<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>영화 정보</title>
<style>
	
	td {padding:10px;}
	
	.poster {padding:10px; cursor:pointer; margin-left:500px;}
	
	#body{margin:auto;}
	
	#movieMenu ul li{display:inline-block;}
	
	#gallery_wrap{ margin: 0 auto; width: 450px;}
	#gallery_wrap .bx-wrapper{margin-bottom: 20px;}
	#gallery_wrap ul li {list-style:none;}
	.slider-pager{text-align: center;}
	.slider-pager li{display: inline;}
	
	
	#contents{
      margin: 0 auto;
    }
    .slider-box{
      margin: 40px 0;
    }
    .slider-for{
    	margin:auto;
    	display:inline-block; 
    }
    .slider-nav li{
    }
	
	.slick-dots li{display:inline-block; margin:3px;}
	.slick-dots {width:1000px; height:300px; overflow:scroll; margin:auto;}
	.slcik-list .slick-track{ display:inline-block;
	}
	.slick-next {
	display:inline-block;
    position:absolute;
    right:20px;
    border:none;
	background-color:white;
	}
	.slick-prev {
		display:inline-block;
		position:absolute;
   		left:20px;
		border:none;
		background-color:white;
	}
	.slick-next:before {
	    content:url(/images/next.png);
	}
	.slick-prev:before {
	    content:url(/images/prev.png);
	}
	
	#posterNinfoTable {overflow:hidden; font-weight:bold;}
	#posterNinfoTable {border:2px solid; border-collapse:collapse;}
	#posterNinfoTable tr td{border:2px solid; border-collapse:collapse;}
	table {border-collapse:collapse;}
	table tr td {border-collapse:collapse;}
	.title,.tagline {font-size:20px}
	
	.name,.peopleImg {margin:auto; align: center;}
	
	details summary {font-weight:bold; font-size:20px;}
</style>
</head>
<link href="/css/nav.css" rel="stylesheet">
<link href="/css/movieMenu.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua:400" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script>
	$(function(){
			
			let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/"+${id}+"?api_key="+api_key+"&language=ko-KR",
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let genres = "";
				for(let i in data.genres){
					if(data.genres!=""){
						if(i == data.genres.length-1){
							genres += data.genres[i].name;
						}else{
							genres += data.genres[i].name+"/";
						}//if
					}//if
				}//for
				
				if(data.poster_path!=null){
					img = "https://image.tmdb.org/t/p/original/"+data.poster_path;
				}else{
					img = "/images/noImg.JPG";
				}//if
				
				let str = "<h1>영화정보</h1><table id='posterNinfoTable'><tr><td><img width=300 height=400 margin=50 src="+img+" onerror=this.src='/images/noImg.JPG'></td>";
				str += "<td><ul style='list-style-type:none;'><li class='title'>제목 : "+data.title+"</li>";
				if(data.release_date!=""){
					str += "<li>개봉일 : "+data.release_date+"</li>";
				}
				if(genres!=""){
					str += "<li>장르 : "+genres+"</li>";
				}
				if(data.runtime!=0&&data.runtime!=null){
					str += "<li>상영 시간 : "+data.runtime+"</li><br>";
				}
				if(data.tagline!=""){
					str += "<li class='tagline'>"+data.tagline+"</li>";
				}
				if(data.overview!=""){
					str += "<li>줄거리 : "+data.overview+"</li><br>";
				}
				
				str += "<li>평점 : "+data.vote_average+"</li>";
				if(data.vote_count==0){
					str += "<li>평점 참여 인원이 없습니다.</li>";
				}
				
				str += "</ul></td></tr></table>";
				
				$("#posterNinfo").append(str);
				
			})//infoAjax 

			$.ajax({
				url:"https://api.themoviedb.org/3//movie/"+${id}+"/credits?api_key="+api_key+"&language=ko-KR",
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let str = "";
				if(data.cast!=""){
					str += "<h1>등장인물</h1><table border='2px' collapse><tr>";
					
					for(let i in data.cast){
						if(i==8){
							break;
						}
						let img = "";
						if(data.cast[i].profile_path!=null){
							img = "https://image.tmdb.org/t/p/original/"+data.cast[i].profile_path;
						}else{
							img = "/images/noImg.JPG";
						}//if
						str += "<td><div align='center'><img class='peopleImg' width=100 height=133 margin=50 src="+img+"></div><div align='center' class='name'>"+data.cast[i].name+"</div></td>";
					}//for
				}//if 등장인물 정보 출력
				
				str += "</tr></table>";
				$("#actors").append(str);
				
					if(data.crew!=""){
						for(let i in data.crew){
							let chk = 0;
							let img = "";
							if(data.crew[i].department=="Directing"&&data.crew[i].job=="Director"){
								if(chk==0){
									str = "";
									str += "<h1>감독</h1><table border='2px' collapse><tr>";
									chk = 1;
								}
								if(data.crew[i].profile_path!=null){
									img = "https://image.tmdb.org/t/p/original/"+data.crew[i].profile_path;
								}else{
									img = "/images/noImg.JPG";
								}//if
								str += "<td><div align='center'><img class='peopleImg' width=100 height=133 margin=50 src="+img+"></div><div class='name' align='center'>"+data.crew[i].name+"</div></td>";
							}
						}//for
					str += "</tr></table>";
					$("#director").append(str);
				}//if 감독 정보 출력
				
				
				
			})//CreditAjax
				
				$.ajax({
					url:"https://api.themoviedb.org/3/movie/"+${id}+"/images?api_key="+api_key,
					type:"get",
					dataType:"json"
				}).done(function(data){
					
					if(data.posters!=""){
					$("#img").prepend("<h1>사진</h1>");
					let str = "";
					let str_pager = "";
					
					for(let i in data.posters){
						let img = "https://image.tmdb.org/t/p/original/"+data.posters[i].file_path;
						str += "<li><img class='poster' width=350 height=500 margin=5 src="+img+" alt="+i+"></li>";
					}//for
					
					
					$(".slider-for").append(str);
					
					$(".slider-for").slick({
						slide:'li',
						slidesToShow:1,
						dots:true,
						autoplay:false,
						prevArrow: '<button class="slick-prev"></button>',
					    nextArrow: '<button class="slick-next"></button>',
						customPaging: function(slider, i) { 
							let img = "https://image.tmdb.org/t/p/original/"+data.posters[i].file_path;
				            return "<img class='thumb' width:100 height=150 src="+img+" />";
				        }
					});
						
					}//if
					
				})//img Ajax
				
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/"+${id}+"/videos?api_key="+api_key+"&language=ko-KR",
				type:"get",
				dataType:"json"
			}).done(function(data){
				if(data.results!=""){
					$("#trailer").append("<h1>예고편</h1>");
					let str = "";
					for(let i in data.results){
						let url = "https://www.youtube.com/embed/"+data.results[i].key+"?mute=0";
						str += "<details><summary>"+data.results[i].name+"<hr></summary>";
						str += "<iframe width='1195' height='672' src="+url+
						" frameborder='0' gesture='media' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe><hr></details>";
					}
			
					$("#trailer").append(str);
				}//if
				
			})//trailerAjax
			
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
	
	
	<div id="body">
	<div id="movieMenu" align="center">
		<div class="boxOffice"><a href="/movie/boxOffice">박스오피스</a>
		</div><div class="upComming"><a href="/movie/upComming">최신 개봉 영화</a>
		</div><div class="search" align="center"><input id="key" class="search-input" name="key" size="10"><button id="search">검색</button></div>
	</div>
	
		<div id="posterNinfo">
		</div>
		<div id="people">
			<table>
				<tr>
					<td><div id="actors"></div></td>
					<td><div id="director"></div></td>
				</tr>
			</table>
		</div>
		<div id="content">
			<div id="slide-box">
				<ul class="slider-for">
				</ul>
			</div>
		</div>
		<div id="trailer">
		</div>
	</div>
</div>
</body>
</html>