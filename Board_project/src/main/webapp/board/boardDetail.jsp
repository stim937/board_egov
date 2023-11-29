<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세 화면</title>
<script src="./script/jquery-3.7.1.min.js"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
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
		if ($.trim($("#name").val()) == "") {
			alert("작성자를 입력해주세요.");
			$("#name").focus();
			return false;
		}
		$("#name").val($.trim($("#name").val()));

		if ($.trim($("#pass").val()) == "") {
			alert("암호를 입력해주세요.");
			$("#pass").focus();
			return false;
		}
		$("#pass").val($.trim($("#pass").val()));
		
		if ($.trim($("#content").val()) == "") {
			alert("댓글 내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}

		var formData = $("#cmtWriteFrm").serialize();

		// 비동기 전송방식
		$.ajax({
			type : "POST",
			data : formData,
			url : "commentSave.do",
			dataType : "text", 		// 리턴타입
			success : function(data) {	// controller -> "ok", "fail" 
				if (data == "ok") {
					alert("저장하였습니다.");
					location = "";
				} else {
					alert("저장 실패했습니다. 다시 시도해주세요");
				}
			},
			error : function() {	// 장애 발생
				alert("오류발생");
			}
		});
	}
	
	function showEditForm(commentId) {
	    var editForms = document.getElementsByClassName('edit-form');
	    for (var i = 0; i < editForms.length; i++) {
	        editForms[i].style.display = 'none';
	    }
	
	    var editForm = document.getElementById('edit-form-' + commentId);
	    editForm.style.display = "table-row";
	}
	
	function comment_submit(cnt) {
		var pass = "pass-" + cnt;
		var frm = "cmtFrm-" + cnt;
		
		if ($.trim($("#" + pass).val()) == "") {
			alert("암호를 입력해주세요.");
			$("#" + pass).focus();
			return false;
		}
		
		var confirmDelete = confirm("삭제 하시겠습니까?");

        if (!confirmDelete) {
            return; // 사용자가 취소한 경우 삭제 중단
        }
		
		
		var formData = $("#" + frm).serialize();

		$.ajax({
			type : "POST",
			data : formData,
			url : "commentDelete.do",
			dataType : "text", 		// 리턴타입
			success : function(data) {	// controller -> "ok", "fail" 
				if (data == "1") {
					alert("삭제하였습니다.");
					location = "";
				} else if(data == "-1") {
					alert("암호가 일치하지 않습니다.");
				} else {
					alert("삭제 실패했습니다. 다시 시도해주세요");
				}
			},
			error : function() {	// 장애 발생
				alert("오류발생");
			}
		});
	}
	
	function modify_submit(cnt) {
		var pass = "pass-" + cnt;
		var frm = "cmtFrm-" + cnt;
		
		if ($.trim($("#" + pass).val()) == "") {
			alert("암호를 입력해주세요.");
			$("#" + pass).focus();
			return false;
		}
		
		var confirmModify = confirm("수정 하시겠습니까?");

        if (!confirmModify) {
            return; // 사용자가 취소한 경우 삭제 중단
        }
		
		
		var formData = $("#" + frm).serialize();

		// 비동기 전송방식
		$.ajax({
			type : "POST",
			data : formData,
			url : "commentModifySave.do",
			dataType : "text", 		// 리턴타입
			success : function(data) {	// controller -> "ok", "fail" 
				if (data == "1") {
					alert("수정 하였습니다.");
					location = "";
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
		<h2 class="text-center">게시판 상세 화면</h2>
		<form id="frm">
			<table class="table border table-hover">
				<caption>게시판 상세</caption>
				<tr>
					<th width="15%">제목</th>
					<td>${boardVO.title }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${boardVO.name }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${boardVO.content }</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>${boardVO.rdate }</td>
				</tr>
			</table>
			<div class="d-flex justify-content-end gap-2">				
				<button class="btn btn-primary" type="button" onclick="movePage('boardModifyWrite.do')">수정</button>
				<button class="btn btn-danger" type="button" onclick="location='passWrite.do?unq=${boardVO.unq}'">삭제</button>
				<button class="btn btn-secondary" type="button" onclick="movePage('boardList.do')">목록</button>
			</div>
		</form>
		
		<form id="cmtWriteFrm">
		    <input type="hidden" name="boardUnq" id="boardUnq" value="${boardVO.unq }">
		    <table class="table table-borderless w-75">			
		        <tr>
		            <th>작성자</th>
		            <td><input class="form-control" type="text" name="name" id="name"></td>
		            <th>암호</th>
		            <td><input class="form-control" type="password" name="pass" id="pass"></td>
		        </tr>
		        <tr>
		            <th>내용</th>
		            <td colspan="3"><textarea class="form-control" name="content" id="content" required></textarea></td>
		        </tr>
		    </table>
		    <div class="d-flex justify-content-end w-75">
		        <button type="submit" class="btn btn-outline-secondary" onclick="fn_submit();return false;">댓글 작성</button>
		    </div>
		</form>
		
		<table class="table border mt-3">
			<caption>게시판 댓글</caption>
			<thead>
				<tr>
					<th>댓글번호</th>
					<th width="15%">작성자</th>
					<th width="50%">댓글 내용</th>
					<th width="20%">날짜</th>
				</tr>
			</thead>
			
			<c:set var="cnt" value="1" />
			
			<tbody>
				<c:forEach var="comment" items="${CommentList }">
					
					<tr>
						<td>${cnt }</td>
						<td>${comment.name }</td>
						<td><pre>${comment.content }</pre></td>
						<td>${comment.rdate }
							<button onclick="showEditForm(${comment.commentUnq })" class="btn btn-sm btn-link">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">
									<path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
								</svg>
							</button>
						</td>			
					</tr>
					<tr style="display: none;" class="edit-form" id="edit-form-${comment.commentUnq }">
						<td colspan="4">
							<form id="cmtFrm-${cnt }">
								<input type="hidden" name="commentUnq" value="${comment.commentUnq }">
								<div class="form-group">
									<textarea class="form-control" name="content" id="edit-content-${cnt }" >${comment.content}</textarea>									
								</div>
								<div class="d-flex justify-content-end mt-3 gap-2">
									암호입력<input type="password" name="pass" id="pass-${cnt }">	
									<button type="button" class="btn btn-sm btn-outline-primary" onclick="modify_submit(${cnt });return false;">수정</button>
									<button type="button" class="btn btn-sm btn-outline-danger" onclick="comment_submit(${cnt });return false;">삭제</button>
								</div>
							</form>
						</td>
					</tr>
					
					<c:set var="cnt" value="${cnt + 1 }" />
				</c:forEach>
				
				<c:if test="${empty CommentList }">
					<tr>
						<td colspan="4" class="text-center">
							작성된 댓글이 없습니다
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</body>
</html>
