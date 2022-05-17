<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>header</title>
</head>
<body>
<div id="header">
		<div id="loginMenu" align="right">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="user" />
				<span>${user.username} 님</span>
				<a href="/logout">로그아웃</a>
			</sec:authorize>
			 <sec:authorize access="isAnonymous()">
			 	<a href="/login">로그인</a>
			 	<a href="/insertMember">회원가입</a>
			 </sec:authorize>
		</div>
		<div id="logoImg" align="center">
			<img id="logo" onclick="gotoMain()" src="/images/logo.JPG">
		</div>
		<nav class="menu">
			<ol>
		      <li class="menu-item">
		        <a href="/movie/boxOffice">영화</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/movie/boxOffice">박스오피스</a></li>
		          <li class="menu-item"><a href="/movie/upComming">최신개봉영화</a></li>
		        </ol>
		      </li>
		      <li class="menu-item">
		        <a href="/ticket/showinfoMovList">예매</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/ticket/showinfoMovList">영화별 예매</a></li>
		          <li class="menu-item"><a href="/ticket/showinfoCineList">극장별 예매</a></li>
		        </ol>
		      </li>
		      <li class="menu-item">
		        <a href="/movbd/list">게시판</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/movbd/list">영화 후기 게시판</a></li>
		          <li class="menu-item"><a href="/manbd/list">이벤트/공지사항</a></li>
		        </ol>
		      </li>
		      <li class="menu-item">
		        <a href="/qnabd/list">고객센터</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/qnabd/list">자주 묻는 질문</a></li>
		          <li class="menu-item"><a href="/inqubd/list">문의 게시판</a></li>
		        </ol>
		      </li>
		      <sec:authorize access="!hasAuthority('ROLE_ADMIN')">
		      <li class="menu-item">
		        <a href="/mypage">마이페이지</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/updateMember">내 정보 확인/수정</a></li>
		          <li class="menu-item"><a href="/mytkList">예매 확인/취소</a></li>
		          <li class="menu-item"><a href="/myboardList">내 활동 내역</a></li>
		        </ol>
		      </li>
		      </sec:authorize>
		      <sec:authorize access="hasAuthority('ROLE_ADMIN')">
		      <li class="menu-item">
		        <a href="/admin/cinema/cineList">관리자메뉴</a>
		        <ol class="sub-menu">
		          <li class="menu-item"><a href="/admin/cinema/cineList">극장정보 관리</a></li>
		          <li class="menu-item"><a href="/admin/showinfo/insertShowinfo">상영정보 관리</a></li>
		        </ol>
		      </li>
		      </sec:authorize>
		    </ol>
		</nav>
	</div>
</body>
</html>