<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
	 table {widht:1000px; margin:40px auto;}
	.item {width:100px; height:30px; font-weight:bold; text-align:center; background-color:#A1BAF5; }
	.input{width:200px; height:30px;}
	.text{width:150px;}
	.select{width:160px;}
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
		
		$("#insertTheater").submit(function(){
			
			const reg = /^[0-9]*$/;
			
			if($("#th_no").val()==""){
				alert("상영관 번호를 입력해 주세요");
				return false;
			}//null chk
			
			if(!(reg.test($("#th_no").val()))){
				alert("숫자로 입력해 주세요");
				return false;
			}
			
		})//submit
		
	})//ready
	
</script>
<title>극장 추가</title>
</head>
<body>
	<div id="container">
		<div id="body">
			<form action="../insertTheater" id="insertTheater" method="post">
				<table>
					<tr>
						<td class="item">상영관 번호</td><td colspan="3" class="input"><input id="th_no" name="th_no" class="text"></td>
					</tr>
					<tr>
						<td class="item">상영관 열</td>
						<td class="input"><select name="th_col" class="select">
						<c:forEach begin="1" end="9" var="i">
							<option value="${i}">${i}</option>
						</c:forEach>
						</select></td>
						<td class="item">상영관 행</td>
						<td class="input"><select name=th_row  class="select">
						<c:forEach begin="1" end="9" var="i">
							<option value="${i}">${i}</option>
						</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td colspan=4><div align="center"><input type="submit" value="등록"></div></td>
					</tr>
				</table>
				<input name="cine_no" type="hidden" value="${cine_no}">
			</form>
		</div>
	</div>
</body>
</html>