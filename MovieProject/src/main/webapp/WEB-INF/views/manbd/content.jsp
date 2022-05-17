<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<title>글 세부내용</title>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
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
h2 {		/*---게시글목록(타이핑)---*/
	text-align: left;
	font : 15px;
}

table {    /*---표 부분---*/
	border: 1px solid black;
	width: 1400px;
	border-collapse: collapse;
	text-align: center;
	margin: 10px auto;
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
#main{
  
}

</style>	
<body>
	<div id = "top" align="right" > 
		<sec:authorize access="hasAuthority('ROLE_ADMIN')">
		        <a href="/manbd/update/${dto.manbd_no}">글 수정</a>
		        <a id="${dto.manbd_no}" href="#">글 삭제</a>
		      </sec:authorize>
		      
		      <a href="/../manbd/list">게시글로 이동</a>
	</div>
	
<h1>공지사항</h1>
<h2>${dto.manbd_title}</h2>
<div id = "main">
	<br>
	<hr> 
	${dto.manbd_div} ${dto.manbd_cinema} 
	<hr> 
	등록일 <fmt:formatDate value="${dto.manbd_regdate}" />
	<hr>
	<br>
	 ${dto.manbd_content}
	<br>
	 <hr>
	</div>
	
	
	
	<c:if test="${count != 0 }">
		<table>
			<br>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>등록일</th>
					<th>공지사항/이벤트</th>
					<th>극장</th>
				</tr>
				<c:forEach items="${bList}" var="managerbd">
					<tr>
						<td>${managerbd.manbd_no}</td>
						<td><a href ="${managerbd.manbd_no}">${managerbd.manbd_title}</a></td>
						<td><fmt:formatDate value="${managerbd.manbd_regdate }" dateStyle="short"/></td>
						<td>${managerbd.manbd_div}</td>
						<td>${managerbd.manbd_cinema}</td>
					</tr>
				</c:forEach>
		
		</table>


		<div id="page">
				<c:if test="${begin > pageNum }">
					<a href="?p=${begin-1 }">[이전]</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="?p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="?p=${end+1}">[다음]</a>
				</c:if>
			</div>
	</c:if>
		<c:if test="${count == 0 }">
	아직 입력한 글이 없습니다.
		</c:if>
</div>	


<div id="search" align="center" >
<form action="/manbd/search">
<select name="searchn">
<option value="0">제목</option>
<option value="1">내용</option>
<option value="2">극장</option>
</select>
<input type="text" name="search" size="15" maxlength="50" /> 
<input type="submit" value="검색" class="button"/>
</form>	
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	$(function(){
		$("a[id]").click(function(){
			let no = $(this).attr("id");
			$.ajax({url:"/manbd/delete", data:"no="+no, method:"delete"}
			).done(function(){
				location.href="/manbd/list";
			})
			return false;
		})//click
	})//ready

</script>
<!--  cList -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$("a[id]").click(function(){
			let no = $(this).attr("id");
			$.ajax({url:"/manbd/delete", data:"no="+no, method:"delete"}
			).done(function(){
				location.href="/manbd/list";
			})
			return false;
		})//click

			
		})//click
	})//ready

</script>
</body>
</html>