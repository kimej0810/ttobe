<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/static/css/bootstrap.min.css"/>"
	rel='stylesheet' />
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
<style>
#paging li {list-style: none; float: left; padding: 6px;}
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
</style>
</head>
<body>
	<button type="button" data-toggle="modal" data-target="#myModal">업로드</button>
	<div class="search">
		    <div class="input-group mb-3">
			    <select name="searchType" class="form-control" style="height:30px; font-size:0.5rem;">
			      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
			      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
			      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
			    </select>
				<input type="text" style="height:30px; width:40%; font-size:0.5rem;" name="keyword" value="${scri.keyword}" id="keywordInput" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
				<div class="input-group-prepend">
					<button id="searchBtn" style="height:30px; font-size:0.5rem;" class="btn btn-outline-secondary" type="button">검색</button>
				</div>
			</div>
		</div>
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
	<div id="paging">
		<ul>
			<c:if test="${pageMaker.prev}">
				<li><a
					href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li><a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			</c:if>
		</ul>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h4 class="modal-title">업로드</h4>
				</div>
				<div class="modal-body">
					<form action="/data/transport" method="post"
						enctype="multipart/form-data" style="height: 30px;">
						<input type="text" name="d_title" placeholder="제목을 입력해주세요...">

						<div class="upload-btn-wrapper">
							<img src='<c:url value='/resources/static/img/plus.png'/>'
								style="width: 15px;"> <input type="file" name="file">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<label for="fileFormBtn" class="btn btn-default">추가</label>
				</div>
			</div>
		</div>
	</div>
	<script>
	 $(function(){
	        $('#searchBtn').click(function() {
	          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
	        });
	      });   
	</script>
</body>
</html>