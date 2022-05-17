<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="/css/joinForm.css" rel="stylesheet">
<style>
</style>
</head>
<body>
<div id="container">
	<div id="body">
		<div class="registration-form">
		<form:form action="insertMember" modelAttribute="dto" method="post" id="joinform">
			<div class="form-icon">
		                <span><i class="icon icon-user" id="icon"></i></span>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>아이디</h5></div>
		                <input class="form-control item" id="id" name="mem_id" placeholder="4-13자리로 입력하세요" value="${dto.mem_id}">
		                <button type="button" id="id_check" class="btn btn-block create-account">중복확인</button>
		                <div class="msg" id="id_msg"><form:errors path="mem_id"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>비밀번호</h5></div>
		                <input type="password" class="form-control item" name="mem_pw" id="password" placeholder="4-13자리로 입력하세요">
		           		<div class="msg" id="pw_msg"><form:errors path="mem_pw"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>비밀번호 확인</h5></div>
		                <input type="password" class="form-control item" id="password_ck" name="password_ck" placeholder="비밀번호 확인">
		            	<div class="msg" id="pwck_msg"></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>이름</h5></div>
		                <input class="form-control item" name="mem_name" id="name" placeholder="이름" value="${dto.mem_name}">
		            	<div class="msg" id="name_msg"><form:errors path="mem_name"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>생년월일</h5></div>
		                <input class="form-control item" name="mem_birth" id="birth" placeholder="yyyy-MM-dd" value=<fmt:formatDate value="${dto.mem_birth}" pattern="yyyy-MM-dd"/>>
		            	<div class="msg" id="birth_msg"><form:errors path="mem_birth"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>핸드폰번호</h5></div>
		                <input class="form-control item" name="mem_phone" id="phone" placeholder="010-0000-0000" value="${dto.mem_phone}">
		            	<div class="msg" id="phone_msg"><form:errors path="mem_phone"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>주소</h5></div>
		                <input class="form-control item" name="mem_address" id="address" placeholder="주소" value="${dto.mem_address}">
		                <button type="button" class="btn btn-block create-account" id="addbtn" onclick="addPost()">우편번호 검색</button>
		            	<div class="msg"><form:errors path="mem_address"/></div>
		            </div>
		            <div class="form-group">
		            	<div class="title"><h5>email</h5></div>
		                <input class="form-control item" id="email" name="mem_email" placeholder="email" value="${dto.mem_email}">
		                <button type="button" id="mail_ck" class="btn btn-block create-account">이메일 인증</button>
		            	<div class="msg" id="emailresult"><form:errors path="mem_email"/></div>
		            </div>
		            <div class="form-group" id="input">
		                <input class="form-control item" id="ck_num" placeholder="인증번호를 입력하세요">
		                <button type="button" class="btn btn-block create-account" id="ck_b">인증확인</button>
		            	<div class="msg" id="result"></div>
		            </div>
		            <div class="form-group">
		                <button type="submit" class="btn btn-block create-account">회원가입</button>
		            </div>
		</form:form>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
<script>
	
		function addPost(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		            document.querySelector("#address").value = data.address;
		            alert("나머지 주소도 입력하세요.");
		        }
		    }).open();
		}//addPost

			let num = "";
		$(function(){
			
			$("#input").hide();
			$("#ck_b").hide();
			
			 $("#mail_ck").click(function(){
				 let email = $("#email").val();
				 let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				
				 if(!email){
						$("#emailresult").html("메일 주소를 입력하세요");
						return false;
					}//if
				
				if(!(regExp.test(email))){
					$("#emailresult").html("형식에 맞게 메일 주소를 입력하세요");
					return false;
				}//if
				
				
			 $.ajax({url:"/send",
				 	data:"emailAddress="+email,
					dataType:"json"}
				).done(function(data){
					if(eval(data[1])){
						num = data[0];
						alert("메일이 전송되었습니다. 인증번호를 입력하세요.")
						$("#input").show();
						$("#ck_b").show();
					}
				});//ajax
			 
			})//mail 전송
			
			$("#ck_b").click(function(){
				let ck_num = $("#ck_num").val();
				if(ck_num == num){
					$("#result").html("인증이 확인되었습니다.")
					$("#result").append("<input type='hidden' id='ck' value='1'>");
				}else{
					$("#result").html("인증 실패했습니다. 다시 확인하세요.");
				}
			})//이메일 인증
	
		
		$("#id_check").click(function(){
			let mem_id = $("#id").val();
			if(!(mem_id.length>3&&mem_id.length<14)){
				$("#id_msg").html("4~13자리로 아이디를 입력해주세요.");
				return false;
			}
			if(!mem_id){
				$("#id_msg").html("아이디를 입력하세요")
				return false;
			}
			$.ajax({
				url:"/idCheck",
				data:"mem_id="+mem_id,
				dataType:"text"
			}).done(function(data){
				if(data == ""){
					$("#id_msg").html("사용 가능한 아이디입니다.");
					$("#id_msg").append("<input type='hidden' id='id_ck' value='1'>");
				}else{
					$("#id_msg").html("이미 사용중인 아이디입니다.")
				}
			})
		})//id중복확인
		
		
		
		$("#joinform").submit(function(){
			
			let pw = $("#password").val();
			let pwck = $("#password_ck").val();
			const reg = /^(19[0-9][0-9]|20\\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
			let birth = $("#birth").val();
			
			if($("#id_ck").val()!=1){
				$("#id_msg").html("아이디 중복 체크 하셔야 합니다.");
				$("#id").focus();
				return false;
			}//id 중복체크
			
			if(pw!=pwck){
				$("#password").focus();
				$("#pwck_msg").html("입력한 번호와 일치하지 않습니다.");
				return false;
			}//비밀번호 확인
			
			if(!(reg.test(birth))){
				$("#birth").focus();
				$("#birth_msg").html("형식에 맞게 입력 해 주세요");
				return false;
			}

			if($("#ck").val() != 1){
				 $("#email").focus();
				$("#result").html("이메일 인증 하셔야 합니다.");
				return false;
			}
			 
		})//submit
		
	})//ready
</script>

</body>
</html>