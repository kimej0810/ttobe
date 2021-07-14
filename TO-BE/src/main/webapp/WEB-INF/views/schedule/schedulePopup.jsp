<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	Object userId = session.getAttribute("userId");
	Object userTidx = session.getAttribute("userTidx");
	
	if(userId == null || userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>"); 
	}
%>
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="UTF-8">
		<title>일정 추가</title>
		<script src="<c:url value="/resources/static/schedule/js/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/resources/static/schedule/js/jquery.datetimepicker.full.min.js"/>"></script>
		<link href="<c:url value="/resources/static/schedule/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		
		<script src="<c:url value="/resources/static/schedule/js/schedulepop.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/schedule/css/schedulePopup.css"/>" rel='stylesheet' />
	</head>
	<body>
		<div class="group" id="popupGroup">
			<div class="group-head">
				<h1 class="zTree-h1">일정 추가</h1>
			</div>
			<div class="group-body">
				<form id="scheduleData">
					<div class="domain">
						<h3 class="zTree-h3">제목</h3>
					</div>
					<input type="hidden" class="tidx" name="tidx" id="tidx" value="<%=userTidx%>">
					<div class="top">
						<input type="text" class="s_title form-control" id="s_title" name="s_title" placeholder="제목을 입력하세요" autocomplete="off">
						<span id="tootip_area"></span>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_id form-control"  name = "t_id" id = "t_id" value=<%=userId%> readonly style="width: 200px">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">일정 유형</h3>
					</div>
					<div  class="domain"> 
						<select class="s_type form-control" id="s_type" name="s_type" style="width: 200px">
							<option value="회사일정">회사일정</option>
							<option value="중요일정">중요일정</option>
							<option value="개인">개인용무</option>
							<option value="외근">외근</option>
							<option value="출장">출장</option>
						</select>
					</div>
					<div class="domain">
						<h3 class="zTree-h3 ">시작 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" autocomplete="off" style="width: 200px" readonly>
						<span id="tootip_area2"></span>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">종료 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" autocomplete="off" style="width: 200px" readonly>
						<span id="tootip_area3"></span>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">내용</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target form-control" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다" autocomplete="off"></textarea>
						<span id="tootip_area4"></span>
					</div>
				<button type="button" class="close-button btn btn-primary btn-sm float-right" onclick="window.close();" style="margin-top:20px;margin-right:0px;height: 30px;">닫기</button>
				<button type="button" class="ok-button btn btn-primary btn-sm float-right" onclick="click_ok();" style="margin: 20px 15px 0px 0px; height: 30px;">확인</button>
				<button type="reset" class="reset-button btn btn-primary btn-sm float-right" style="margin:20px 15px 0px 0px; width: 80px; height: 30px;">다시쓰기</button>
				</form>
			</div>
		</div>
		
	</body>
</html>