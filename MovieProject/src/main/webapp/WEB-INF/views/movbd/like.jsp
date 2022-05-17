<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<td id="like">
					<c:choose>
						<c:when test="${ltlike ==0}">
							<button type="button" class="btn btn-light" id="likebtn">좋아요</button>
							<input type="hidden" id="likecheck" value="${ltlike }">
						</c:when>					
						<c:when test="${ltlike ==1}">
							<button type="button" class="btn btn-danger" id="likebtn">좋아요</button>
							<input type="hidden" id="likecheck" value="${ltlike }">
						</c:when>
					</c:choose>					
</td>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$('#likebtn').click(function(){
		likeupdate();
	});

	function likeupdate(){
		alert("좋아요")
		likeurl = "/like/likeupdate",
		id = '${user.mem_id}',
		movbd_no = ${dto.movbd_no},
		count = $('#likecheck').val(),
		data = {"movbd_id" : id,
				"movbd_no" : movbd_no,
				"count" : count};
	
	$.ajax({
		url : likeurl,
		type : 'PUT',
		//contentType: 'application/json',
		data : data,
		success : function(result){
			console.log("수정" + result.result);
			if(count == 1){
				console.log("좋아요 취소");
				 $('#likecheck').val(0);
				 $('#likebtn').attr('class','btn btn-light');
			}else if(count == 0){
				console.log("좋아요!");
				$('#likecheck').val(1);
				$('#likebtn').attr('class','btn btn-danger');
			}
		}, error : function(result){
			console.log("에러" + result.result)
		}
		
		});
	};

	function getContextPath() {
   	 var hostIndex = location.href.indexOf( location.host ) + location.host.length;
   	 return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	} 
</script>
	
</body>
</html>