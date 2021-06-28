<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<html>
<head>
	<title>게시판</title>
	<meta charset="UTF-8">
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	<style>
		#board{
			text-align:center;
		}
		#paging ul{
			justify-content:center;
		}
		.search{
			width:100%;
			display:grid;
			grid-template-columns:1fr minmax(70px, auto);
		}
		.input-group{
			grid-column:2/3;
		}
		.page-item{
			padding:0;
		}
		#writeBtnBox{
			width:100%;
			display:grid;
			grid-template-columns:9fr minmax(30px, auto);
		}
		#writeBtn{
			grid-column:2/3;
		}
	</style>
</head>
<body>
	<form role="form" method="get">
		<div class="category">
			<button id="noticeBtn" class="btn btn-outline-secondary" type="button">공지사항</button>
			<button id="generalBtn" class="btn btn-outline-secondary" type="button">일반게시글</button>
		</div>
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
		<table class="table table-hover" id="board">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성일</th>
					<th scope="col">작성자</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList}" var="board">
					<c:if test="${board.b_type eq 'N'}">
						<tr class="table-primary">
					</c:if>
					<c:if test="${board.b_type eq 'G'}">
						<tr>
					</c:if>
						<th scope="row">${board.bidx}</td>
						<td><a href="view?bidx=${board.bidx}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}" style="text-decoration : none; color:black;">${board.b_title}</a></td>
						<td>
							<fmt:parseDate var="writedate" value="${board.b_writedate}" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${writedate}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${board.memberVO.t_name}</td>
						<td>${board.b_hit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav aria-label="Page navigation example" id="paging">
		  <ul class="pagination">
		    <c:if test="${pageMaker.prev}">
		    	<li class="page-item" style="color:black;">
			      <a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			        <span class="sr-only"></span>
			      </a>
			    </li>
		    </c:if> 
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
		    </c:forEach>
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li class="page-item">
			      <a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			        <span class="sr-only"></span>
			      </a>
			    </li>
		    </c:if> 
		  </ul>
		</nav>
		<div id="writeBtnBox">
		<%
	 		String flag = (String) request.getAttribute("flag");
			if("g".equals(flag)||"".equals(flag)||flag==null||"w".equals(flag)||"c".equals(flag)||"t".equals(flag)){
		%>
			<button type="button" class="btn btn-primary btn-sm float-right" id="writeBtn" onclick="location.href='/board/write'">등록</button>
		<%
			}
		%>
		</div>
	</form>
	<script>
      $(function(){	  
    	$('#noticeBtn').click(function(){
    	  self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=n";
    	});
    	
    	$('#generalBtn').click(function(){
	      self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=g";
	    });
    	 
        $('#searchBtn').click(function() {
          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
      });
	</script>
</body>
</html>
