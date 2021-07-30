<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	String userId = (String)session.getAttribute("userId");
	Integer userTidx = (Integer)session.getAttribute("userTidx");
	String userName = (String)session.getAttribute("userName");
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>  
	<head>
		<meta charset="UTF-8">
		<title>일정 추가</title>
		<meta name="viewport" content="width=device-width, initial-scal=1.0">
		<script src="<c:url value="/resources/static/schedule/js/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/resources/static/schedule/js/jquery.datetimepicker.full.min.js"/>"></script>
		<link href="<c:url value="/resources/static/schedule/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		
		<script src="<c:url value="/resources/static/schedule/js/schedulepop.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/schedule/css/schedulePopup.css"/>" rel='stylesheet' />
	</head>
	<body>
		<input type="hidden" value="${pageContext.request.contextPath}" id="projectName">
		<div class="group" id="popupGroup">
			<div class="group-head">
				<h1 class="zTree-h1">일정 추가</h1>
			</div>
			<div class="group-body">
				<form id="scheduleData">
					<div class="domainTitle">
						<h3 class="zTree-h3">제목</h3>
					</div>
					<input type="hidden" class="tidx" name="tidx" id="tidx" value="<%=userTidx%>">
					<div class="top">
						<input type="text" class="s_title form-control" id="s_title" name="s_title" placeholder="제목을 입력하세요" autocomplete="off">
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">사원이름</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_name form-control"  name = "t_name" id = "t_name" value="<%=userName%>" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_id form-control"  name = "t_id" id = "t_id" value=<%=userId%> readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">일정 유형</h3>
					</div>
					<div  class="domain"> 
						<select class="s_type form-control" id="s_type" name="s_type">
							<option value="회사일정">회사일정</option>
							<option value="중요일정">중요일정</option>
							<option value="개인">개인용무</option>
							<option value="외근">외근</option>
							<option value="출장">출장</option>
						</select>
						<div id="imgd"><img src="<c:url value="/resources/static/img/scheduleLogo.png"/>"></div>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3 ">시작 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" autocomplete="off" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">종료 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" autocomplete="off" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">내용</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target form-control" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다" autocomplete="off"></textarea>
					</div>
					<button type="button" class="close-button btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<button type="button" class="ok-button btn btn-primary btn-sm float-right" onclick="click_ok();">확인</button>
					<button type="reset" class="reset-button btn btn-primary btn-sm float-right">다시쓰기</button>
				</form>
			</div>
		</div>
	</body>
</html>