<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html>

<head>

<!--  bList begin end count pageNum totalPages -->
<title>글 목록</title>
<style>
#center {   /*---처음부터 페이지 넘버 아래까지 / 검색창 위까지---*/
	width: 1400px;
	margin-left: auto;
	margin-right: auto;
}

h1 {		/*---게시글목록(타이핑)---*/
	text-align: left;
	color : #d717e8
}

table {    /*---표 부분---*/
	border: 1px solid black;
	width: 1400px;
	border-collapse: collapse;
	text-align: center;
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

th {	/*---표 제목부분(글번호/제목/공지/극장/등록일)---*/
	background-color: #8DA9EA;
	width: 150px;
	height: 1.5rem;
}

td {		/*---표 개개인 글 줄높이 설정---*/
	height: 2.5rem;
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

.container { /*---목록부터 표까지(위치 지정)---*/
	width: -800px;
	margin: 0 auto;
}

ul.tabs {	/*---목록전체(전체/공지사항/이벤트)---*/
	margin: 0px;
	padding: 0px;
	list-style: none;
}

ul.tabs li { /*---전체/공지사항/이벤트 각각---*/
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current { /*---전체/공지사항/이벤트 각각---*/
	background: #ededed;
	color: #222;
}

.tab-content { /*---공지사항,이벤트(2,3번 탭)---*/
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current {	/*---전체(1번 탭)--*/
	display: inherit;
}

#page {		/*--- 페이지숫자, 이전/다음---*/
	text-align: center;
	color : red;
}

.button  {  /*--검색버튼 설정--*/
	border: 1x solid #ff0080; /*---테두리 정의---*/
	background-Color: #ffe6f2; /*--백그라운드 정의---*/
	font: 12px 굴림; /*--폰트 정의---*/
	font-weight: bold; /*--폰트 굵기---*/
	color: #ff0080; /*--폰트 색깔---*/
	width: 130;
	height: 30; /*--버튼 크기---*/
}

#top{
padding : 10px;
}

</style>
</head>


<body>
	<div id = "top" align="right">
			<sec:authorize access="hasAuthority('ROLE_ADMIN')">
				<a href="/manbd/write" class="write">새글등록</a>
			</sec:authorize>
		</div>


	<div id="center">
		<h1 >게시글 목록</h1>
		<marquee loop="2" direction="left" bgcolor="gold" behavior="slide">영화관의
			주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.</marquee> 

		<c:if test="${count != 0 }"> <%--이거 위치 모르겠다.. --%>

			<div class="container">
				<ul class="tabs">
					<li class="tab-link current" data-tab="tab-1">전체</li>
					<li class="tab-link" data-tab="tab-2">공지사항</li>
					<li class="tab-link" data-tab="tab-3">이벤트</li>
				</ul>

				<br>
				
			<div id="tab-1" class="tab-content current">
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
						<td><a href="content/${managerbd.manbd_no}">${managerbd.manbd_title}</a></td>
						<td>${managerbd.manbd_div}</td>
						<td>${managerbd.manbd_cinema}</td>
						<td><fmt:formatDate value="${managerbd.manbd_regdate }"
						dateStyle="short" /></td>
							</tr>
				</c:forEach>
				</table>
			</div>

			<div id="tab-2" class="tab-content">
				<table>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>공지사항/이벤트</th>
						<th>극장</th>
						<th>등록일</th>
					</tr>
					
				<c:forEach items="${nList}" var="notice">
					<tr>
						<td>${notice.manbd_no}</td>
						<td><a href="content/${notice.manbd_no}">${notice.manbd_title}</a></td>
						<td>${notice.manbd_div}</td>
						<td>${notice.manbd_cinema}</td>
						<td><fmt:formatDate value="${notice.manbd_regdate }"
						dateStyle="short" /></td>
					</tr>
				</c:forEach>
				</table>
			</div>

			<div id="tab-3" class="tab-content">
				<table>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>공지사항/이벤트</th>
						<th>극장</th>
						<th>등록일</th>
					</tr>
					
				<c:forEach items="${eList}" var="event">
					<tr>
						<td>${event.manbd_no}</td>
						<td><a href="content/${event.manbd_no}">${event.manbd_title}</a></td>
						<td>${event.manbd_div}</td>
						<td>${event.manbd_cinema}</td>
						<td><fmt:formatDate value="${event.manbd_regdate }"
						dateStyle="short" /></td>
					</tr>
				</c:forEach>
				</table>
			</div>
	</div><%--class="container" 끝! --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
					<script>
						$(document).ready(function() {

							$('ul.tabs li').click(function() {
								var tab_id = $(this).attr('data-tab');

								$('ul.tabs li').removeClass('current');
								$('.tab-content').removeClass('current');

								$(this).addClass('current');
								$("#" + tab_id).addClass('current');
							})

						})
					</script>

	<br>
				
				<div id="page">
					<c:if test="${begin > pageNum }">
						<a href="list?p=${begin-1 }">[이전]</a>
					</c:if>
					<c:forEach begin="${begin }" end="${end}" var="i">
						<a href="list?p=${i}">${i}</a>
					</c:forEach>
					<c:if test="${end < totalPages }">
				f test="${count == 0 }	<a href="list?p=${end+1}">[다음]</a>
					</c:if>
				</div>
		</c:if>
<c:if test="${count == 0 }">
아직 입력한 글이 없습니다.
</c:if>
	</div> <%-- id="center 끝! --%>
	
	<br>
	
	<div id="search" align="center">
		<form action="search">
			<select name="searchn">
				<option value="0">제목</option>
				<option value="1">내용</option>
				<option value="2">극장</option>
			</select> 
			<input type="text" name="search" size="15" maxlength="50" /> 
			<input type="submit" value="검색" class="button" />
		</form>
	</div>

</body>
</html>