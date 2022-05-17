<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>예매 목록</title>
<link href="/css/mytk.css" rel="stylesheet">
</head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<style>
</style>
<body>
	<nav>
	<div id="container-fluid">
		<div id="row">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="user" />
				<c:if test="${dto.tk_id==dto.tk_id}">
					<tbody>
						<table class="table table-hover" "table table-sm">
								<tr>
									<th>티켓번호</th>
									<th>영화제목</th>
									<th>영화관</th>
									<th>상영관</th>
									<th>상영시간</th>
									<th>좌석</th>
									<th>성인</th>
									<th>청소년</th>
									<th>구매금액</th>
									<th>결제날짜</th>
								</tr>
								<c:forEach items="${list}" var="dto">
									<tr>
										<td><a href="../../ticket/ticketPage/${dto.tk_no}">${dto.tk_no}</a></td>
										<td>${dto.mov_title}</td>
										<td>${dto.cine_name}</td>
										<td>${dto.th_no}</td>
										<td><fmt:formatDate pattern="yy-MM-dd"
												value="${dto.show_date}" /></td>
										<td>${dto.tk_seat}</td>
										<td>${dto.tk_a}</td>
										<td>${dto.tk_c}</td>
										<td>${dto.tk_pay}</td>
										<td><fmt:formatDate pattern="yy-MM-dd"
												value="${dto.tk_pay_time}" /></td>
									</tr>
								</c:forEach>
								
						</table>
					<tbody>
				</c:if>
			</sec:authorize>
		</div>
	</div>
	</nav>
</body>
</html>