<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>글쓰기</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;800&family=Roboto+Serif:ital@1&family=Roboto:wght@700&display=swap" rel="stylesheet">
<style>
	.blue{background-color: #A1BAF5; width: 100px; font-weight:bold; text-align:center; }
	table{border-collapse : collapse; width: 1400px; }
	*{
	font-family: 'Nanum Gothic', sans-serif;	
	}
	tr, td {
		padding: 10px;
	}
	table tr td .title {width:99%; height:20px; margin:auto;  font-size:16px;}
	#save{margin-top:10px;}

</style>
</head>
<body>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="user" /> <!-- 시큐리티 아이디값 받아오기 -->


<div id="container" align="center">
<form method="post" id="writeform" action="write">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<table border="1">
		<tr>  
			<td class="blue" align="center">글 제목</td>
			<td><input input name="movbd_title" class="title"  placeholder="내용을 입력해주세요"/></td>
		</tr>
		<tr>  
			<td class="blue" align="center">관람 영화</td>
			<td><select name="movbd_mov">
			<c:forEach items="${mov_list}" var="mov">
				<option value="${mov}">${mov}</option>
			</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td class="blue" align="center">작성자</td>
			<td><input name="movbd_id" value="${user.username}" readonly ></td>
		</tr>
		<tr>
			<td class="blue" align="center">내용</td>
			<td><div id="smarteditor">
        	<textarea name="movbd_content" id="editorTxt" 
                  rows="30" cols="20" 
                  placeholder="내용을 입력해주세요"
                  style="width: 100%"></textarea>
     			 </div>
      		</td>
		</tr>
	</table>
	<div align="center"><input type="button" id="save" value="새글 등록"></div>
	
</form>
</div>
</sec:authorize>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> <!-- 스마트에디터 -->
<script>
     let oEditors = []

    smartEditor = function() {
      console.log("Naver SmartEditor")
      nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "editorTxt",
        sSkinURI: "/smarteditor/SmartEditor2Skin.html",
        fCreator: "createSEditor2"
      })
    } 

    $(document).ready(function() {
  
     	smartEditor() 
      
      $("#save").click(function(){
    	  //여기 
    	  let d = confirm("정말 등록하시겠습니까?");//
			if(d){
    	  	oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
    	  	$("#writeform").submit();
			}else{
				// 입력 안하면 현재 페이지 머무르기
			}
      })
      
      
    })
  </script>
</body>
</html>	
