<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>아이디 찾기</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<style>
	.exMsg h3 {font-weight:bold; text-align:center}
	.exMsg h5 {font-weight:bold; text-align:center}
	.exMsg {padding-bottom:10px;}
	#idList {padding-top:10px;}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		$("#login").click(function(){
			location.href="/login";
		});
		
	})//ready

</script>
<body>
<div id="container">
	<div id="body">
		<div class="registration-form">
			<form>
				<div class="form-icon">
		        	<span><i class="icon icon-user" id="icon"></i></span>
		        </div>
				<div class="form-group">
					<div class="exMsg"><h3>해당 이름과 이메일로</h3></div>
					<div class="exMsg"><h3>가입한 아이디입니다.</h3></div>
				</div>
				<div class="form-group" id="idList">
					<c:forEach items="${idList}" var="list">
						<div class="exMsg"><h5>${list}</h5></div>
					</c:forEach>
				</div>
				<div class="form-group">
					<button id="login" type="button" class="btn btn-block create-account">로그인하기</button>
				</div>	
			</form>
		</div>
	</div>
</div>
</body>
</html>