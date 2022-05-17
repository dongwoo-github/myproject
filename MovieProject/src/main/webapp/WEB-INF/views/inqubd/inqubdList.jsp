<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<!--  bList begin end count pageNum totalPages -->
<title>글 목록</title>
<style>
#body {
	width: 1400px;
	margin-left: auto;
	margin-right: auto;
}

table * {text-align:center;}

.no{width:100px;}
.div{width:100px;}
.cine{width:100px;}
.title{width:750px; overflow:hidden;}
.id{width:100px;overflow:hidden;}
.date{width:100px;}
.a{width:100px;}

.menuLine {background-color:#A1BAF5;}

 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}

table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }

</style>
<link href="/css/serviceMenu.css" rel="stylesheet">
<link href="/css/pager.css" rel="stylesheet">
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	$(function(){
		
		$("#write").click(function(){
			
			location.href="insert";
			
		})//click
		
	})//ready
	
	$(function(){
		
		$("#myinqu").click(function(){
			
			location.href="/../../myboardList";
			
		})//click
		
	})//ready	
	
	
</script>
<body>
	<div id="body">
		<div id="serviceMenu" align="center">
		<div class="qna"><a href="/qnabd/list">자주 묻는 질문</a>
		</div><div class="selected inqubd"><a href="/inqubd/list">문의사항</a>
		</div></div>
		<c:if test="${count != 0 }">
			<table>
				<tr class="menuLine">
					<th class="no">글번호</th>
					<th class="div">구분</th>
					<th class="cine">극장</th>
					<th class="title">제목</th>
					<th class="id">작성자</th>
					<th class="date">등록일</th>
					<th class="a">답변여부</th>
				</tr>
				<c:forEach items="${list}" var="list">
					<tr class="line">
						<td class="no">${list.inqubd_no}</td>
						<td class="div">${list.inqubd_div}</td>
						<td class="cine">${list.inqubd_cinema}</td>
						<td class="title"><a href ="content/${list.inqubd_no}?p=${nowPage}">${list.inqubd_title}</a></td>
						<td class="id">${list.inqubd_id}</td>
						<td class="date"><fmt:formatDate value="${list.inqubd_regdate}" pattern="yy/MM/dd"/> </td>
						<td class="a">${list.inqubd_a}</td>
					</tr>
				</c:forEach>
			</table>
			<div id="page" align="center" class="pagination-wrapper">
			<div class="pagination">
				<c:if test="${begin > pageNum}">
					<a class="prev page-numbers" href="?p=${begin-1}">이전</a>
				</c:if>
				<c:forEach begin="${begin}" end="${end}" var="i">
					<c:if test="${nowPage==i}"><a aria-current="page" class="page-numbers current" href="?p=${i}">${i}</a></c:if>
					<c:if test="${nowPage!=i}"><a class="page-numbers" href="?p=${i}">${i}</a></c:if>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a class="next page-numbers" href="?p=${end+1}">다음</a>
				</c:if>
			</div>
			</div>
			<div align="right">
				<sec:authorize access="hasAuthority('ROLE_MEMBER')">
						<button id="myinqu">내가 쓴 문의 글 조회</button>
						<button id="write">새 글 등록</button>
				</sec:authorize>
			</div>
		</c:if>
		<c:if test="${count == 0 }">
			아직 입력한 글이 없습니다.
			<sec:authorize access="hasAuthority('ROLE_MEMBER')">
				<button id="write">새글 등록</button>
			</sec:authorize>
		</c:if>
	</div>
</body>
</html>