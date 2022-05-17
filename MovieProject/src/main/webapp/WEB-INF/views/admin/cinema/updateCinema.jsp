<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>극장 정보 수정</title>
<style>
	table {widht:1000px; margin:40px auto;}
	.item {width:100px; height:30px; font-weight:bold; text-align:center; background-color:#A1BAF5; }
	.input{width:200px; height:30px;}
	#cine_name{width:150px;}
	#cine_area{width:160px;}
	table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
	  }
	  tr, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		$("#updateCinema").submit(function(){
			
			if($("#cine_name").val()==""){
				alert("이름을 입력해 주세요");
				return false;
			}
			
		})//submit
		
		let areaList = ["서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"];
		for(let i in areaList){
			$("#cine_area").append("<option value="+areaList[i]+" >"+areaList[i]+"</option>");
		}//cine_area 설정
		
	})//ready
	
</script>
</head>
<body>
	<div id="container">
		<div id="body">
			<form id="updateCinema" method="post">
				<input type="hidden" name="_method" value="put">
				<table>
					<tr>
						<td class="item">극장 이름</td><td class="input"><div align="center"><input id="cine_name" name="cine_name" value="${dto.cine_name}"></div></td>
					</tr>
					<tr>
						<td class="item">지역</td>
						<td class="imput"><div align="center"><select id="cine_area" name="cine_area"></select></div></td>
					</tr>
					<tr>
						<td colspan=2><div align="center"><input type="submit" value="수정"></div></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>