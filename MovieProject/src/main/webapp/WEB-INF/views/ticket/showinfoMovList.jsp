<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>상영정보 리스트</title>
</head>
<style>
	#select_date li {display:inline-block;}
	#select_date li div{padding:5px;}
	#select li {padding:5px;}
	#list li{display:inline-block; padding:5px;}
	#list li div{padding:5px;}
	#cineArea li{padding:10px; display: inline-block;}
	#result .th_line div {display:inline-block;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		let show_hour = new Date().getHours()+1;
		let show_minute = new Date().getMinutes();
		let today = new Date().toISOString().substr(0,10);
		let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		let areaList = ["서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"];
		let cine_area = areaList[0];
		let show_date = today;
		let mov_no = 0;
		
		for(let i=0; i<=7 ; i++){
			let date = new Date();
			date.setDate(date.getDate()+i);
			date = date.toISOString().substr(0,10);
			let date_arr = date.split("-");
			
			$("#select_date").append("<li><div class='date' id="+date+"><div>"+date_arr[0]+"."+date_arr[1]+"</div><div align='center'>"+date_arr[2]+"</div></div></li>");
		}//for select_date 설정	
		
		for(let i in areaList){
			$("#cineArea").append("<li><div class='cineArea' id="+areaList[i]+">"+areaList[i]+"</div></li>");
		}//for
		
		for(let i = 1; i <= 2; i++){
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/popular?api_key="+api_key+"&language=ko-KR&page="+i,
				type:"get",
				dataType:"json"
			}).done(function(data){
				let list = "<li>";
				let img = "";
				
				for(let j in data.results){
					
					if(i==1&&j==0){
						
						mov_no = data.results[j].id;
						$("#msg").append(data.results[j].title+" 상영시간표");
						if(data.results[i].poster_path!=null){
							img = "https://image.tmdb.org/t/p/original/"+data.results[j].poster_path;
						}else{
							img = "/images/noImg.JPG";
						}
						
						$("#poster").append("<img class='poster' width=300 height=400 src="+img+">");
					}
					
					list += "<div class='movList' id="+data.results[j].id+" title='"+data.results[j].title+"'>"+data.results[j].title+"</div>";
				}//for
				
				list += "</li>";
				
				$("#list").append(list);
				
				if(i==2){
			
					$.ajax({
						url:"/showinfo/showinfoMovList",
						data:{"show_date":show_date,"cine_area":cine_area,"mov_no":mov_no},
						type:"get",
						dataType:"json"
					}).done(function(data){
						
						let cine_no = 0;
						let th_no = 0;
						let str="";
						let chk = 0;
						let result_chk = 0;
											
						if(data!=""){
							
							for(let i in data){
								
								if(data[i].show_h<show_hour){
									continue;
								}//if
								if(data[i].show_h==show_hour){
									if(data[i].show_m < show_minute){
										continue;
									}//if
								}//if
								
								result_chk=1;
							if(chk==0){
								chk=1;
								cine_no = data[i].cine_no;
								th_no = data[i].th_no;
								str += "<div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>";
								str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
							}//if
							
							if(cine_no != data[i].cine_no){
								cine_no = data[i].cine_no;
								th_no = data[i].th_no;
								str += "<hr></div><div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>"
								str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
							}//if
							
							if(th_no != data[i].th_no){
								th_no = data[i].th_no;
								str += "</div><hr><div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
							}//if
							
							let show_h = data[i].show_h;
							let show_m = data[i].show_m;
							if(show_h<10){
								show_h = "0"+show_h;
							}//if
							if(show_m==0){
								show_m = "00";
							}
							
							str += "<div class='show_info' title="+data[i].show_no+"><ul><li>"+show_h+":"+show_m+"</li><li>"+data[i].th_extra+"석</li></ul></div>";
							
						}//for
						
						$("#result").append(str);
							
						}else{
							$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
						}//if
						
						if(data!=""&&result_chk==0){
							$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
						}//if
						
					})//ajax
				}
				
				})//ajax
		}//for list 초기 설정
			
		//여기까지 초기 설정
		
		$("#list").on("click",".movList",function(){
			cine_area = areaList[0];
			show_date = today;
			mov_no = $(this).attr("id");
			$("#result").empty();
			$("#msg").empty();
			$("#msg").append($(this).attr("title")+" 상영시간표");
			$("#poster").empty();
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/"+$(this).attr("id")+"?api_key="+api_key,
				type:"get",
				dataType:"json"
			}).done(function(data){
				let img="";
				if(data.poster_path!=null){
					img = "https://image.tmdb.org/t/p/original/"+data.poster_path;
				}else{
					img = "/images/noImg.JPG";
				}//if
				
				$("#poster").append("<img class='poster' width=300 height=400 src="+img+">");
		
			})//ajax 포스터 변경
			
			$.ajax({
				url:"/showinfo/showinfoMovList",
				data:{"show_date":show_date,"cine_area":cine_area,"mov_no":mov_no},
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let cine_no = 0;
				let th_no = 0;
				let str="";
				let chk = 0;
				let result_chk = 0;
									
				if(data!=""){
					
					for(let i in data){
						
						if(data[i].show_h<show_hour){
							continue;
						}//if
						if(data[i].show_h==show_hour){
							if(data[i].show_m < show_minute){
								continue;
							}//if
						}//if
						
						result_chk=1;
					if(chk==0){
						chk=1;
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>";
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(cine_no != data[i].cine_no){
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<hr></div><div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>"
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(th_no != data[i].th_no){
						th_no = data[i].th_no;
						str += "</div><hr><div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					let show_h = data[i].show_h;
					let show_m = data[i].show_m;
					if(show_h<10){
						show_h = "0"+show_h;
					}//if
					if(show_m==0){
						show_m = "00";
					}
					
					str += "<div class='show_info' title="+data[i].show_no+"><ul><li>"+show_h+":"+show_m+"</li><li>"+data[i].th_extra+"석</li></ul></div>";
					
				}//for
				
				$("#result").append(str);
					
				}else{
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
				if(data!=""&&result_chk==0){
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
			})//ajax
			
		})//onclick movList
		
		$("#cineArea").on("click",".cineArea",function(){
			
			cine_area = $(this).attr("id");
			$("#result").empty();
			
			$.ajax({
				url:"/showinfo/showinfoMovList",
				data:{"show_date":show_date,"cine_area":cine_area,"mov_no":mov_no},
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let cine_no = 0;
				let th_no = 0;
				let str="";
				let chk = 0;
				let result_chk = 0;
									
				if(data!=""){
					
					for(let i in data){
						
						if(show_date==today){
							if(data[i].show_h<show_hour){
								continue;	
							}//if
							if(data[i].show_h==show_hour){
								if(data[i].show_m < show_minute){
										continue;
								}//if
							}//if
						}
						
						result_chk=1;
					if(chk==0){
						chk=1;
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>";
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(cine_no != data[i].cine_no){
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<hr></div><div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>"
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(th_no != data[i].th_no){
						th_no = data[i].th_no;
						str += "</div><hr><div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					let show_h = data[i].show_h;
					let show_m = data[i].show_m;
					if(show_h<10){
						show_h = "0"+show_h;
					}//if
					if(show_m==0){
						show_m = "00";
					}
					
					str += "<div class='show_info' title="+data[i].show_no+"><ul><li>"+show_h+":"+show_m+"</li><li>"+data[i].th_extra+"석</li></ul></div>";
					
				}//for
				
				$("#result").append(str);
					
				}else{
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
				if(data!=""&&result_chk==0){
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
			})//ajax
			
			
		})//cineArea click
		
		$("#select_date").on("click",".date",function(){
			
			show_date = $(this).attr("id");
			$("#result").empty();
			
			$.ajax({
				url:"/showinfo/showinfoMovList",
				data:{"show_date":show_date,"cine_area":cine_area,"mov_no":mov_no},
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let cine_no = 0;
				let th_no = 0;
				let str="";
				let chk = 0;
				let result_chk = 0;
									
				if(data!=""){
					
					for(let i in data){
							
							if(show_date==today){
								if(data[i].show_h<show_hour){
									continue;	
								}//if
								if(data[i].show_h==show_hour){
									if(data[i].show_m < show_minute){
											continue;
									}//if
								}//if
							}
						
						result_chk=1;
					if(chk==0){
						chk=1;
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>";
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(cine_no != data[i].cine_no){
						cine_no = data[i].cine_no;
						th_no = data[i].th_no;
						str += "<hr></div><div class='cine_name'><h4>"+data[i].cine_name+"</h4></div><hr>"
						str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					if(th_no != data[i].th_no){
						th_no = data[i].th_no;
						str += "</div><hr><div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
					}//if
					
					let show_h = data[i].show_h;
					let show_m = data[i].show_m;
					if(show_h<10){
						show_h = "0"+show_h;
					}//if
					if(show_m==0){
						show_m = "00";
					}
					
					str += "<div class='show_info' title="+data[i].show_no+"><ul><li>"+show_h+":"+show_m+"</li><li>"+data[i].th_extra+"석</li></ul></div>";
					
				}//for
				
				$("#result").append(str);
					
				}else{
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
				if(data!=""&&result_chk==0){
					$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
				}//if
				
			})//ajax
			
		})//select_date click
		
		$("#result").on("click",".show_info",function(){
			location.href="../ticket/ticketing/"+$(this).attr("title");
		})//showinfoClick
		
	})//ready
	
</script>
<body>
<div id="container">
<div id="selectMenu">
	<table id="menuTable">
		<tr>
			<td rowspan="2"><ul><li><a href="showinfoMovList">영화별</a></li><li><a href="showinfoCineList">극장별</a></li></ul></td>
			<td><ul id="select"><li>전체 영화</li></ul></td>
		</tr>
		<tr><td><ul id="list">
		</ul></td><td rowspan="2" id="poster"></td></tr>
	</table>
</div>
<div id="timeTable">
	<h3 id="msg"></h3>
	<ul id="select_date"></ul>
	<ul id="cineArea"></ul>
	<div id="result">
		
	</div>
</div>

</div>
</body>
</html>