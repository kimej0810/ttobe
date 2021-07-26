<%@page import="tobe.project.domain.*"%>
<%@page import="org.apache.ibatis.annotations.Select"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="tobe.project.dto.*"%>
<%@page import="java.util.*"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<%	
	PageMaker paging = (PageMaker)request.getAttribute("paging");
	List<ScheduleVO> view = (List<ScheduleVO>)request.getAttribute("viewAll"); 
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"'/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="utf-8">
		<title>게시판 일정리스트</title>
		<script src="<c:url value="/resources/static/schedule/js/scheduleBoard.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/schedule/css/scheduleBoard.css"/>" rel='stylesheet' />
	</head>
	<body>
	<div id="box">
			<div class="row" id="row">
				<div class="col-lg-12">
					<section class="panel">
			        	<form role="form" method="get">
			        	<input type="hidden" value="${pageContext.request.contextPath}" id="projectName">
			        	<input type="hidden" id="userId" name="userId" value="<%=userId%>">
			        	<div class="category">
			        		<button id="allSchedule" class="btn btn-outline-secondary" type="button">전체 일정보기</button>
			        		<button id="mySchedule" class="btn btn-outline-secondary" type="button">나의 일정보기</button>
							<button id="calendarButton" class="btn btn-outline-secondary" type="button">캘린더형</button>
							<button id="addScheduleBtn" class="btn btn-primary btn-sm float-right" onclick="scheduleAddPopup()" type="button"> 일정 추가</button>
						</div>
				        	<div class="search">
					        	<div id="searchbox" class="input-group mb-3">
					        		<input type="hidden" id="searchWord" value="${scri.searchWord}">
									<select name="searchType"  class="form-control" id="searchType">
						 				<option value="유형"<c:out value="${scri.searchType eq '유형' ? 'selected' : '' }"/>>유형</option>
										<option value="제목"<c:out value="${scri.searchType eq '제목' ? 'selected' : '' }"/>>제목</option>
										<option value="내용"<c:out value="${scri.searchType eq '내용' ? 'selected' : '' }"/>>내용</option>
										<option value="제목+내용"<c:out value="${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
										<option value="이름"<c:out value="${scri.searchType eq '사원이름' ? 'selected' : '' }"/>>사원이름</option>
									</select>
									<input type="text" id="keyword" class="form-control" name="keyword" value="${scri.keyword }">
									<div class="input-group-prepend">	
										<button type="button" id="searchBtn" class="btn btn-outline-secondary">검색</button>
									</div>
								</div>
							</div>
							<script type="text/javascript">
								$(function(){
									$("#searchBtn").on("click",function(){
										var check = $("#searchWord").val();
										self.location = "<%=request.getContextPath()%>/schedule/scheduleBoard" + '${paging.makeQuery(1)}'  + "&searchWord=" + check + "&searchType=" + $("select option:selected").val() 
										+ "&keyword=" + encodeURIComponent($('#keyword').val());
									});
									$('#allSchedule').on("click",function(){
										self.location = "<%=request.getContextPath()%>/schedule/scheduleBoard";
									});
									$("#mySchedule").on("click",function(){
										self.location = "<%=request.getContextPath()%>/schedule/scheduleBoard" + '${paging.makeQuery(1)}' + "&searchWord=나의 일정보기";
									});
								});
							</script>
				        	<div class="panel-body">
				          		<table class="table table-hover" id="board">
				          			<thead>
				          			<tr>
				          				<th scope="col" width="5%">일정 번호</th>
				          				<th scope="col" width="5%">일정 유형</th>
				          				<th scope="col" width="12%">일시</th>
				          				<th scope="col" width="15%">일정 제목</th>
				          				<th scope="col" width="15%">일정 내용</th>
				          				<th scope="col" width="5%">사원 이름</th>
				          				<th scope="col" width="5%">부서</th>
				          				<th scope="col" width="5%">직급</th>
				          			</tr> 
				          			</thead>
				          			<tbody id="scheduleDataTbody">
					          			<c:forEach items="${viewAll}" var="viewAll">
											<tr>
												<td>
						              				${viewAll.sidx }
						              			</td>
												<td scope="row">
						              				${viewAll.s_type}
						              			</td>
												<c:choose>
													<c:when test="${viewAll.s_startDate eq viewAll.s_endDate}">
														<td class="scheduleDate">
															${viewAll.s_startDate} 
														</td>
													</c:when>
													<c:otherwise>
														<td class="scheduleDate">
															${viewAll.s_startDate} ~ ${viewAll.s_endDate}
														</td>
													</c:otherwise>
												</c:choose>
												<td class="control-label scheduletitle">
													<input type="hidden" value="${viewAll.sidx}">
													<a id="scheduleLink" href="<%=request.getContextPath()%>/schedule/scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=830'); return false;">
														<c:set var="content" value="${viewAll.s_title}"/>
														<c:choose>
															<c:when test="${fn:length(viewAll.s_title) > 20}">
																<c:out value="${fn:substring(content,0,20)}"/>...
															</c:when>
															<c:otherwise>
																<c:out value="${viewAll.s_title}"/>
															</c:otherwise> 
														</c:choose>
													</a>
												</td>
												<td class="scheduleContents">
													<a id="scheduleLink" href="<%=request.getContextPath()%>/schedule/scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=830'); return false;">
														<c:set var="content" value="${viewAll.s_content}"/>
														<c:choose>
															<c:when test="${fn:length(viewAll.s_content) > 20}">
																<c:out value="${fn:substring(content,0,20)}"/>...
															</c:when>
															<c:otherwise>
																<c:out value="${viewAll.s_content}"/>
															</c:otherwise> 
														</c:choose>
													</a>
												</td>
						              			<td>${viewAll.memberVO.t_name}</td>
						              			<td>${viewAll.memberVO.t_department}</td>
						              			<td>${viewAll.memberVO.t_position}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>					
						</form>
					<!-- 페이징처리 -->
					<nav aria-label="Page navigation example" id="paging">
						<ul class="pagination">
							<c:if test="${paging.prev}">
								<li class="page-item" style="color:black;">
									<a class="page-link" href="<%=request.getContextPath()%>/schedule/scheduleBoard${paging.makeSearch(pageMaker.startPage - 1)}&userId=<%=userId %>" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									    <span class="sr-only"></span>
									</a>
								</li>
							</c:if> 
							<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
								<li class="page-item" <c:out value="${paging.cri.page == idx ? 'id=active' : ''}"/>>
									<a class="page-link" href="<%=request.getContextPath()%>/schedule/scheduleBoard${paging.makeSearch(idx)}&userId=<%=userId %>">${idx}</a>
								</li>
							</c:forEach>
							<c:if test="${paging.next && paging.endPage > 0}">
								<li class="page-item">
									<a class="page-link" href="<%=request.getContextPath()%>/schedule/scheduleBoard${paging.makeSearch(pageMaker.endPage + 1)}&userId=<%=userId %>" aria-label="Next">
									    <span aria-hidden="true">&raquo;</span>
									    <span class="sr-only"></span>
									</a>
								</li>
							</c:if> 
						</ul>
		 			</nav>
		 			</section>
				</div>
			</div>
		</div>
	</body>
</html>