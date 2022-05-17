<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>글쓰기</title>
<style>
	.item{background-color:#A1BAF5;width:100px; font-weight:bold; text-align:center;}
	table{border-coppapse:collapse; width:1400px;}
	table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
	  }
	  tr, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }
	#save{margin-top:10px;}
	table tr td .title {width:99%; height:20px; margin:auto; font-weight:bold; font-size:16px;}
	table tr td textarea {width:99%; height:500px; margin:auto; resize: none; overflow-x:hidden; overflow-y:scroll;font-weight:bold; font-size:16px; }
	.select{width:100px;}
	#writer{widht:100px; overflow:hidden;}
</style>
</head>
<body>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="user" />

<div id="container">


<div id="body" align="center">
<form method="post" id="updateform">
<input type="hidden" name="_method" value="put">
	<table border="1">
		<tr>
			<td class="item">제목</td>
			<td><input class="title" name="inqubd_title" value="${dto.inqubd_title}"></td>
		</tr>
		<tr>
			<td class="item">분류</td>
			<td>
				<select name="inqubd_div" class="select">
				 	<c:forEach items="${divi}" var="divi">
				 		<option value="${divi}" <c:if test="${divi==dto.inqubd_div}">selected</c:if>>${divi}</option>
				 	</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="item">극장</td>
			<td>
				<select name="inqubd_cinema"  class="select">
				 	<option value="전체">전체</option>
				 	<c:forEach items="${cineList}" var="list">
				 		<option value="${list.cine_name}" <c:if test="${list.cine_name==dto.inqubd_cinema}">selected</c:if>>${list.cine_name}</option>
				 	</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="item">작성자</td>
			<td><input name="inqubd_id" value="${user.username}" readonly/></td>
		</tr>
		<tr>
			<td class="item">내용</td>
			<td>
				<textarea name="inqubd_content" placeholder="내용을 입력해주세요">${dto.inqubd_content}</textarea>
			</td>
		</tr>
	</table>
	<div align="center"><input type="submit" id="save" value="수정"></div> 
</form>
</div>


</div>
</sec:authorize>
</body>
</html>