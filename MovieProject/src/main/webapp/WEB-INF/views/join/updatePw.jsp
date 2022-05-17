<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 변경</title>
</head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<style>
	.exMsg h3 {font-weight:bold; text-align:center}
	.exMsg {padding-bottom:10px;}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		
		$("#updatePW").submit(function(){
			let pw = $("#password").val();
			let pwck = $("#password_ck").val();
			
			if(!pw){
				$("#password").focus();
				$("#pw_msg").html("바꿀 비밀번호를 입력하세요");
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
			
			alert("비밀번호가 변경되었습니다");
		
		})//submit
		
	})
</script>
<body>
<div id="container">
	<div id="body">
		<div class="registration-form">
			<form id="updatePW" method="post" action="updatePw">
				<input type="hidden" name="mem_name" value="${mem_name}">
				<input type="hidden" name="mem_email" value="${mem_email}">
				<input type="hidden" name="mem_id" value="${mem_id}">
				<div class="form-icon">
		        	<span><i class="icon icon-user" id="icon"></i></span>
		        </div>
				<div class="form-group">
					<div class="exMsg"><h3>변경할 비밀번호를 입력하세요</h3></div>
				</div>
				<div class="form-group">
					<div class="title"><h5>비밀번호</h5></div>
					<input type="password" class="form-control item" name="mem_pw" id="password" placeholder="4~13글자 사이로 입력하세요">
					<div class="msg" id="pw_msg"></div>
				</div>
				<div class="form-group">
		            	<div class="title"><h5>비밀번호 확인</h5></div>
		                <input type="password" class="form-control item" id="password_ck" name="password_ck" placeholder="비밀번호 확인">
		            	<div class="msg" id="pwck_msg"></div>
		            </div>
				<div class="form-group">
					<button type="submit" class="btn btn-block create-account">비밀번호 변경</button>
				</div>	
			</form>
		</div>
	</div>
</div>
</body>
</html>