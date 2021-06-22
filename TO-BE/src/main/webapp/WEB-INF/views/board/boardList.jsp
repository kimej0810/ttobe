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

		.category{
			background-color:red;
		}
		.search{
			background-color:yellow;
		}
		.board{
			background-color:pink;
			height:100%;
			width:100%;
		}
		.paging{
			background-color:black;
			display:grid;
			grid-template-rows: 1fr 1fr 6fr 1fr;
		}
		li{
			list-style:none;
			float:left;
			padding:6px;
		}
	</style>
</head>
<body>
	<form role="form" method="get">
		<div class="category">
			<button id="noticeBtn" type="button" >공지사항</button>
			<button id="generalBtn" type="button">일반게시글</button>
		</div>
		<div class="search">
		    <select name="searchType">
		      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
		      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
		      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
		    </select>
		
		    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
		
		    <button id="searchBtn" type="button">검색</button>
		</div>

		<div class="board">
		dsafsdfasdfdsasdfsdfsdfs
		</div>
		<div class="paging">
		  <ul style="-webkit-padding-start:">

		<table class="board" border="1" style="text-align:center;">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>작성자</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList}" var="board">
					<tr>
						<td>${board.bidx}</td>
						<td><a href="view?bidx=${board.bidx}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">${board.b_title}</a></td>
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
		<div class="paging">
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
		    </c:forEach>
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
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
