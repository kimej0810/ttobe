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
	List<ScheduleVO> list = (List<ScheduleVO>)request.getAttribute("schedule"); 
	PageMaker paging = (PageMaker)request.getAttribute("paging");
	List<ScheduleVO> view = (List<ScheduleVO>)request.getAttribute("viewAll"); 
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html id="html">
	<head>
		<meta charset='utf-8' />
		
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery-3.6.0.min.js"/>"></script>
		<link href="<c:url value="/resources/static/fullcalendar/css/calendarMain.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/fullcalendar/js/calendarMain.js"/>"></script>
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				var calendarEl = document.getElementById('calendar');
			
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			    	contentHeight: 700,
			    	contentWidth:2000,
					customButtons: {
						myCustomButton: {
							text: '일정 추가',
							click: function() {
								var url = "schedulePopup";
								var name = "schedulePopup";
								var option = "width = 600, height = 730 left = 100, top=50,location=no";
								window.open(url,name,option)
							}
						},
						boardCustomButton:{
							text: '게시판으로 보기',
							click: function() {
								$("#calendar").css("display","none");
								$("#box").css("display","block");
							}
						}
					},
			    	headerToolbar: {
			    		left: 'prev,next today boardCustomButton',
				        center: 'title',
				        right: 'myCustomButton,timeGridDay,dayGridMonth'
					},
//					initialDate: '2020-09-12',  삭제시 현재날짜 focus!!
					locale : "ko", //한글로 출력하는 속성 추가
					navLinks: false, // can click day/week names to navigate views
					businessHours: true, // display business hours
					editable: false,
					selectable: false,
					dayMaxEventRows: true,
					dayMaxEvents: 3,
					events: [
					<%
					  	  for (int i = 0; i < list.size(); i++) {
					  	  	ScheduleVO vo = (ScheduleVO)list.get(i);
					%>	
			        {

			        	url:"scheduleContents?sidx="+"<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
			        	title: "<%=vo.getS_title()%>",
			        	start: "<%=vo.getS_startDate()%>",
			        	end: "<%=vo.getS_endDate()%>"
			        },
			        <%
					  	  }
					%>
			        	{
							title : 'defult',
							start : "2019-01-01",
							end : "2019-01-01"
			        	}
					],
					 eventTimeFormat: { // like '14:30:00'
						    hour: '2-digit',
						    minute: '2-digit',
						    second: '2-digit',
						    meridiem: false
					},
					eventClick: function(info) {
						info.jsEvent.preventDefault(); // don't let the browser navigate
						
						if (info.event.url) {
							var name = "scheduleContents";
							var option = "width = 600, height = 730 left = 100, top=50,location=no";
						  window.open(info.event.url,name,option);
						}
					}
				});
			    calendar.render(); 
			});
			
			
		</script>
		<style>
			.fc-myCustomButton-button, .fc-timeGridDay-button, .fc-dayGridMonth-button{
				width: 98px;
			}
			.content{
				overflow: hidden;
			}
			#calendar {
				max-width: 100%;   
				max-height: 100%;
				margin: 0px auto;
				width: 100%;
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
				display: none;
				
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
			.fc-scrollgrid-sync-table{
				height: 587px;
			}
			#calendarButton{
				margin-left: 9%;
   				width: 120px;
			}
			#scheduleBtn{
				text-align: right;
			}
		</style>
	</head>
	<body>		
		<div id='calendar' style="position: relative">
		
		</div>
		<div id="box">
			<div class="row">
				<div class="col-lg-12">
					<section class="panel">
			        	<form role="form" method="get">
			        	<div class="category">
			        		<button id="mySchedule" class="btn btn-outline-secondary" type="button">나의 일정보기</button>
							<button id="calendarButton" class="btn btn-outline-secondary" type="button">캘린더형</button>
						</div>
				        	<div class="search">
					        	<div id="searchbox" class="input-group mb-3">
									<select name="searchType"  class="form-control" id="searchType" style="height:30px; font-size:0.5rem;">
										<option value="전체"<c:out value="${scri.searchType == null ? 'selected' : '' }"/>>-----</option>
						 				<option value="유형"<c:out value="${scri.searchType eq '유형' ? 'selected' : '' }"/>>유형</option>
										<option value="제목"<c:out value="${scri.searchType eq '제목' ? 'selected' : '' }"/>>제목</option>
										<option value="내용"<c:out value="${scri.searchType eq '내용' ? 'selected' : '' }"/>>내용</option>
										<option value="제목+내용"<c:out value="${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
									</select>
									<input type="text" style="height:30px; width:40%; font-size:0.5rem;" id="keyword" class="form-control" name="keyword" value="${scri.keyword }">
									<div class="input-group-prepend">	
										<button type="button" id="searchBtn"  style="height:30px; font-size:0.5rem;" class="btn btn-outline-secondary">검색</button>
									</div>
								</div>
							</div>
							<script type="text/javascript">
								function scheduleAddPopup(){
									var url = "schedulePopup";
									var name = "schedulePopup";
									var option = "width = 600, height = 730 left = 100, top=50,location=no";
									window.open(url,name,option)
								}
								 $(function(){
									$('#calendarButton').on("click",function(){
										$("#box").css("display","none");
										$("#calendar").css("display","flex");
									});
									$('#searchBtn').on("click",function() {
										$("#calendar").css("display","none");
										$("#box").css("display","flex");
										self.location = "fullcalendar" + '${paging.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keyword').val());
									});
									$(".page-link").on("click",function(){
										$("#calendar").css("display","none");
										$("#box").css("display","flex");
									})
									$("#mySchedule").on("click",function(){
										self.location = "fullcalendar" + '${paging.makeQuery(1)}' + "&searchType=나의 일정보기" + "&userId=" + "<%=userId%>";
										$("#calendar").css("display","none");
										$("#box").css("display","flex");
									})
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
				          			<tbody>
					          			<c:forEach items="${viewAll}" var="viewAll">
											<tr>
												<td scope="row">
						              				${viewAll.s_type}
						              			</td>
						              			<td class="control-label scheduletitle">
													<input type="hidden" value="${viewAll.sidx}">
													<a href="scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=730'); return false;" style="text-decoration : none; color:black;">
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
														<td>\</td>
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
													<a href="scheduleContents?sidx=${viewAll.sidx}&tidx=${viewAll.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=730'); return false;" style="text-decoration : none; color:black;">
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
									<a class="page-link" href="fullcalendar${paging.makeSearch(pageMaker.startPage - 1)}#box" aria-label="Previous">
									    <span aria-hidden="true">&laquo;</span>
									    <span class="sr-only"></span>
									</a>
								</li>
							</c:if> 
							<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
								<li class="page-item">
									<a class="page-link" href="fullcalendar${paging.makeSearch(idx)}#box">${idx}</a>
								</li>
							</c:forEach>
							<c:if test="${paging.next && paging.endPage > 0}">
								<li class="page-item">
									<a class="page-link" href="fullcalendar${paging.makeSearch(pageMaker.endPage + 1)}#box" aria-label="Next">
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
