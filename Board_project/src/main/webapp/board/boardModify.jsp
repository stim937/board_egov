<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
		var url = destination + '?viewPage=' + viewPage + "&unq=" + unq;

		if (searchGubun !== '' && searchText !== '') {
	        location.href = url + '&searchGubun=' + searchGubun + '&searchText=' + searchText;
	    } else {
	        location.href = url;
	    }
	} 

	function fn_submit() {
		if ($.trim($("#title").val()) == "") {
			alert("제목을 입력해주세요.");
			// document.frm.title.focus();
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

		var formData = $("#frm").serialize();

		// 비동기 전송방식
		$.ajax({
			type : "POST",
			data : formData,
			url : "boardModifySave.do",
			dataType : "text", 		// 리턴타입
			success : function(data) {	// controller -> "ok", "fail" 
				if (data == "1") {
					alert("수정하였습니다.");
					movePage('boardDetail.do');
					/* location = "boardDetail.do?unq=${boardVO.unq }&searchGubun=${boardVO.searchGubun }&searchText=${boardVO.searchText }"; */
				} else if(data == "-1") {
					alert("암호가 일치하지 않습니다.");
				} else {
					alert("수정 실패했습니다. 다시 시도해주세요");
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
		<h2 class="text-center">게시판 수정 화면</h2>
		<form id="frm">		
			<input type="hidden" name="unq" value="${boardVO.unq }">
			<table class="table">
				<caption>게시판 수정</caption>
				<tr>
					<th><label for="title">제목</label></th>
					<td><input class="form-control" type="text" name="title" id="title" class="input1" value="${boardVO.title }"></td>
				</tr>
				<tr>
					<th><label for="pass">암호</label></th>
					<td><input class="form-control is-invalid" type="password" name="pass" id="pass" placeholder="암호를 입력하세요"></td>
				</tr>
				<tr>
					<th><label for="name">작성자</label></th>
					<td><input class="form-control" type="text" name="name" id="name" value="${boardVO.name }" readonly></td>
				</tr>
				<tr>
					<th><label for="content">내용</label></th>
					<td><textarea class="form-control" name="content" id="content" class="textarea" rows="8">${boardVO.content }</textarea></td>
				</tr>
			</table>
			<div class="d-flex justify-content-end gap-2">
				<button class="btn btn-primary" type="submit" onclick="fn_submit();return false;">저장</button>
				<button class="btn btn-secondary" type="reset" onclick="movePage('boardDetail.do')">취소</button>
			</div>
		</form>
	</div>
</body>
</html>