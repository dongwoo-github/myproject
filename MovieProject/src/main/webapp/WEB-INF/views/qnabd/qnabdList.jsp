<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<!--  bList begin end count pageNum totalPages -->
<title>자주 묻는 질문</title>

<style>
#body {
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

#page {
	text-align: center;
}

ul li {
	display: inline-block;
}

.qnabdList strong {
	font-size: 30px;
	font-weight: bold;
}

.qnabdList span {
	font-size: 20px;
	font-weight: bold;
}

.qnabdList button {
	position: relative;
	font-weight: bold;
}

details {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: .5em .5em 0;
	margin-bottom: 1em;
}

summary {
	border-radius: 10px;
	font-weight: bold;
	margin: -.5em -.5em 0;
	padding: .5em;
	cursor: pointer;
	background-color: #E6EFFE;
}

details[open] {
	padding: .5em;
}

details[open] summary {
	border-bottom: 1px solid #aaa;
	margin-bottom: .5em;
	background-color: #fff0c0;
	border-radius: 10px 10px 0 0;
}

summary::marker {
	display: none;
	content: "";
}

#qnainsert {
	font-weight: bold;
}
</style>
</head>
<link href="/css/pager.css" rel="stylesheet">
<link href="/css/serviceMenu.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {

		$(".qnabdList .a").hide();

		$(".qnabdList .q").click(function() {
			let no = $(this).attr("title");
			$("[title='" + no + "'] .a").toggle();
		})//click

		$(".qnadelete").click(function() {
			let no = $(this).attr("title");
			let select = confirm("정말 삭제하시겠습니까?");

			if (select == true) {
				$.ajax({
					url : "/qnabd/delete",
					data : "no=" + no,
					method : "delete"
				}).done(function() {
					alert("삭제가 완료되었습니다.")
					location.reload();
				})//ajax
			}
		})//click

		$(".qnaupdate").click(function() {
			let qnabd_no = $(this).attr("title");
			location.href = "update/" + qnabd_no;
		})//click

		$("#qnainsert").click(function() {

			location.href = "insert";

		})//click

		let q = document.getElementsByClassName("q");

	})//ready
</script>
<body>
	<div id="container">

		<jsp:include page="/header" flush="true" />

		<div id="body">
			<div id="serviceMenu" align="center">
				<div class="selected qna">
					<a href="/qnabd/list">자주 묻는 질문</a>
				</div>
				<div class="inqubd">
					<a href="/inqubd/list">문의사항</a>
				</div>
			</div>
			<div id="qnaboard">
				<c:forEach items="${list}" var="list">
					<details class="qnabdList" title="${list.qnabd_no}">
						<summary class="q" title="${list.qnabd_no}">
							<strong>Q? </strong><span>${list.qnabd_q}</span>
							<sec:authorize access="hasAuthority('ROLE_ADMIN')">
								<button class="qnaupdate" title="${list.qnabd_no}">수정</button>
								<button class="qnadelete" title="${list.qnabd_no}">삭제</button>
							</sec:authorize>
						</summary>
						<div class="a">
							<strong> A : </strong><span>${list.qnabd_a}</span>
						</div>
					</details>
				</c:forEach>
			</div>
			<div id="page" align="center" class="pagination-wrapper">
				<div class="pagination">
					<c:if test="${begin > pageNum}">
						<a class="prev page-numbers" href="?p=${begin-1}">이전</a>
					</c:if>
					<c:forEach begin="${begin}" end="${end}" var="i">
						<c:if test="${page==i}">
							<a aria-current="page" class="page-numbers current"
								href="?p=${i}">${i}</a>
						</c:if>
						<c:if test="${page!=i}">
							<a class="page-numbers" href="?p=${i}">${i}</a>
						</c:if>
					</c:forEach>
					<c:if test="${end < totalPages }">
						<a class="next page-numbers" href="?p=${end+1}">다음</a>
					</c:if>
				</div>
			</div>
			<sec:authorize access="hasAuthority('ROLE_ADMIN')">
				<div align="right">
					<button id="qnainsert">글 작성</button>
				</div>
			</sec:authorize>
		</div>

		<jsp:include page="/footer" flush="true" />

	</div>
</body>
</html>