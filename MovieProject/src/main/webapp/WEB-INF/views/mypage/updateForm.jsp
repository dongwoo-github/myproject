<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<title>회원정보 확인및수정</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<style>
#pw_msg{color : red;}
</style>
</head>
<body>
	<div id="container">
		<div id="body">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="user" />
				<div class="registration-form">
					<form:form action="updateMember" modelAttribute="dto" method="post"
						id="updateform">
						<div class="form-icon">
							<span><i class="icon icon-user" id="icon"></i></span>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>아이디</h5>
							</div>
							<input class="form-control item" id="id" name="mem_id"
								value="${user.username}" readonly="readonly">
							<div class="msg" id="id_msg">
								<form:errors path="mem_id" />
							</div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>새 비밀번호</h5>
							</div>
							<input type="password" class="form-control item" name="mem_pw"
								 id="password" placeholder="새로운 비밀번호를 4-13자리로 입력하세요">
							<div class="msg" id="pw_msg">
								<form:errors path="mem_pw" />
							</div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>새 비밀번호 확인</h5>
							</div>
							<input type="password" class="form-control item" id="password_ck"
								name="password_ck" placeholder="새로운 비밀번호 확인">
							<div class="msg" id="pwck_msg"></div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>이름</h5>
							</div>
							<input class="form-control item" name="mem_name" id="name"
								value="${dto.mem_name}" readonly="readonly">
							<div class="msg" id="name_msg">
								<form:errors path="mem_name" />
							</div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>생년월일</h5>
							</div>
							<input class="form-control item" name="mem_birth" id="birth"
								readonly="readonly"
								value=<fmt:formatDate value="${dto.mem_birth}" pattern="yyyy-MM-dd" />>
							<div class="msg" id="birth_msg">
								<form:errors path="mem_birth" />
							</div>
						</div>
						<div class="form-group">
							<div class="title" >
								<h5>핸드폰번호</h5>
							</div>
							<input class="form-control item" name="mem_phone" id="phone"
								 value="${dto.mem_phone}">
							<div class="msg" id="phone_msg">
								<form:errors path="mem_phone" />
							</div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>주소</h5>
							</div>
							<input class="form-control item" name="mem_address" id="address"
								 value="${dto.mem_address}">
							<button type="button" class="btn btn-block create-account"
								id="addbtn" onclick="addPost()">우편번호 검색</button>
							<div class="msg">
								<form:errors path="mem_address" />
							</div>
						</div>
						<div class="form-group">
							<div class="title">
								<h5>email</h5>
							</div>
							<input class="form-control item" id="email" name="mem_email"
								 value="${dto.mem_email}">
							<button type="button" id="mail_ck"
								class="btn btn-block create-account">이메일 인증</button>
							<div class="msg" id="emailresult">
								<form:errors path="mem_email" />
							</div>
						</div>
						<div class="form-group" id="input">
							<input class="form-control item" id="ck_num"
								placeholder="인증번호를 입력하세요">
							<button type="button" class="btn btn-block create-account"
								id="ck_b">인증확인</button>
							<div class="msg" id="result"></div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-block create-account">수정완료</button>
							<button id="mypage" class="btn btn-block create-account">마이페이지 이동</button>
						</div>
					</form:form>
				</div>
			</sec:authorize>
		</div>
	</div>

	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
	<script>
		function addPost() {
			new daum.Postcode({
				oncomplete : function(data) {
					document.querySelector("#address").value = data.address;
					alert("나머지 주소도 입력하세요.");
				}
			}).open();
		}//addPost

		let num = "";
		$(function() {

			$("#input").hide();
			$("#ck_b").hide();

			$("#mail_ck")
					.click(
							function() {
								let email = $("#email").val();
								let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

								if (!email) {
									$("#emailresult").html("메일 주소를 입력하세요");
									return false;
								}//if

								if (!(regExp.test(email))) {
									$("#emailresult").html(
											"형식에 맞게 메일 주소를 입력하세요");
									return false;
								}//if

								$.ajax({
									url : "/send",
									data : "emailAddress=" + email,
									dataType : "json"
								}).done(function(data) {
									if (eval(data[1])) {
										num = data[0];
										alert("메일이 전송되었습니다. 인증번호를 입력하세요.")
										$("#input").show();
										$("#ck_b").show();
									}
								});//ajax

							})//mail 전송

			$("#ck_b").click(
					function() {
						let ck_num = $("#ck_num").val();
						if (ck_num == num) {
							$("#result").html("인증이 확인되었습니다.")
							$("#result").append(
									"<input type='hidden' id='ck' value='1'>");
						} else {
							$("#result").html("인증 실패했습니다. 다시 확인하세요.");
						}
					})//이메일 인증


			$("#updateform")
					.submit(
							function() {
								
								let pw = $("#password").val();
								let pwck = $("#password_ck").val();
								
								if(!pw){
									$("#password").focus();
									$("#pw_msg").html("변경하실 비밀번호를 입력하세요!");
									return false;
								}
								
								if(!(pw.length>3&&pw.length<14)){
									$("#pw_msg").html("4~13자리로 비밀번호를 입력해주세요.");
									return false;
								}

								if(!pwck){
									$("#password_ck").focus();
									$("#pwck_msg").html("비밀번호를 확인 해 주세요");
									return false;
								}//비밀번호 확인
								
								if(pw!=pwck){
									$("#password_ck").focu
									$("#pwck_msg").html("입력한 번호와 일치하지 않습니다.");
									return false;
								}//비밀번호 확인

							})//submit

							$(function(){
								
								$("#mypage").click(function(){
									
									location.href="/../../mypage";
									
								})//click
								
							})//ready	
							
		})//ready
	</script>

</body>
</html>