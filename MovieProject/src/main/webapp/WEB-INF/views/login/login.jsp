<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.login {
  min-height:100vh;
}

.bg-image {
  background-size: contain;
  background-position: center;
  background-repeat: no-repeat;
  width: 50%;
  cursor:pointer;
}

#loginForm {
	width:50%;
}

.login-heading {
  font-weight: 300;
}

.btn-login {
  font-size: 0.9rem;
  letter-spacing: 0.05rem;
  padding: 0.75rem 1rem;
}

#body {
	margin: 100px 50px; 
	background-color:#F4F4F4;
}
#bodyWrapper{
	padding: 50px 0px;
}
#h3{font-weight:bold;}
.small{margin:0px 5px;}
.small:link {
	text-decoration:none;
}
.small:visited {
	text-decoration:none;
    color: blue;
}
.small:hover {
	text-decoration:underline;
}
.small:active {
	text-decoration:underline;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		
		function rand(min, max) {
			  return Math.floor(Math.random() * (max - min)) + min;
		}//function rand
		
		let api_key = "3f1a9babda761564c4e03796bac0c3e9";
		
		$.ajax({
			url:"https://api.themoviedb.org/3/movie/popular?api_key="+api_key+"&language=ko-KR&page=${page}",
			type:"get",
			dataType:"json"
		}).done(function(data){
			let img = "";
			let ranNum = rand(0,19);
			
			if(data.results[ranNum].poster_path!=null){
				img = "https://image.tmdb.org/t/p/original/"+data.results[ranNum].poster_path;
			}else{
				img = "/images/noImg.JPG";
			}
			
			$("#bg-image").css({"background-image":"url('"+img+"')"});
			$("#bg-image").attr("title",data.results[ranNum].id);
		})//ajax
		
		$("#bg-image").click(function(){
			location.href="movie/movieInfo/"+$(this).attr("title");
		})
		
	})

</script>
</head>
<body>
<div id="container">
<div id="header"></div>

<div id="body">

<div class="container-fluid ps-md-0" id="bodyWrapper">
  <div class="row g-0">
    <div class="d-none d-md-flex col-md-4 col-lg-6 bg-image" id="bg-image"></div>
    <div class="col-md-8 col-lg-6" id="loginForm">
      <div class="login d-flex align-items-center py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-9 col-lg-8 mx-auto">
              <h3 class="login-heading mb-4" id="h3">로그인</h3>

              <!-- Sign In Form -->
              <form method="post">
                <div class="form-floating mb-3">
                  <input type="text" name="username" class="form-control" id="floatingInput" placeholder="Id">
                  <label for="floatingInput">Id</label>
                </div>
                <div class="form-floating mb-3">
                  <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">
                  <label for="floatingPassword">Password</label>
                </div>

                <div class="d-grid">
                  <button class="btn btn-lg btn-primary btn-login text-uppercase fw-bold mb-2" type="submit">로그인</button>
                  <div class="text-center">
                    <a class="small" href="insertMember">회원가입</a>
                    <a class="small" href="findId">아이디 찾기</a>
                    <a class="small" href="findPw">비밀번호 찾기</a>
                  </div>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</div>

<div id="footer"></div>

</div>
</body>
</html>
