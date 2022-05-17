<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<title>글 상세보기</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;800&family=Roboto+Serif:ital@1&family=Roboto:wght@700&display=swap" rel="stylesheet">
<style>
.blue{
width:10%;
background-color:#A1BAF5;
font-weight:bold;
}
table {
 	border-collapse : collapse; width: 100%; text-align:center;}

*{
	font-family: 'Nanum Gothic', sans-serif;	
}

.item{ margin-right : 10px;}

tr, td {
		padding: 10px;
	}

#user{font-weight:bold;
	font-size: 20px;
}
#date{font-size: 15px;
	  color: #A0A0A0;}

.contents{
	margin:10px;
}
.comment{margin:10px;}
.mov_title{font-weight:bold;}
#content{margin-left:10px;}

</style>
</head>
<body>


<div id="container" >
<div class="contents">
	<table border="1">
		<tr>
			<td class="blue">제목</td>
			<td>${dto.movbd_title}</td>
		</tr>
		<tr>
			<td class="blue">작성자</td>
			<td>${dto.movbd_id}</td>
		</tr>
		<tr>
			<td class="blue">관람 영화</td>
			<td class="mov_title">${dto.movbd_mov}</td>
		</tr>
		<tr>
			<td class="blue">내용</td>
			<td>${dto.movbd_content}</td>
		</tr>
		<tr>
			<td class="blue">등록일</td>
			<td><fmt:formatDate value="${dto.movbd_regdate }" pattern="yy-MM-dd" dateStyle="long"/></td>
		<tr>
			<td class="blue">조회수</td>
			<td>${dto.movbd_readcnt}</td>
		</tr>
		</table>

<div class="item" align="right">	
		<c:if test="${ user.mem_id == dto.movbd_id }">
		<a href="/movbd/update/${dto.movbd_no}">글 수정 </a> 
		<a id="${dto.movbd_no}" href="#">글 삭제</a>
		</c:if>
		<a href="../list">목록 이동</a> 
		
</div>		
</div>	

</div>	
<!--  cList -->

<div id="container2">
<div class="comment">
	<c:forEach items="${cList}" var="comm">
		<div id="user">${comm.comm_id}</div><div id="date"><fmt:formatDate value="${comm.comm_regdate }" pattern="yy/MM/dd" dateStyle="short"/></div>
		<div>${comm.comm_content} 
		<c:if test="${comm.comm_id == user.mem_id }">
		<button class="dbtn" id="${comm.comm_no}">삭제</button>
		<hr>
		</c:if>
		</div>

	</c:forEach>
	</div>
</div>
			
	<input name="content" id="content"><button id="add">등록</button><jsp:include page="like.jsp"/>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$("a[id]").click(function(){
			let d = confirm("정말 삭제하시겠습니까?");
			//alert(typeof(d))
			 if(eval(d)){
			let movbd_no = $(this).attr("id");
			$.ajax({url:"/movbd/delete", data:"movbd_no="+movbd_no, method:"delete"}
			).done(function(){
				location.href="/movbd/list";
			})
			}
			return false;
		})//click
	
		$("#add").click(function(){
			let id = '${user.mem_id}';
			let content = $("#content").val();
			let movbd_no = ${dto.movbd_no};
			
			$.ajax({url:"/comm/insert",
					data:"movbd_no="+movbd_no+"&comm_id="+id+"&comm_content="+content,
					method:"get"
			}).done(function(){
					location.reload();		
				});
			
		})//click
		$(".dbtn").click(function(){
			let comm_no = $(this).attr("id");
			$.ajax({url:"/comm/delete/"+comm_no,
				method:"get"
		}).done(function(){
				location.reload();		
			});
			
		})//click
	})//ready

</script>

</body>
</html>