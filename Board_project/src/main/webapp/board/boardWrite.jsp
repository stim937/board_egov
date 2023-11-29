<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성하기</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="./script/jquery-3.7.1.min.js"></script>
<style>
	input {
	  width:300px;
	  font-size:20px;
	}
</style>

</head>

<script>
	function movePage(destination) {
 		var searchGubun = "${boardVO.searchGubun }";
 		var searchText = "${boardVO.searchText }";
 		var viewPage = "${boardVO.viewPage }";
 		var unq = "${boardVO.unq }";
		var url = destination + '?viewPage=' + viewPage;

		if (destination === 'boardModifyWrite.do' ) {
			url = url + '&unq=' + unq;
		}
		
		if (searchGubun !== '' && searchText !== '') {
	        location.href = url + '&searchGubun=' + searchGubun + '&searchText=' + searchText;
	    } else {
	        location.href = url;
	    }
	} 
	
	function fn_submit() {
		if ($.trim($("#title").val()) == "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;
		}
		$("#title").val($.trim($("#title").val()));

		if ($.trim($("#pass").val()) == "") {
			alert("암호를 입력해주세요.");
			$("#pass").focus();
			return false;
		}
		$("#pass").val($.trim($("#pass").val()));
		
		if ($.trim($("#name").val()) == "") {
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		
		if ($.trim($("#content").val()) == "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}
		
		var formData = $("#frm").serialize();

		// 비동기 전송방식
		$.ajax({
			type : "POST",
			data : formData,
			url : "boardWriteSave.do",
			dataType : "text", 		// 리턴타입
			success : function(data) {	// controller -> "ok", "fail" 
				if (data == "ok") {
					alert("저장하였습니다.");
					location = "boardList.do";
				} else {
					alert("저장 실패했습니다. 다시 시도해주세요");
				}
			},
			error : function() {	// 장애 발생
				alert("오류발생");
			}
		});
	}
	

</script>

<body>
	<div class="container mt-3 w-50">
		<h2 class="text-center">게시판 등록 화면</h2>
		<form id="frm">
			<table class="table">
				<caption>게시판 등록</caption>
				<tr>
					<th><label for="title">제목</label></th>
					<td>
						<input class="form-control" type="text" name="title" id="title" placeholder="제목을 입력하세요">			
					</td>
				</tr>
				<tr>
					<th><label for="pass">암호</label></th>
					<td><input class="form-control" type="password" name="pass" id="pass" placeholder="암호를 입력하세요"></td>
				</tr>
				<tr>
					<th><label for="name">작성자</label></th>
					<td><input class="form-control" type="text" name="name" id="name" placeholder="이름을 입력하세요" required></td>
				</tr>
				<tr>
					<th><label for="content">내용</label></th>
					<td><textarea class="form-control" name="content" id="content" rows="8" placeholder="내용을 입력하세요" required></textarea></td>
				</tr>
			</table>
			<div class="d-flex justify-content-end gap-2">
				<button class="btn btn-primary" type="submit" onclick="fn_submit();return false;">저장</button>
				<button class="btn btn-secondary" type="reset" onclick="movePage('boardList.do')">취소</button>
			</div>
		</form>
	</div>
</body>
</html>