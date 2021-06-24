<%@page import="tobe.project.domain.*"%>
<%@page import="org.apache.ibatis.annotations.Select"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="tobe.project.dto.*"%>
<%@page import="java.util.*"%>
<%	
	List<ScheduleVO> list = (List<ScheduleVO>)request.getAttribute("schedule"); 
	PageMaker paging = (PageMaker)request.getAttribute("paging");
	List<ScheduleVO> view = (List<ScheduleVO>)request.getAttribute("viewAll");
	Object userName = session.getAttribute("userName");
%>
<!DOCTYPE html>
<html id="html">
	<head>
		<meta charset='utf-8' />
		
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery-3.6.0.min.js"/>"></script>
		<link href="<c:url value="/resources/static/fullcalendar/css/calendarMain.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/fullcalendar/js/calendarMain.js"/>"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				var calendarEl = document.getElementById('calendar');
			
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			    	contentHeight: 620,
					customButtons: {
						myCustomButton: {
							text: '일정 추가',
							click: function() {
								var url = "schedulePopup";
								var name = "schedulePopup";
								var option = "width = 620, height = 680 left = 100, top=50,location=no";
								window.open(url,name,option)
							}
						},
						boardCustomButton:{
							text: '게시판으로 보기',
							click: function() {
								location.href="#table";
							}
						}
					},
			    	headerToolbar: {
			    		left: 'prev,next today boardCustomButton',
				        center: 'title',
				        right: 'myCustomButton'
					},
//					initialDate: '2020-09-12',  삭제시 현재날짜 focus!!
					locale : "ko", //한글로 출력하는 속성 추가
					navLinks: true, // can click day/week names to navigate views
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

			        	url:"scheduleContents?sidx="+"<%=vo.getSidx()%>",
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
							var option = "width = 620, height = 730 left = 100, top=50,location=no";
						  window.open(info.event.url,name,option);
						}
					}
				});
			   

			    calendar.render(); 
			});
		</script>
		<style>
			.fc-myCustomButton-button{
				width: 270px;
			}
			body{
			  margin: 40px 10px;
			  padding: 0;
			  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
			  font-size: 14px;
			  overflow: hidden;
			  }
			#calendar {
			  max-width: 1100px;
			  margin: 0 auto;
			}
			#centerContents{
				height: 1000px;
			}
			#calendarImg{
				width: 130px;
				height: 75px;
			}
			#calendarButton{
				width:40px;
				margin-left:23%;
				padding: 0px;
			    border: none;
			    position: absolute;
			}
			.boardSchedule{
				border:1px solid red; 
				margin:0px auto;
				border-spacing: 5px;
				border-collapse: separate;
			}
			#table{
				font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
				font-size: 1.75em;
				width: 170px;
				margin: 0px auto;
			}
			#paging{
				text-align: center;
				font-size: 20px;
			}
			#box{
				height: 650px;
			}
			.row{
				height: 113%;
				flex-wrap: inherit;
			}
			.panel{
				height: 90%;
			}
			#searchbox{
				text-align: right;
				height: 40px;
			}
			.fc-scrollgrid-sync-table{
				height: 587px;
			}
			#frm{
				width: 70%;
    			margin: 0px auto;
			}
			td:not(.scheduleDate){
				text-align: center;
			}
			td, th{
				border: 1px solid black;
			}
		</style>
	</head>
	<body>		
		<div id='calendar' style="position: relative">
		</div>
		
		<div id="centerContents">
		</div>
		<div id="box">
			<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<button id="calendarButton">
							<a href="#html">
								<img src="<c:url value="/resources/static/img/calendar.jpg"/>" id="calendarImg">
							</a>
						</button>
			        	<header class="panel-heading" id="table">
			          		<h2>일정 게시판</h2>
			        	</header>
			        	<form role="form" method="get" id="frm">
			        	<div id="searchbox">
								<select name="searchType" id="searchType"style="height: 27px;">
									<option value="전체"<c:out value="${scri.searchType == null ? 'selected' : '' }"/>>-----</option>
									<option value="유형"<c:out value="${scri.searchType eq '유형' ? 'selected' : '' }"/>>유형</option>
									<option value="제목"<c:out value="${scri.searchType eq '제목' ? 'selected' : '' }"/>>제목</option>
									<option value="내용"<c:out value="${scri.searchType eq '내용' ? 'selected' : '' }"/>>내용</option>
									<option value="제목+내용"<c:out value="${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
								</select>
								<input type="text" id="keyword" name="keyword" value="${scri.keyword }">
								<button type="button" id="searchBtn">검색</button>
							</div>
							<script type="text/javascript">
								 $(function(){
									$('#searchBtn').click(function() {
										self.location = "fullcalendar" + '${paging.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keyword').val())+ "#table";
									});
								});
							</script>
				        	<div class="panel-body">
				        	<%=userName%>
				          		<table class="boardSchedule">
				          			<tr class="form-group" style="text-align: center;">
				          				<th width="80px">유형</th>
				          				<th width="180px">제목</th>
				          				<th width="150px">시작일시</th>
				          				<th width="150px">종료일시</th>
				          				<th width="400px">내용</th>
				          				<th width="80px">사원이름</th>
				          			</tr>
				          			<c:forEach items="${viewAll}" var="viewAll">
										<tr class="form-group">
											<td>
					              				${viewAll.s_type}
					              			</td>
					              			<td class="control-label scheduletitle">
												<input type="hidden" value="${viewAll.sidx}">
												${viewAll.s_title}
											</td>
											<c:choose>
												<c:when test="${viewAll.s_startDate eq viewAll.s_endDate}">
													<td class="scheduleDate">
														${viewAll.s_startDate}
													</td>
													<td>
													</td>
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
										 		<label>
										 			<a href="scheduleContents?sidx=${viewAll.sidx}" onclick="window.open(this.href, '_blank', 'width=620, height=730'); return false;">${viewAll.s_content}</a>
										 			</label>
											</td>
					              			<td>
					             				${viewAll.memberVO.t_name}
					              			</td>
										</tr>
									</c:forEach>
								</table>
							</div>					
						</form>
					</section>
					<!-- 페이징처리 -->
					<div id="paging">
					<%
						if(paging.isPrev() == true){
					%>
							<a href="/schedule/fullcalendar<%= paging.makeSearch(paging.getStartPage()-1)%>#table">&lt;</a>
					<%		
						}
						for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++){
					%>
								<a href="/schedule/fullcalendar<%= paging.makeSearch(i) %>#table"><%=i %></a>
					<%			
						}
						if(paging.isNext() && paging.getEndPage()>0){
					%>
							<a href="/schedule/fullcalendar<%= paging.makeSearch(paging.getEndPage()+1) %>#table">&gt;</a>
					<%			
						}
					%>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
