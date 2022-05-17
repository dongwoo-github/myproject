<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>글 수정</title>

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
	table tr td .title {width:99%; height:20px; margin:auto; font-weight:bold; font-size:16px;}
	#save{margin-top:10px;}

</style>

</head>
<body>
<sec:authorize access="isAuthenticated()" />
<sec:authentication property="principal" var="user" />


<div id="container" align="center">
<form method="post" id="updateform" action="/movbd/update" >
<input type="hidden" name="_method" value="put">
	<table border="1">
		<tr>	
			<td class="blue" align="center">글 제목</td>
			<td><input name="movbd_title" class="title" value="${dto.movbd_title }"/>
				<input name="movbd_no" value="${dto.movbd_no}" type="hidden"> 
			</td>
		</tr>
		<tr>  
			<td class="blue" align="center">관람 영화</td>
			<td><select name="movbd_mov">
				<option value="${dto.movbd_mov}">${dto.movbd_mov}</option>
			</select></td>
		</tr>
		<tr>
			<td class="blue" align="center">작성자</td>
			<td><input name="movbd_id" value="${dto.movbd_id}" readonly></td>
		</tr>
		<tr>
			<td class="blue" align="center">내용</td>
			<td><div id="smarteditor">
        	<textarea name="movbd_content" id="editorTxt" 
                  rows="20" cols="10" 
                  style="width: 100%"></textarea>
                  </div>
            </td>
		</tr>
			</table>
				<input type="button" id="save" value="글 수정 완료"> 
</form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
    let oEditors = []

    smartEditor = function() {
      nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "editorTxt",
        sSkinURI: "/smarteditor/SmartEditor2Skin.html",
        fOnAppLoad : function(){
            oEditors.getById["editorTxt"].exec("PASTE_HTML", ['${dto.movbd_content}']);
        },
        fCreator: "createSEditor2"
      })
    }

    $(document).ready(function() {
      smartEditor() 
      
      $("#save").click(function(){
    	  oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
    	  $("#updateform").submit();
      });
      
    })
  </script>
</body>
</html>