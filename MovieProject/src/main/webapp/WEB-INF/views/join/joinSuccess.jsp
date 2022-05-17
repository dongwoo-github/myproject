<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
</head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	$(function(){
		
		$("#gotoLogin").click(function(){
			location.href="/login";
		})//click
		
	})//ready
	
</script>
<style>
	.successMsg h3 {font-weight:bold; text-align:center}
	.successMsg {padding-bottom:10px;}
</style>
<body>
<div id="body">
		<div class="registration-form">
		<form>
			<div class="form-icon">
		                <span><i class="icon icon-user" id="icon"></i></span>
		            </div>
		            <div class="form-group">
		            	<div class="successMsg"><h3>회원가입에 성공하셨습니다!</h3></div>
		                <button type="button" id="gotoLogin" class="btn btn-block create-account">로그인페이지</button>
		            </div>
		</form>
		</div>
	</div>
</body>
</html>