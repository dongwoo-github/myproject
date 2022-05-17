<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!--  bList begin end count pageNum totalPages -->
<title>내 활동내역</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;800&family=Roboto+Serif:ital@1&family=Roboto:wght@700&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>

</head>
<body>
	<nav>
		<!-- 내가쓴글 -->
		<div id="container-fluid">
			<div id="row">
				<h1>
					<b>내가쓴글</b>
				</h1>
			</div>
			<c:if test="${count != 0 }">
				<table class="table table-hover">
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<c:forEach items="${List}" var="dto">
						<tr>
							<td>${dto.movbd_no}</td>
							<td><a href="../movbd/content/${dto.movbd_no}">${dto.movbd_title}</a></td>
							<td>${dto.movbd_id}</td>
							<td><fmt:formatDate value="${dto.movbd_regdate}"
									dateStyle="short" /></td>
							<td>${dto.movbd_readcnt}</td>
						</tr>
					</c:forEach>
				</table>
				<div id="page" align="center">
					<c:if test="${begin > pageNum }">
						<a href="list?p=${begin-1 }">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="list?p=${i}">| ${i} |</a>
					</c:forEach>
					<c:if test="${count == 0 }">
					아직 입력한 글이 없습니다.
					</c:if>
				</div>
			</c:if>
		</div>
		<!-- 내가쓴 문의사항 -->
		<div id="container-fluid">
			<div id="row">
				<h1>
					<b>내가쓴 문의사항</b>
				</h1>
			</div>
			<c:if test="${count != 0 }">
				<table class="table table-hover">
					<tr>
						<th>글 번호</th>
						<th>제목</th>
						<th>분류</th>
						<th>문의한 극장</th>
						<th>작성일</th>
					</tr>
					<c:forEach items="${IList}" var="dto">
						<tr>
							<td>${dto.inqubd_no}</td>
							<td><a href="../inqubd/list">${dto.inqubd_title}</a></td>
							<td>${dto.inqubd_div}</td>
							<td>${dto.inqubd_cinema}</td>
							<td><fmt:formatDate value="${dto.inqubd_regdate}"
									dateStyle="short" /></td>
						</tr>
					</c:forEach>
				</table>
				<div id="page" align="center">
					<c:if test="${begin > pageNum }">
						<a href="list?p=${begin-1 }">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="list?p=${i}">| ${i} |</a>
					</c:forEach>
					<c:if test="${count == 0 }">
					아직 입력한 글이 없습니다.
					</c:if>
				</div>
			</c:if>
		</div>


                  <!-- 내가쓴 댓글 -->
		<div id="container-fluid">
			<div id="row">
				<h1>
					<b>내가쓴 댓글</b>
				</h1>
			</div>
			<c:if test="${count != 0 }">
				<table class="table table-hover">
					<tr>
						<th>댓글번호</th>
						<th>댓글내용</th>
						<th>작성일</th>
					</tr>
					<c:forEach items="${CList}" var="dto">
						<tr>
							<td>${dto.comm_no}</td>
							<td>${dto.comm_content}"</td>
							<td><fmt:formatDate value="${dto.comm_regdate}"
									dateStyle="short" /></td>
						</tr>
					</c:forEach>
				</table>
				<div id="page" align="center">
					<c:if test="${begin > pageNum }">
						<a href="list?p=${begin-1 }">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="list?p=${i}">| ${i} |</a>
					</c:forEach>
					<c:if test="${count == 0 }">
					아직 입력한 글이 없습니다.
					</c:if>
				</div>
			</c:if>


		</div>
	</nav>
</body>
</html>