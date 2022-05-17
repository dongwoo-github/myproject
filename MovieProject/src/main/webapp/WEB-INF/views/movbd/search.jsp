<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<title>검색 글 목록</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;800&family=Roboto+Serif:ital@1&family=Roboto:wght@700&display=swap" rel="stylesheet">
<style>

*{
	font-family: 'Nanum Gothic', sans-serif;
	
}
table *{text-align:center;}
table {width: 100%;}
h1 {font-weight:bold; margin-left:10px; margin-bottom:30px;}
table {
    width: 100%;
    border-top: 1px solid #C0C0C0;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #C0C0C0;
    padding: 10px;
  }
  .new{font-size:16px; font-weight:bold;}
  
  #center, .new {
  	margin-left: 10px;
	margin-right: 10px;
  }
  
  .menu {background-color:#A1BAF5;}

</style>
</head>
<body>
	<div id="center">
		<h1>${search}(으)로 검색한 결과입니다.</h1>
		


		<c:if test="${count != 0 }">
			<table>
				<tr class="menu">
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${bList}" var="movie">
					<tr>
						<td><a href ="content/${movie.movbd_no}">${movie.movbd_title}</a></td>
						<td>${movie.movbd_id }</td>
						<td><fmt:formatDate value="${movie.movbd_regdate }" dateStyle="short"/> </td>
						<td>${movie.movbd_readcnt }</td>
					</tr>
				</c:forEach>
			</table>
			<div id="page" align="center">
				<c:if test="${begin > pageNum }">
					<a href="search?p=${begin-1}&search=${search}&searchn=${searchn}">[이전]</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="search?p=${i}&search=${search}&searchn=${searchn}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="search?p=${end+1}&search=${search}&searchn=${searchn}">[다음]</a>
				</c:if>
			</div>

		</c:if>
		<c:if test="${count == 0 }">
	검색 조건에 맞는 글이 없습니다.
</c:if>

		<div class="new" align="right">
			<a href="list">새글 등록</a>
		</div>
		
<div id="search" align="center">
<form action="search">
<select name="searchn">
<option value="0">글제목</option>
<option value="1">작성자</option>
</select>
<input type="text" name="search" size="15" maxlength="50"
placeholder="키워드를 입력해주세요." style="width: 300px;" /> 
<input type="submit" value="검색" />
</form>	
	</div>
	</div>
</body>
</html>
