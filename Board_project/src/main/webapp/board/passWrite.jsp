<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>암호입력창</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="./script/jquery-3.7.1.min.js"></script>
</head>
<script>
	$(function(){
		$("#delBtn").click(function(){
			var pass = $("#pass").val();
			pass = $.trim(pass);
			if(pass == ""){
				alert("암호를 입력해주세요.");
				$("#pass").focus();
				return false;
			}
			
			var confirmDelete = confirm("삭제 하시겠습니까?");

	        if (!confirmDelete) {
	            return; // 사용자가 취소한 경우 삭제 중단
	        }
	        
			var sendData = "unq=${unq}&pass=" + pass;
			
			$.ajax({
				type : "POST",
				data : sendData,
				url : "boardDelete.do",
				dataType : "text", 		// 리턴타입
				success : function(data) {	// controller -> "ok", "fail" 
					if (data == "1") {
						alert("삭제하였습니다.");
						location = "boardList.do";
					} else if(data == "-1"){
						alert("암호가 일치하지 않습니다.");
					} else {
						alert("삭제에 실패하였습니다.");
					}
				},
				error : function() {	// 장애 발생
					alert("오류발생");
				}
			});
		});
	});	
</script>
<body>
	<div class="container mt-3 w-50">
		<div class="d-flex justify-content-center gap-2">
			<h3>암호입력</h3>
			<input type="password" id="pass" name="pass">
			<button class="btn btn-danger" type="button" id="delBtn">삭제하기</button>
		</div>
	</div>
</body>
</html>