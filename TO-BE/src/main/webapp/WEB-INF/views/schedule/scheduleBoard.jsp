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
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
		<style type="text/css">
			.content{
				overflow: hidden;
			}
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
			#paging{
				text-align: center;
				font-size: 20px;
			}
			.input-group{
				grid-column:2/3;
			}
			.page-item{
				padding:0;
			}
			#box{
				height: 650px;
			}
			.row{
				margin:0px auto;
				height: 134%;
				max-width: 100%;
				flex-wrap: inherit;
				background-color:white;
			}
			.panel{
				height: 90%;
			}
			#calendarButton{
   				width: 120px;
			}
			#scheduleBtn{
				text-align: right;
			}
			#aBtn{
				text-decoration : none;
				color:black;
			}
		</style>
	</head>
	<body>
	<div id="box">
			<div class="row" id="row">
				<div class="col-lg-12">
					<section class="panel">
			        	<form role="form" method="get">
			        	<input type="hidden" id="userId" name="userId" value="<%=userId%>">
			        	<div class="category">
			        		<button id="allSchedule" class="btn btn-outline-secondary" type="button">전체 일정보기</button>
			        		<button id="mySchedule" class="btn btn-outline-secondary" type="button">나의 일정보기</button>
							<button id="calendarButton" class="btn btn-outline-secondary" type="button">캘린더형</button>
						</div>
				        	<div class="search">
					        	<div id="searchbox" class="input-group mb-3">
									<select name="searchType"  class="form-control" id="searchType" style="height:30px; font-size:0.8rem;">
										<option value="전체"<c:out value="${scri.searchType == null ? 'selected' : '' }"/>>-----</option>
						 				<option value="유형"<c:out value="${scri.searchType eq '유형' ? 'selected' : '' }"/>>유형</option>
										<option value="제목"<c:out value="${scri.searchType eq '제목' ? 'selected' : '' }"/>>제목</option>
										<option value="내용"<c:out value="${scri.searchType eq '내용' ? 'selected' : '' }"/>>내용</option>
										<option value="제목+내용"<c:out value="${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
									</select>
									<input type="text" style="height:30px; width:40%; font-size:0.8rem;" id="keyword" class="form-control" name="keyword" value="${scri.keyword }">
									<div class="input-group-prepend">	
										<button type="button" id="searchBtn"  style="height:30px; font-size:0.8rem;" class="btn btn-outline-secondary">검색</button>
									</div>
								</div>
							</div>
							<script type="text/javascript">
								function scheduleAddPopup(){
									var url = "schedulePopup";
									var name = "schedulePopup";
									var option = "width = 600, height = 800 left = 100, top=50,location=no";
									window.open(url,name,option)
								}
								$(function(){
									$(document).on("click","#searchBtn",function() {
										$.ajax({
											url:"/schedule/searchSchedule",
											data: {
												searchType : $("#searchType").val(),
												keyword : $("#keyword").val()
											},
											dataType:"json",
											contentType : "application/json; charset=UTF-8",
											success:function(svo){
												var schedule = "";
												for(var i=0; i < svo.length; i++){
													schedule += "<tr><td scope='row'>"+svo[i].s_type+"</td>";
													schedule += "<td class='control-label scheduletitle'><input type='hidden' value='"+svo[i].sidx+"'>";
													schedule += "<a id='aBtn' href='#' title='scheduleContents?sidx="+svo[i].sidx+"&tidx="+svo[i].tidx+"'>"; 
													if(svo[i].s_title.length > 10){
														schedule += svo[i].s_title.substring(0,10)+"</a></td>";
													}else{
														schedule += svo[i].s_title+"</a></td>";
													}
													
													if(svo[i].s_startDate == svo[i].s_endDate){
														schedule += "<td class='scheduleDate'>"+svo[i].s_startDate+"</td><td>\</td>";
													}else{
														schedule += "<td class='scheduleDate'>"+svo[i].s_startDate+"</td><td class='scheduleDate'>"+svo[i].s_endDate+"</td>";
													}
													
													schedule += "<td class='scheduleContents'><a id='aBtn' href='#' title='scheduleContents?sidx="+svo[i].sidx+"&tidx="+svo[i].tidx+"'>";
													if(svo[i].s_content.length > 50){
														schedule += svo[i].s_content.substring(0,50)+"</a></td><td>"+svo[i].memberVO.t_name+"</td></tr>";
													}else{
														schedule += svo[i].s_content+"</a></td><td>"+svo[i].memberVO.t_name+"</td></tr>";
													}
												}
												$("#scheduleDataTbody").html(schedule);
											}
										});
									});
									$(document).on("click","#aBtn",function(){
										var url = $(this).attr("title");
										var nama = "_blank";
										var option =  "width=600, height=800";
										window.open(url,name,option);
									});
									$('#calendarButton').on("click",function(){
										location.href = "scheduleCalendar";
									});
									$('#allSchedule').on("click",function(){
										self.location = "scheduleBoard" + '${paging.makeQuery(1)}' + "&searchType=" + "&userId=" + "<%=userId%>";
									});
									$(document).on("click","#mySchedule",function(){
										self.location = "scheduleBoard" + '${paging.makeQuery(1)}' + "&searchType=나의 일정보기" + "&userId=" + "<%=userId%>";
									});
								});
							</script>
				        	<div class="panel-body">
				          		<table class="table table-hover" id="board">
				          			<thead>
				          			<tr>
				          				<th width="20px">유형</th>
				          				<th width="80px">제목</th>
				          				<th width="60px">시작일시</th>
				          				<th width="60px">종료일시</th>
				          				<th width="200px">내용</th>
				          				<th width="50px">사원이름</th>
				          			</tr>
				          			</thead>
				          			<tbody id="scheduleDataTbody">
					          			<c:forEach items="${viewAll}" var="viewAll">
											<tr>
												<td scope="row">
						              				${viewAll.s_type}
						              			</td>
						              			<td class="control-label scheduletitle">
													<input type="hidden" value="${viewAll.sidx}">
													<a href="scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=800'); return false;" style="text-decoration : none; color:black;">
														<c:set var="content" value="${viewAll.s_title}"/>
														<c:choose>
															<c:when test="${fn:length(viewAll.s_title) > 10}">
																<c:out value="${fn:substring(content,0,10)}"/>...
															</c:when>
															<c:otherwise>
																<c:out value="${viewAll.s_title}"/>
															</c:otherwise> 
														</c:choose>
													</a>
												</td>
												<c:choose>
													<c:when test="${viewAll.s_startDate eq viewAll.s_endDate}">
														<td class="scheduleDate">
															${viewAll.s_startDate}
														</td>
														<td></td>
													</c:when>
													<c:otherwise>
														<td class="scheduleDate">
															${viewAll.s_startDate}
														</td>
														<td class="scheduleDate">
															${viewAll.s_endDate}
														</td>
													</c:otherwise>
												</c:choose>
												<td class="scheduleContents">
													<a href="scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=800'); return false;" style="text-decoration : none; color:black;">
														<c:set var="content" value="${viewAll.s_content}"/>
														${fn:substring(content,0,50)}
													</a>
												</td>
						              			<td>
						             				${viewAll.memberVO.t_name}
						              			</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div id="scheduleBtn">
									<button type="button" class="btn btn-primary btn-sm float-right" onclick="scheduleAddPopup()"> 일정 추가</button>
								</div>
							</div>					
						</form>
					</section>
					<!-- 페이징처리 -->
					<nav aria-label="Page navigation example" id="paging">
						<ul class="pagination">
							<c:if test="${paging.prev}">
								<li class="page-item" style="color:black;">
									<a class="page-link" href="scheduleBoard${paging.makeSearch(pageMaker.startPage - 1)}&userId=<%=userId %>" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									    <span class="sr-only"></span>
									</a>
								</li>
							</c:if> 
							<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
								<li class="page-item">
									<a class="page-link" href="scheduleBoard${paging.makeSearch(idx)}&userId=<%=userId %>">${idx}</a>
								</li>
							</c:forEach>
							<c:if test="${paging.next && paging.endPage > 0}">
								<li class="page-item">
									<a class="page-link" href="scheduleBoard${paging.makeSearch(pageMaker.endPage + 1)}&userId=<%=userId %>" aria-label="Next">
									    <span aria-hidden="true">&raquo;</span>
									    <span class="sr-only"></span>
									</a>
								</li>
							</c:if> 
						</ul>
		 			</nav>
					<div id="paging">
					</div>
				</div>
			</div>
		</div>
	</body>
</html>