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
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html id="html">
	<head>
		<meta charset='utf-8'/>
		<title>캘린더 일정리스트</title>
		<link href="<c:url value="/resources/static/schedule/css/calendarMain.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/schedule/js/calendarMain.js"/>"></script>
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				var calendarEl = document.getElementById('calendar');
			
			    var calendar = new FullCalendar.Calendar(calendarEl, {
			    	contentHeight: 785,
			    	contentWidth:1500,
					customButtons: {
						myCustomButton: {
							text: '일정 추가',
							click: function() {
								var url = "schedulePopup";
								var name = "schedulePopup";
								var option = "width = 600, height = 800 left = 100, top=50,location=no";
								window.open(url,name,option)
							}
						},
						boardCustomButton:{
							text: '게시판으로 보기',
							click: function() {
								location.href="scheduleBoard";
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
							var option = "width = 600, height = 800 left = 100, top=50,location=no";
						  window.open(info.event.url,name,option);
						}
					}
				});
			    calendar.render(); 
			});
		</script>
	</head>
	<body>		
		<div id='calendar' style="position: relative">
		</div>
	</body>
</html>
