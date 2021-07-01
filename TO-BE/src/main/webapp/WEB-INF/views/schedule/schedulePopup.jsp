<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	Object userId = session.getAttribute("userId");
	Object userTidx = session.getAttribute("userTidx");
	
	if(userId == null && userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>"); 
	}
%>
<!DOCTYPE html> 
<html>
	<head>
		<meta charset="UTF-8">
		<title>일정 추가</title>
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery.datetimepicker.full.min.js"/>"></script>
		<script src="<c:url value="/resources/static/fullcalendar/js/schedulepop.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/fullcalendar/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<link href="<c:url value="/resources/static/fullcalendar/css/schedule.css"/>" rel='stylesheet' />
		<script type="text/javascript">
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
				<h1 class="zTree-h1">일정 추가</h1>
			</div>
			<div class="group-body">
				<form id="scheduleData">
					<input type="hidden" class="tidx" name="tidx" id="tidx" value="<%=userTidx%>">
					<div class="top">
						<input type="text" class="s_title" id="s_title" name="s_title" placeholder="제목을 입력하세요" autocomplete="off">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_id"  name = "t_id" id = "t_id" value=<%=userId%> readonly>
					</div>
					<div  class="domain">
						<h3 class="zTree-h3">일정 유형</h3>
						<select class="s_type" id="s_type" name="s_type">
							<option value="개인">개인일정</option>
							<option value="외근">외근</option>
							<option value="출장">출장</option>
						</select>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">시작</h3>
					</div>
					<div class="domain">
						<input class = "date" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" autocomplete="off">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">종료</h3>
					</div>
					<div class="domain">
						<input class = "date" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" autocomplete="off">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">메모</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다" autocomplete="off"></textarea>
					</div>
				</form>
				<button type="button" class="ok-button" onclick="click_ok();">확인</button>
			</div>
		</div>
		
	</body>
</html>