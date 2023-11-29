<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="./script/jquery-3.7.1.min.js"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>

<script>
	$(document).ready(function(){
	    var condition = "${param.searchGubun}"; 	    
	    var selectElement = $("#searchGubun");	    
	    selectElement.find("option").each(function() {
	        if ($(this).val() === condition) {
	            $(this).prop("selected", true);
	            return false;
	        }
	    });
	});
	
 	function movePage(destination) {
 		var searchGubun = "${boardVO.searchGubun }";
 		var searchText = "${boardVO.searchText }";
 		var viewPage = "${boardVO.viewPage }";
		var url = destination + '?viewPage=' + viewPage;

		if (searchGubun !== '' && searchText !== '') {
	        location.href = url + '&searchGubun=' + searchGubun + '&searchText=' + searchText;
	    } else {
	        location.href = url;
	    }
	} 
</script>

<body>
	<div class="container mt-3">
		<h2 class="text-center">게시판 목록</h2>		
		<div>Total : ${total }</div>
<%-- 		<div>현재페이지 : ${crrPage } </div>
		<div>시작페이지 : ${startPage }</div>
		<div>끝페이지 : ${endPage }</div>
		<div>총페이지 : ${totalPage }</div>
		<div>검색조건 : ${param.searchGubun }</div>
		<div>검색어 : ${param.searchText }</div>  --%>
		
		<div class="mb-3">
		    <form class="input-group m" name="searchFrm" method="get" action="boardList.do" style="display: flex;">
		        <select name="searchGubun" id="searchGubun">
		            <option value="title">제목</option>
		            <option value="name">작성자</option>
		            <option value="content">내용</option>
		        </select>
		        <input type="text" name="searchText" id="searchText" placeholder="검색어를 입력하세요" value="${param.searchText}">
		        <button class="btn btn-dark" type="submit">검색</button>
		    </form>
		</div>

	
		<!--  번호, 제목, 글쓴이, 등록일, 조회수 -->
		<table class="table table-hover table-bordered">
			<thead class="table-primary">
				<tr align="center">
					<th scope="col" width="8%">번호</th>
					<th scope="col" width="52%">제목</th>
					<th scope="col" width="15%">작성자</th>
					<th scope="col" width="15%">등록일</th>
					<th scope="col" width="10%">조회수</th>
				</tr>
			</thead>
			<c:set var="cnt" value="${rowNumber }" />
			<tbody>
				<c:forEach var="result" items="${resultList }">				
						<tr align="center">
							<td><c:out value="${cnt }" /></td>
							<td align="left">
								<c:choose>
							    	<c:when test="${not empty param.searchGubun and not empty param.searchText}">
								        <a href="boardDetail.do?viewPage=${crrPage }&unq=${result.unq}&searchGubun=${param.searchGubun}&searchText=${param.searchText}">
								            <c:out value="${result.title}" /></a>
								    </c:when>
								    <c:otherwise>
								        <a href="boardDetail.do?viewPage=${crrPage }&unq=${result.unq}">
								            <c:out value="${result.title}" /></a>
								    </c:otherwise>
								</c:choose>
							</td>
							<td><c:out value="${result.name }" /></td>
							<td><c:out value="${result.rdate }" /></td>
							<td><c:out value="${result.hits }" /></td>
						</tr>				
					<c:set var="cnt" value="${cnt - 1 }" />
				</c:forEach>
				<c:if test="${empty resultList }">
					<tr>
						<td colspan="5" class="text-center">
							검색결과가 존재하지 않습니다.
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	
		<c:set var="prevPageGroup" value="${startPage - perPageGroup}" />
		<c:set var="nextPageGroup" value="${endPage + 1}" />	
        
		<nav aria-label="notifyList pagination">
			<ul class="pagination justify-content-center">
				<c:if test="${startPage > 1}">
			   		<c:choose>
			            <c:when test="${not empty param.searchGubun and not empty param.searchText }">
			    			<li class="page-item">
			    				<a class="page-link" href="boardList.do?viewPage=${prevPageGroup }&searchGubun=${param.searchGubun}&searchText=${param.searchText}">&lt;</a>
	    					</li>   	
			    		</c:when>
			    		<c:otherwise>
			    			<li class="page-item"><a class="page-link" href="boardList.do?viewPage=${prevPageGroup }">&lt;</a>
			    		</c:otherwise>
			    	</c:choose>
				</c:if>
				
			    <c:forEach var="pageNum" begin="${startPage }" end="${endPage }">
			        <c:choose>
			            <c:when test="${not empty param.searchGubun and not empty param.searchText }">
			                <c:choose>
				                <c:when test="${crrPage eq pageNum }">			                
					                <li class="page-item active" aria-current="page">
					                	<span class="page-link" >${pageNum }</span>
					          	 	</li>			           
				           		</c:when>
				           		<c:otherwise>
				           			<li class="page-item">
					                	<a class="page-link" href="boardList.do?viewPage=${pageNum }&searchGubun=${param.searchGubun}&searchText=${param.searchText}">${pageNum }</a>
					          	 	</li>
				           		</c:otherwise>
			           		</c:choose>
			            </c:when>
			            <c:otherwise>
			             	<c:choose>
				            	<c:when test="${crrPage eq pageNum }">			                
					                <li class="page-item active" aria-current="page">
					                	<span class="page-link" >${pageNum }</span>
					          	 	</li>			           
				           		</c:when>
				           		<c:otherwise>
				           			<li class="page-item">
				                <li class="page-item"><a class="page-link" href="boardList.do?viewPage=${pageNum }">${pageNum }</a>
				                </c:otherwise>
			                </c:choose>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			    
			    <c:if test="${endPage < totalPage}">
			        <c:choose>
			            <c:when test="${not empty param.searchGubun and not empty param.searchText}">
			                <li class="page-item"><a class="page-link" href="boardList.do?viewPage=${nextPageGroup }&searchGubun=${param.searchGubun}&searchText=${param.searchText}">&gt;</a>
			            </c:when>
			            <c:otherwise>
			                <li class="page-item"><a class="page-link" href="boardList.do?viewPage=${nextPageGroup }">&gt;</a>
			            </c:otherwise>
			        </c:choose>	    			
				</c:if>	    
			</ul>
		</nav>
			
		<div class="d-flex justify-content-end gap-2">
		    <button class="btn btn-primary" type="button" onclick="movePage('boardWrite.do')">글쓰기</button>
		    <button class="btn btn-secondary" type="button" onclick="location='boardList.do'">전체목록</button>
		</div>
	</div>
</body>
</html>