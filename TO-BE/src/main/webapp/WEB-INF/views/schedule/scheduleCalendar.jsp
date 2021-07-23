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
	List<LeaveDTO> leave = (List<LeaveDTO>)request.getAttribute("leave");
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='request.getContextPath()/member/login';</script>");
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
								var url = "<%=request.getContextPath()%>/schedule/schedulePopup";
								var name = "schedulePopup";
								var option = "width = 600, height = 830 left = 100, top=50,location=no";
								window.open(url,name,option)
							}
						},
						boardCustomButton:{
							text: '게시판으로 보기',
							click: function() {
								location.href="<%=request.getContextPath()%>/schedule/scheduleBoard";
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
					  	  	if(vo.getS_type().equals("회사일정")){
					%>	
			        {

					        	url:"<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
					        	title: "<%=vo.getS_title()%>",
					        	start: "<%=vo.getS_startDate()%>",
					        	end: "<%=vo.getS_endDate()%>"
			        },
			        <%
					  	  	}else if(vo.getS_type().equals("중요일정")){
					%>
					{

					        	url:"<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
					        	title: "<%=vo.getS_title()%>",
					        	start: "<%=vo.getS_startDate()%>",
					        	end: "<%=vo.getS_endDate()%>",
					        	color : "red",
				        	
				    },
					<%
					  	  	}else if(vo.getS_type().equals("외근")){
					%>
					{

					        	url:"<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
					        	title: "<%=vo.getS_title()%>",
					        	start: "<%=vo.getS_startDate()%>",
					        	end: "<%=vo.getS_endDate()%>",
					        	color : "black",
			        	
			   		},
					
					<%
					  	  	}else if(vo.getS_type().equals("출장")){
					 
					%>
					{

				        	url:"<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
				        	title: "<%=vo.getS_title()%>",
				        	start: "<%=vo.getS_startDate()%>",
				        	end: "<%=vo.getS_endDate()%>",
				        	color : "gray",
	        	
	   				},
					<%
					  	  	}else{
					%>
					{

					        	url:"<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
					        	title: "<%=vo.getS_title()%>",
					        	start: "<%=vo.getS_startDate()%>",
					        	end: "<%=vo.getS_endDate()%>",
					        	color : "#FFFF00",
					        	textColor:"black",
					        	
        	
   					},
					<%
					  	  	}
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
							var option = "width = 600, height = 830 left = 100, top=50,location=no";
						  window.open(info.event.url,name,option);
						}
					}
				});
			    calendar.render(); 
			});
		</script>
		<style type="text/css">
		a{color:black;text-decoration: none;}
		/* 토요일 색상 */
		table.fc-col-header>tbody>tr:last-child>th:last-child>div>a{color:blue}
		table.fc-scrollgrid-sync-table>tbody>tr>td:last-child>.fc-daygrid-day-frame>.fc-daygrid-day-top>a{color:blue}
		/* 일요일 색상 */
		table.fc-col-header>tbody>tr:first-child>th:first-child>div>a{color:red}
		table.fc-scrollgrid-sync-table>tbody>tr>td:first-child>.fc-daygrid-day-frame>.fc-daygrid-day-top>a{color:red}
		.fc-header-toolbar>div:nth-child(2){margin-right: 13.4%}
		
		@media (max-width:1920px) { 
			#explanation{
				position: absolute;
				right: 20.6%;
		  			top: 11.7%;
			}
		}
		@media (max-width:1820px) { 
			#explanation{
				position: absolute;
				right: 21.2%;
		  			top: 11.7%;
			}
		}
		@media (max-width:1720px) { 
			#explanation{
				position: absolute;
				right: 20.2%;
		  			top: 11.7%;
			}
		}
		@media (max-width:1620px) { 
			#explanation{
				position: absolute;
				right: 19.7%;
		  			top: 11.7%;
			}
		}
		@media (max-width:1530px) { 
			#explanation{
				position: absolute;
			    right: 19.7%;
			    top: 7.7%;
			}
		}
		@media (max-width:600px) { 
			#explanation{
				position: absolute;
				right: 9.7%;
				top: 7.7%;
			}
		}
		#explanation1{
			background-color: #0d6efd;
		    width: 13px;
		    height: 13px;
		}
		#explanation2{
			background-color: red;
		    width: 13px;
		    height: 13px;
		    margin-left: 10px;
		}
		#explanation3{
			background-color: #FFFF00;
		    width: 13px;
		    height: 13px;
		    margin-left: 10px;
		}
		#explanation4{
			background-color: black;
		    width: 13px;
		    height: 13px;
		    margin-left: 10px;
		}
		#explanation5{
			background-color: gray;
		    width: 13px;
		    height: 13px;
		    margin-left: 10px;
		}
		li{
			display: inline-block;
		}
		</style>
	</head>
	<body>		
		<div id='calendar' style="position: relative">
		</div>
		<ul id="explanation">
			<li><sub><div id="explanation1"></div></sub></li>
			<li>회사일정</li>
			<li><sub><div id="explanation2"></div></sub></li>
			<li>중요일정</li>
			<li><sub><div id="explanation3"></div></sub></li>
			<li>개인용무</li>
			<li><sub><div id="explanation4"></div></sub></li>
			<li>외근</li>
			<li><sub><div id="explanation5"></div></sub></li>
			<li>출장</li>
		</ul>
	</body>
</html>
