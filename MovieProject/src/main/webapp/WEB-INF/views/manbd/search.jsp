<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>검색 글 목록</title>
<style>
#center {
	
	width: 1400px;
	margin-left: auto;
	margin-right: auto;
}

table {    /*---표 부분---*/
	border: 1px solid black;
	width: 1400px;
	border-collapse: collapse;
	text-align: center;
}

th {	/*---표 제목부분(글번호/제목/공지/극장/등록일)---*/
	background-color: #8DA9EA;
	width: 150px;
	height: 1.5rem;
}

tr {   /*---표 전체(디자인 설정)---*/
	padding: 60px;
	max-width: 650px;
	background: #80d5a6;
	box-shadow: 0 0 0 0px #226741, 0 0 0 0px #fff, inset 0 0 0 0px #226741,
		0 5px 10px 0px rgba(0, 0, 0, 0.5), inset 0 0 0 0px #fff, inset 0 0
		100vw 100vw beige;
	font-family: Marcellus, serif;
	font-size: 15px;
	text-align: center;
}

td>a { /*--제목(링크)부분 밑줄제거, 글자 색상--*/
	text-decoration: none;
	color: black;
}

td>a:hover { /*--제목(링크)부분 마우스 올릴시(hover) 밑줄표시--*/
	text-decoration: underline;
}

a {  /*---새글등록(주소 이동하는 애들)---*/
	margin: 10px auto;
	color : #2fa4c2;
}
#top{
padding : 10px;
}
#page {
	text-align: center;
}
</style>
</head>
<body>
		<div id = "top" align="right">
			<a href="/mainpage">메인페이지</a> <a href="list">게시글로 이동</a> 
			<sec:authorize access="hasAuthority('ROLE_ADMIN')">
		        <a href="/manbd/write">새글등록</a>
		      </sec:authorize>
		</div>


	<div id="center">
		<h1>${search}로 검색한 결과입니다. <c:if test="${searchn==0}">(제목)  </c:if>
		<c:if test="${searchn==1}">(내용)  </c:if>
		<c:if test="${searchn==2}">(극장)  </c:if>
		</h1>

		<c:if test="${count != 0 }">
			<table>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>공지사항/이벤트</th>
					<th>극장</th>
					<th>등록일</th>
				</tr>
				<c:forEach items="${bList}" var="managerbd">
					<tr>
						<td>${managerbd.manbd_no}</td>
						<td><a href ="content/${managerbd.manbd_no}">${managerbd.manbd_title}</a></td>
						<td>${managerbd.manbd_div}</td>
						<td>${managerbd.manbd_cinema}</td>
						<td><fmt:formatDate value="${managerbd.manbd_regdate }" dateStyle="short"/> </td>
					</tr>
				</c:forEach>
			</table>
			<div id="page">
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
<div id="search" align="center">
<form action="search">
<select name="searchn">
<option value="0">제목</option>
<option value="1">내용</option>
<option value="2">극장</option>
</select>
<input type="text" name="search" size="15" maxlength="50" /> 
<input type="submit" value="검색" />
</form>	
	</div>
	</div>
</body>
</html>

