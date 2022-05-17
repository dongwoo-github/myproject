<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<style>
.exMsg h3 {
	font-weight: bold;
	text-align: center
}

.exMsg {
	padding-bottom: 10px;
}
</style>
<title>회원 탈퇴</title>
</head>
<body>
	<div id="container">
		<div id="body">
			<div class="registration-form">
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="user" />
					<form method="post" onsubmit="return checkVal()" action="deleteMember">
						<div class="form-group">
							<div class="exMsg">
								<h3>회원 탈퇴하려면 비밀번호를 입력해주세요</h3>
							</div>
						</div>
						<div class="form-group">
							<input type="hidden" name="_method" value="delete">
							<div class="title">
								<h5>비밀번호</h5>
							</div>
							<input class="form-control item" id="password" name="mem_pw"
								type="password">${error}
							<button type="submit" value="탈퇴">회원탈퇴</button>
						</div>
					</form>
				</sec:authorize>
			</div>
		</div>
	</div>

	<script>
		function checkVal() {
			let mem_pw = document.querySelector("#mem_pw").value;
			if (!mem_pw) {
				alert("비밀번호 입력하세요");
				return false;
			}
		}
	</script>

</body>
</html>