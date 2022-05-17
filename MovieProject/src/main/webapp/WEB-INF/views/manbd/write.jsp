<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>글쓰기</title>
<style>
	.pink{background-color: #8DA9EA; width: 34px; height: 1.5rem;}
	
	table{border-collapse : collapse; width: 1450px;
	margin-left: auto;
	margin-right: auto;
	border-right:1px solid white;
	}
	
	#save {  /*--검색버튼 설정--*/
	border: 1x solid #ff0080; /*---테두리 정의---*/
	background-Color: #ffe6f2; /*--백그라운드 정의---*/
	font: 15px 굴림; /*--폰트 정의---*/
	font-weight: bold; /*--폰트 굵기---*/
	color: #ff0080; /*--폰트 색깔---*/
	width: 130;
	height: 30; /*--버튼 크기---*/
	}
	
</style>
</head>
<body>
<h1>공지사항/이벤트 (글작성)</h1>
<form method="post" id="writeform">
	<table border="1">
		<tr>  
			<td class="pink">제목</td>
			<td><input name="manbd_title"/></td>
		</tr>
		
		<tr>
			<td class="pink">구분</td>
			<td><select name="manbd_div">
				<option value="이벤트">이벤트</option>
				<option value="공지사항">공지사항</option>
			</select></td>
		</tr>
		
		<tr>
			<td class="pink">극장</td>
			<td><select name="manbd_cinema">
				<option value="전체">전체</option>
			<c:forEach items="${cList}" var="cinema">
				<option value="${cinema.cine_name}">${cinema.cine_name}</option>
			</c:forEach>		
			</select></td>
		</tr>
		
		<tr>
			<td class="pink">내용</td>
			<td>
        	<textarea id="test" name="manbd_content"
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"
                  style="width: 100%"></textarea>
     		</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" id="save" value="새글 등록"> 
			</td>
		</tr>
	</table>

</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
</script>
</body>
</html>	