<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>글수정</title>
<style>
	.item{background-color:#A1BAF5;width:100px; text-align:center; font-size:16px; font-weight:bold;}
	table{border-coppapse:collapse; width:1400px;}
	table tr td input {width:99%; height:20px; margin:auto; font-weight:bold; font-size:16px;}
	table tr td textarea {width:99%; height:500px; margin:auto; resize: none; overflow-x:hidden; overflow-y:scroll;font-weight:bold; font-size:16px; }
	table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
	  }
	  tr, td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	  }
</style>
<link rel="stylesheet" type="text/css" href="/css/btn1.css"/>
</head>
<body>
<div id="container">
	<div id="body" align="center">
		<form method="post" id="updateform">
			<input type="hidden" name="_method" value="put">
				<table border="1">
					<tr>
						<td class="item">제목</td>
						<td><input name="qnabd_q" value="${dto.qnabd_q}"></td>
					</tr>
					<tr>
						<td class="item">답변</td>
						<td><textarea name="qnabd_a">${dto.qnabd_a}</textarea></td>
					</tr>
				</table>
				<button type="submit" id="save" class="custom-btn btn-5">수정</button>
		</form>
	</div>
</div>

</body>
</html>