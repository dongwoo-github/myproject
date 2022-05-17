<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>상영정보 리스트</title>
</head>
<style>
	
	#body {width:1400px;margin:auto;}
	
	#select_date li {display:inline-block;}
	#select_date li div{padding:5px;}
	#select div {display:inline-block;margin:auto;width:150;hegiht:75}
	
	#list li div {display:inline-block; padding:5px;}
	#result .th_line div {display:inline-block;}
	#selectMovCine li a {color:white;}
	#selectMovCine li a:link {text-decoration:none;}
	#selectMovCine li a:visited {text-decoration:none;}
	#selectMovCine li a:hover {text-decoration:underline;}
	#selectMovCine li a:active {text-decoration:underline;}
	#selectMovCine li {list-style:none; width:100px; height:50px;background-color:#A3B3D9;text-align:center;line-height:50px;}
	#selectMovCine #selected {background-color:#072260;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		
		let show_hour = new Date().getHours()+1;
		let show_minute = new Date().getMinutes();
		let today = new Date().toISOString().substr(0,10);
		
		let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		let areaList = ["서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"];
		for(let i=0; i<=7 ; i++){
			let date = new Date();
			date.setDate(date.getDate()+i);
			date = date.toISOString().substr(0,10);
			let date_arr = date.split("-");
			
			$("#select_date").append("<li><div class='date' id="+date+"><div>"+date_arr[0]+"."+date_arr[1]+"</div><div align='center'>"+date_arr[2]+"</div></div></li>");
		}//for select_date 설정	
		
		for(let i in areaList){
			$("#select").append("<div class='selectArea' id="+areaList[i]+">"+areaList[i]+"</div>");
		}//for
		
		$.ajax({
			url:"/showinfo/cineList",
			data:"cine_area=서울",
			type:"get",
			dataType:"json"
		}).done(function(data){
				
			$("#cine_no").val(data[0].cine_no);
			let show_date = new Date().toISOString().substr(0,10);
			let cine_no = $("#cine_no").val();
			$("#msg").append(data[0].cine_name+" 상영시간표");
			
			if(data!=""){
				let list = "";
				
				for(let i in data){
					if((Number(i)+1)%4==1){
						list += "<li>";
					}
					list += "<div class='cineList' id="+data[i].cine_no+" title='"+data[i].cine_name+"'>"+data[i].cine_name+"</div>";
					if((Number(i)+1)%4==0){
						list += "</li>";
					}
				}//for
				
				$("#list").append(list);
				
				$.ajax({
					url:"/showinfo/showinfoCineList",
					data:{"show_date":show_date,"cine_no":cine_no},
					type:"get",
					dataType:"json"
				}).done(function(data){
					
					let mov_no = 0;
					let th_no = 0;
					let str="";
					let chk = 0;
					let result_chk=0;
						
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
								mov_no = data[i].mov_no;
								th_no = data[i].th_no;
								chk=1;
								str += "<div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>";
								str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
							}//if
							
							if(mov_no != data[i].mov_no){
								mov_no = data[i].mov_no;
								th_no = data[i].th_no;
								str += "<hr></div><div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>"
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
							}//if
							
							str += "<div class='show_info' id="+data[i].show_no+" title="+data[i].show_no+"><ul><li>"+show_h+":"+show_m+"</li><li>"+data[i].th_extra+"석</li></ul></div>";
						
							
						}//for
						
						$("#result").append(str);
						
					}else{
						$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
					}//if
					
					if(data!=""&&result_chk==0){
						$("#result").append("<h3>해당 날짜에 상영정보가 없습니다</h3>");
					}//if
					
				});//ajax	
				
			}else{
				$("#msg").empty();
				$("#list").append("<li><h3>해당 지역에 극장이 없습니다</h3></li>");
				$("#result").append("<h3>해당 지역에 극장이 없습니다</h3>");
			}//if
			
			
				
		});//ajax
		
		//여기까지 초기 설정
		
		$("#select").on("click",".selectArea",function(){
			
			let cine_area = $(this).attr("id");
			let show_date = new Date().toISOString().substr(0,10);
			
			$.ajax({
				url:"/showinfo/cineList",
				data:"cine_area="+cine_area,
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				$("#list").empty();
				$("#result").empty();
				
				if(data!=""){
					
					$("#msg").empty();
					$("#msg").append(data[0].cine_name+" 상영시간표");
					let list = "";
					$("#cine_no").val(data[0].cine_no);
					let cine_no = $("#cine_no").val();
					
					for(let i in data){
						if((Number(i)+1)%4==1){
							list += "<li>";
						}
						list += "<div class='cineList' id="+data[i].cine_no+" title='"+data[i].cine_name+"' >"+data[i].cine_name+"</div>";
						if((Number(i)+1)%4==0){
							list += "</li>";
						}
					}//for
					
					$("#list").append(list);
					
					$.ajax({
						url:"/showinfo/showinfoCineList",
						data:{"show_date":show_date,"cine_no":cine_no},
						type:"get",
						dataType:"json"
					}).done(function(data){
						
						let mov_no = 0;
						let th_no = 0;
						let str="";
						let chk = 0;
						let result_chk=0;
						
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
									mov_no = data[i].mov_no;
									th_no = data[i].th_no;
									str += "<div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>";
									str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
								}//if
								
								if(mov_no != data[i].mov_no){
									mov_no = data[i].mov_no;
									th_no = data[i].th_no;
									str += "<hr></div><div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>"
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
						
					});//ajax
					
				}else{
					$("#msg").empty();
					$("#list").append("<li><h3>해당 지역에 극장이 없습니다</h3></li>");
					$("#result").append("<h3>해당 지역에 극장이 없습니다</h3>");
				}//if
					
			});//ajax
			
		})//onclick selectArea
		
		$("#list").on("click",".cineList",function(){
			
			$("#cine_no").val($(this).attr("id"));
			
			let cine_no = $("#cine_no").val();
			let show_date = new Date().toISOString().substr(0,10);
			$("#msg").empty();
			$("#msg").append($(this).attr("title")+" 상영시간표");
			
			$.ajax({
				url:"/showinfo/showinfoCineList",
				data:{"show_date":show_date,"cine_no":cine_no},
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				$("#result").empty();
				let mov_no = 0;
				let th_no = 0;
				let str="";
				let chk = 0;
				let result_chk=0;
				
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
							mov_no = data[i].mov_no;
							th_no = data[i].th_no;
							str += "<div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>";
							str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
						}//if
						
						if(mov_no != data[i].mov_no){
							mov_no = data[i].mov_no;
							th_no = data[i].th_no;
							str += "<hr></div><div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>"
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
				
			});//ajax
			
		});// cineList click
		
		$(".date").click(function(){
			
			let cine_no = $("#cine_no").val();
			let show_date = $(this).attr("id");
			
			$.ajax({
				url:"/showinfo/showinfoCineList",
				data:{"show_date":show_date,"cine_no":cine_no},
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				$("#result").empty();
				let mov_no = 0;
				let th_no = 0;
				let str="";
				let chk = 0;
				let result_chk=0;
				
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
							mov_no = data[i].mov_no;
							th_no = data[i].th_no;
							str += "<div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>";
							str += "<div class='th_line'><div class='th_info'><ul><li>"+data[i].th_no+"관</li><li>총 "+(data[i].th_col*data[i].th_row)+"석</li></ul></div>";
						}//if
						
						if(mov_no != data[i].mov_no){
							mov_no = data[i].mov_no;
							th_no = data[i].th_no;
							str += "<hr></div><div class='mov_title'><h4>"+data[i].mov_title+"</h4></div><hr>"
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
				
			});//ajax	
			
		})//select_dateClick
		
		$("#result").on("click",".show_info",function(){
			location.href="../ticket/ticketing/"+$(this).attr("title");
		})//showinfoClick
		
	})//ready
	
</script>
<body>
<input type="hidden" id="cine_no">
<div id="container">
<div id="body">
<div id="selectMenu">
	<table id="menuTable">
		<tr>
			<td rowspan="2"><ul id="selectMovCine"><li><a href="showinfoMovList">영화별</a></li><li id="selected"><a href="showinfoCineList">극장별</a></li></ul></td>
			<td><div id="select"></div></td>
		</tr>
		<tr><td><ul id="list">
		</ul></td></tr>
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
</div>
</body>
</html>