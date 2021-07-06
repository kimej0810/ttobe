<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/main_modal.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content {
	display: inline !important;
}

#paging li {
	list-style: none;
	float: left;
	padding: 6px;
}

.upload-btn-wrapper {
	position: relative;
	overflow: hidden;
	display: inline-block;
	border: 1px solid black;
}

.upload-btn-wrapper input[type=file] {
	font-size: 100px;
	position: absolute;
	left: 0;
	top: 0;
	opacity: 0;
}

.search {
	width: 100%;
	height: 45px;
	display: grid;
	grid-template-columns: 1fr minmax(400px, auto);
}

.input-group {
	grid-column: 2/3;
	position: relative !important;
	display: flex !important;
	flex-wrap: wrap !important;
	align-items: stretch !important;
	width: 100% !important;
}

.input-group>.form-control, .input-group>.form-select {
	position: relative;
	flex: 1 1 auto;
	width: 1%;
	min-width: 0;
}

#paging ul {
	justify-content: center !important;
}

.pagination {
	display: flex !important;
	padding-left: 0 important;
	list-style: none !important;
}

.page-item {
	padding: 0 !important;
}
</style>
</head>
<body>
	<form role="form" method="get">
		<div class="search">
			<div class="input-group mb-3">
				<select name="searchType" class="form-control"
					style="height: 30px; font-size: 0.5rem;">
					<option value="w"
						<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="t"
						<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				</select> <input type="text"
					style="height: 30px; width: 40%; font-size: 0.5rem;" name="keyword"
					value="${scri.keyword}" id="keywordInput" class="form-control"
					placeholder="" aria-label="" aria-describedby="basic-addon1">
				<div class="input-group-prepend">
					<button id="searchBtn" style="height: 30px; font-size: 0.5rem;"
						class="btn btn-outline-secondary" type="button">검색</button>
				</div>
			</div>
		</div>
	</form>
	<table class="table table-hover">
		<tr>
			<th>파일명</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>다운로드수</th>
		</tr>
		<c:forEach items="${dataList}" var="data">
			<tr>
				<td><a href="/data/fileDown?didx=${data.didx}">${data.d_title}</a></td>
				<td>${data.memberVO.t_name}</td>
				<td><fmt:parseDate var="writedate" value="${data.d_writedate}"
						pattern="yyyy-MM-dd" /> <fmt:formatDate value="${writedate}"
						pattern="yyyy-MM-dd" /></td>
				<td>${data.d_download}</td>
			</tr>
		</c:forEach>
	</table>
	<nav aria-label="Page navigation example" id="paging">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="page-item" style="color: black;"><a
					class="page-link"
					href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						<span class="sr-only"></span>
				</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li class="page-item"><a class="page-link"
					href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class="page-item"><a class="page-link"
					href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
						class="sr-only"></span>
				</a></li>
			</c:if>
		</ul>
	</nav>
	<button type="button" class="btn btn-primary btn-sm" style="background-color:#0b5ed7; float:right;" data-toggle="modal" data-target="#myModal">업로드</button>
	<script>
		$(function() {
			$('#searchBtn').click(
					function() {
						self.location = "list" + '${pageMaker.makeQuery(1)}'
								+ "&searchType="
								+ $("select option:selected").val()
								+ "&keyword="
								+ encodeURIComponent($('#keywordInput').val());
					});
		});
	</script>
</body>
</html>