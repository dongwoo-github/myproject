<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<style>
	#body {
	width: 1400px;
	margin-left: auto;
	margin-right: auto;
}
#content{
width:100%;
}

#content textarea{
width:99%;
height:100px;
overflow-x:hidden;
overflow-y:scroll;
}

.item{
width:10%;
background-color:#A1BAF5;
font-weight:bold;
}

#btnLine{
	margin-top:10px;
	margin-bottom:10px;
}

#listTable * {text-align:center;}

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
<link href="/css/pager.css" rel="stylesheet">
<title>글 상세보기</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		$("#write").click(function(){
			
			location.href="../insert";
			
		})//click
		
		$("#updateBtn").click(function(){
			let page=${nowPage};
			let inqubd_no = ${dto.inqubd_no};
			location.href="../update/"+inqubd_no+"/"+page;
		})//click
		
		$("#delBtn").click(function(){
			let inqubd_no = ${dto.inqubd_no};
			let select = confirm("정말 삭제하시겠습니까?");
			
			if(select==true){
				$.ajax({
					url:"/inqubd/delete",
					data:"inqubd_no="+inqubd_no,
					method:"delete"
				}).done(function(){
					alert("삭제가 완료되었습니다.");
					location.href="/inqubd/list";
				})
			}
		})//click
		
		$("#input").click(function(){
			let inqubd_no = ${dto.inqubd_no};
			let inqubd_comm = $("#inqubd_comm").val();
			
			$.ajax({
				url:"/inqubd/comm",
				data:{
					"inqubd_no":inqubd_no,
					"inqubd_comm":inqubd_comm
					},
				method:"put"
			}).done(function(){
				location.reload();
			}) 
			
		})//click
		
		$("#delComm").click(function(){
			let inqubd_no = ${dto.inqubd_no};
			let select = confirm("정말 삭제하시겠습니까?");
			if(select==true){
				$.ajax({
					url:"/inqubd/delComm",
					data:"inqubd_no="+inqubd_no,
					method:"put"
				}).done(function(){
					alert("삭제가 완료되었습니다.")
					location.reload();
				})
			}
		})//click
		
	})//ready
		
</script>
<body>
<div id="container">

<div id="body">
		<table id="content" border="1">
			<tr><td class="item">제목</td><td colspan="3">${dto.inqubd_title}</td></tr>
			<tr><td class="item">구분/극장</td><td>${dto.inqubd_div} / ${dto.inqubd_cinema}</td>
			<td class="item">등록일</td><td><fmt:formatDate value="${dto.inqubd_regdate}" pattern="yy/MM/dd"/></td></tr>
			<tr><td class="item">내용</td><td colspan="3">${dto.inqubd_content}</td></tr>
			<sec:authorize access="hasAuthority('ROLE_ADMIN')">
				<c:if test="${dto.inqubd_comm==null}">
					<tr><td class="item">답변</td><td colspan="3"><textarea id="inqubd_comm" name="inqubd_comm"></textarea></td></tr>
					<tr><td colspan="4"><button id="input">등록</button></td></tr>
				</c:if>
				<c:if test="${dto.inqubd_comm!=null}">
					<tr><td class="item">답변</td><td colspan="3">${dto.inqubd_comm}</td></tr>
					<tr><td colspan="4"><div align="center"><button id="delComm">답변 삭제</button></div></td></tr>
				</c:if>
			</sec:authorize>
			<sec:authorize access="hasAuthority('ROLE_MEMBER')">
			<sec:authentication property="principal" var="user" />
			<c:if test="${dto.inqubd_comm!=null}">
				<tr><td class="item">답변</td><td colspan="3">${dto.inqubd_comm}</td></tr>
				<tr><td class="item">답변등록일</td><td colspan="3"><fmt:formatDate value="${dto.inqubd_comm_reg}" pattern="yy/MM/dd"/></td>
			</c:if>
			</sec:authorize>
		</table>
		<sec:authorize access="hasAuthority('ROLE_ADMIN')">
			<div id="btnLine" align="right"><button id="delBtn">글 삭제</button></div>
		</sec:authorize>
		<sec:authorize access="hasAuthority('ROLE_MEMBER')">
			<sec:authentication property="principal" var="user" />
				<c:if test="${user.username==dto.inqubd_id}">
					<div id="btnLine" align="right"><button id="updateBtn">글 수정</button> <button id="delBtn">글 삭제</button></div>
				</c:if>
		</sec:authorize>
		
		<!-- content -->
		
		<h1>문의사항</h1>
		
			<table id="listTable">
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
						<td class="title"><a href ="../content/${list.inqubd_no}?p=${nowPage}">${list.inqubd_title}</a></td>
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
			<sec:authorize access="hasAuthority('ROLE_MEMBER')">
				<div align="right">
					<button>내가 쓴 문의 글 조회</button>
					<button id="write">새글 등록</button>
				</div>
			</sec:authorize>
			<!-- list -->
	</div>
</div>
</body>
</html>