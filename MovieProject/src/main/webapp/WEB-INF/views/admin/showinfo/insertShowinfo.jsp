<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>상영정보추가</title>
</head>
<style>
	table {widht:1000px; margin:40px auto;}
	table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
	  }
	  tr, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }
	.item {width:100px; height:30px; font-weight:bold; text-align:center; background-color:#A1BAF5;}

	.select{width:150px;}
	
	#show_h,#show_m {widht:50px;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		let show_date = "";
		let today = new Date().toISOString().substring(0,10);
		show_date += "<input type='date' id='show_date' name='show_date' value="+today+" min="+today;
		today = new Date();
		today.setDate(today.getDate()+7);
		today = today.toISOString().substring(0,10);
		show_date += " max="+today+">";
		$("#date").append(show_date);
		//오늘부터 7일간만 선택가능하게 설정
		
		let areaList = ["서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"];
		for(let i in areaList){
			$("#cine_area").append("<option value="+areaList[i]+" >"+areaList[i]+"</option>");
		}//cine_area 설정
		
		$("#cine_area").change(function(){
			
			let cine_area = $(this).val();
			if(cine_area==0){
				$("#cinema").empty();
				$("#cinema").append("지역을 선택하세요");
				$("#theater").empty();
				$("#theater").append("극장을 선택하세요");
				return false;
			}//if
			$.ajax({
				url:"/showinfo/cineList",
				data:"cine_area="+cine_area,
				type:"get",
				dataType:"json"
			}).done(function(data){
				$("#cinema").empty();
				$("#theater").empty();
				let str = "<select class='select' id='cine_no' name='cine_no'><option value='0'>선택</option>";
				if(data!=""){
					for(let i in data){
						str += "<option value="+data[i].cine_no+">"+data[i].cine_name+"</option>";
						}//for
					$("#theater").append("극장을 선택하세요");
				}else{
					$("#theater").append("해당 지역에 극장이 없습니다");
				}//if
				str += "</select>";
			
				$("#cinema").append(str);
			});//ajax
			
		})//onchange cineList
		
		$("#insertShowinfo").on("change","#cine_no",function(){
			
			let cine_no = $(this).val();
			if(cine_no==0){
				$("#theater").empty();
				$("#theater").append("극장을 선택하세요");
				return false;
			}//if
			$.ajax({
				url:"/showinfo/thList",
				data:"cine_no="+cine_no,
				type:"get",
				dataType:"json"
			}).done(function(data){
				$("#theater").empty();
				let str = "<select id='th_info' class='select'>";
				if(data!=""){
				for(let i in data){
					str += "<option value="+data[i].th_no+","+data[i].th_col+","+data[i].th_row+">"+data[i].th_no+"</option>";
					}
				}else{
					str = "해당 극장에 상영관이 없습니다.";
				}
				str += "</select>";
			
				$("#theater").append(str);
			});//ajax
			
		})//onchange thList
		
		$("#insertShowinfo").submit(function(){
			
			if($("#cine_area").val()==0){
				alert("지역을 선택하세요");
				return false;
			}//if
			
			if($("#cine_no").val()==0){
				alert("극장을 선택하세요");
				return false;
			}//if
			
			let str = $("#th_info").val();
			let arr = str.split(",");
			let th_no = arr[0];
			let th_col = arr[1];
			let th_row = arr[2];
			let mov_title = $("#mov option:selected").text();
			let cine_name = $("#cine_no option:selected").text();
			
			str = "<input type='hidden' id='th_no' name='th_no' value="+th_no+">";
			str += "<input type='hidden' name='th_col' value="+th_col+">";
			str += "<input type='hidden' name='th_row' value="+th_row+">";
			str += "<input type='hidden' name='th_extra' value="+(th_row*th_col)+">";
			str += "<input type='hidden' id='mov_title' name='mov_title' value='"+mov_title+"'>";
			
			let show_no = $("#mov").val();
			arr = $("#show_date").val().split("-");
			show_no += arr[1]+arr[2];
			show_no += $("#show_h").val()+$("#show_m").val();
			show_no = Number(show_no);
			str += "<input type='hidden' name='show_no' value="+show_no+">";
			$("#insertShowinfo").append(str);
			
			let chk = confirm("상영정보는 수정/삭제가 불가능합니다\n상영정보를 추가하시겠습니까?\n지역 : "+$("#cine_area").val()+"\n극장명 : "+cine_name+
					"\n상영관번호 : "+$("#th_no").val()+"\n영화제목 : "+mov_title+"\n상영일자 : "+$("#show_date").val()+
					"\n상영시간 : "+$("#show_h").val()+" 시"+$("#show_m").val()+" 분");

			if(chk==false){
				return false;
			}//if
			
		})//submit
		
			
		
		
		for(let i = 1; i<=2 ;i++){
			$.ajax({
				url:"https://api.themoviedb.org/3/movie/popular?api_key="+api_key+"&language=ko-KR&page="+i,
				type:"get",
				dataType:"json"
			}).done(function(data){
				
				let str = "";
				
				for(let j in data.results){
					let mov_no = data.results[j].id;
					let mov_name = data.results[j].title;
					str += "<option value="+mov_no+">"+mov_name+"</option>";
				}
				
				$("#mov").append(str);
				
			});//ajax movList
		}//for	
			
	})//ready

</script>
<body>
<div id="container">
<div id="body">
<form id="insertShowinfo" method="post">
	<table>
		<tr>
			<td class="item">지역 : </td><td><select id="cine_area" class="select">
			<option value="0">지역</option></select></td>
		</tr>
		<tr>
			<td class="item">극장명 : </td><td id="cinema">지역을 선택하세요</td>
		</tr>
		<tr>
			<td class="item">상영관 : </td><td id="theater">극장을 선택하세요</td>
		</tr>
		<tr>
			<td class="item">영화 : </td><td><select id="mov" name="mov_no"></select></td>
		</tr>
		<tr>
			<td class="item">상영일 : </td><td id="date"></td>
		</tr>
		<tr>
			<td class="item">상영시간 : </td><td><select id="show_h" name="show_h"><c:forEach begin="0" end="23" step="1" var="i"><option value="${i}">${i}</option></c:forEach></select> 시
			<select id="show_m" name="show_m"><c:forEach begin="0" end="50" step="10" var="i"><option value="${i}">${i}</option></c:forEach></select> 분</td>
		</tr>
		<tr>
			<td colspan=2 align="center"><input type="submit" value="등록"></td>
		</tr>
	</table>
</form>

</div>

</div>
</body>
</html>                                                                              