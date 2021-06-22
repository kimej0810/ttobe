<%@page import="tobe.project.dto.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tobe.project.dto.ScheduleVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	ScheduleVO vo = (ScheduleVO)request.getAttribute("vo");
	MemberVO mo = (MemberVO)request.getAttribute("mo");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>일정 수정</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery.datetimepicker.full.min.js"/>"></script>
		<script src="<c:url value="/resources/static/fullcalendar/js/scheduleModify.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/fullcalendar/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<link href="<c:url value="/resources/static/fullcalendar/css/schedule.css"/>" rel='stylesheet' />
		<script>
			function click_up(){
				
				var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
				
				$.ajax({
					data : scheduleData,
					url : "/schedule/updateSchedule?sidx="+"<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
					type : "POST",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						opener.parent.location.reload();
						location.href="scheduleContents?sidx="+"<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>";
					}
				});
			}
			$(document).ready(function(){
				$("#s_startDate, #s_endDate").datetimepicker({
					disabledWeekDays :[0, 6]
				});
				jQuery.datetimepicker.setLocale('kr');
			})
		</script>
	</head>
	<body>
		<div class="group" id="popupGroup">
			<div class="group-head">
				<h1 class="zTree-h1">일정 수정</h1>
			</div>
			<div class="group-body">
				<form id="scheduleData">
				<input type="hidden" name="sidx" id="sidx" value="<%=vo.getSidx()%>">
				<input type="hidden" name="tidx" id="tidx" value="<%=vo.getTidx()%>">
					<div class="domain">
						<h3 class="zTree-h3">제목</h3>
					</div>
					<div class="top">
						<input type="text" class="s_title" id="s_title" name="s_title" placeholder="제목을 입력하세요" value="<%=vo.getS_title()%>">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<c:choose>
						<c:when test="${mo.getT_id() != null }">
							<div class="domain">
								<input type = "text" class="t_id"  name = "t_id" id = "t_id" value="<%=mo.getT_id()%>"autocomplete="off" readonly>
							</div>
						</c:when>
						<c:otherwise>
							<div class="domain">
								<input type = "text" class="t_id"  name = "t_id" id = "t_id" value="아이디가 없습니다"autocomplete="off" readonly>
							</div>
						</c:otherwise>
					</c:choose>
					<div  class="domain">
						<h3 class="zTree-h3">일정 유형</h3>
						<select class="s_type" id="s_type" name="s_type" value="<%=vo.getS_type()%>">
							<option value="개인">개인일정</option>
							<option value="외근">외근</option>
							<option value="출장">출장</option>
						</select>
					</div>
					
					<div class="domain">
						<h3 class="zTree-h3">시작</h3>
					</div>
					<div class="domain">
						<input class = "date" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" value="<%=vo.getS_startDate()%>">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">종료</h3>
					</div>
					<div class="domain">
						<input class = "date" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" value="<%=vo.getS_endDate()%>">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">메모</h3>
					</div>
					<div class="domain">
						<textarea class="s_content" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다"><%=vo.getS_content()%></textarea>
					</div>
					<div class="btngroup">
						<button type="button" class="ok-button" onclick="click_up()">확인</button>
						<button type="reset" class="set-button">다시쓰기</button>
					</div>
				</form>
				
			</div>
		</div>
		
	</body>
</html>