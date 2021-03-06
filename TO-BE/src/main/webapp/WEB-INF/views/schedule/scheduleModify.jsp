<%@page import="tobe.project.dto.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tobe.project.dto.ScheduleVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	ScheduleVO vo = (ScheduleVO)request.getAttribute("vo"); 
	MemberVO mo = (MemberVO)request.getAttribute("mo");
	Integer userTidx = (Integer)session.getAttribute("userTidx");
	
	if(userTidx == null){ 
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"/member/login';</script>");
	}
%> 
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="UTF-8">
		<title>일정 수정</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<script src="<c:url value="/resources/static/schedule/js/jquery.datetimepicker.full.min.js"/>"></script>
		<link href="<c:url value="/resources/static/schedule/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		
		<script src="<c:url value="/resources/static/schedule/js/scheduleModify.js"/>"  type="text/javascript"></script>
		<link href="<c:url value="/resources/static/schedule/css/scheduleModify.css"/>" rel='stylesheet' />
		<script>
			if(<%=userTidx%> == 0 || <%=userTidx%> != <%=vo.getTidx()%>){
				alert('권한이 없습니다');
				history.back();
			}
			function click_up(){
				var startDate = $("#s_startDate").val().replace("-","/"); //치환
				var endDate = $("#s_endDate").val().replace("-","/");	//치환
				var start = new Date(startDate);						//문자열을 날짜로 변환
				var end = new Date(endDate);							//문자열을 날짜로 변환
				
				if($("#s_title").val() == "" || $("#s_title").val().length < 5 || $("#s_title").val().length > 40){
					alert("제목을 입력해주세요. [5글자 이상 40글자 이하]");
					$("#s_title").focus();
					return false;
				}else if($("#s_startDate").val() == "" || $("#s_endDate").val() == "" || start > end){
					alert("날짜를 올바르게 선택해주세요. [종료날짜보다 시작날짜가 작아야 합니다.]");
					return false;
				}else if($("#s_content").val() == "" || $("#s_content").val().length < 10 || $("#s_content").val().length > 1024){
					alert("내용을 입력해주세요. [10글자 이상 1024글자 이하]");
					$("#s_content").focus();
					return false;
				}
				
				var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
				var result = confirm("일정을 수정하시겠습니까?");
				
				if(result){
					$.ajax({
						data : scheduleData,
						url : "<%=request.getContextPath()%>/schedule/updateSchedule?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>",
						type : "POST",
						dataType : "json",
						contentType : "application/json; charset=UTF-8",
						success : function(data) {
							alert("일정 수정이 완료되었습니다.");
							opener.parent.location.reload();
							location.href="<%=request.getContextPath()%>/schedule/scheduleContents?sidx=<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>";
						},
						error:function(){
							alert("일정 수정에 실패하였습니다.");
							opener.parent.location.reload();
						}
					});
				}
			}
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
					<div class="domainTitle">
						<h3 class="zTree-h3">제목</h3>
					</div>
					<div class="top">
						<input type="text" class="s_title form-control" id="s_title" name="s_title" placeholder="제목을 입력하세요" value="<%=vo.getS_title()%>" autocomplete="off">
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">사원이름</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_name form-control"  name = "t_name" id = "t_name" value="<%=mo.getT_name() %>" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_id form-control"  name = "t_id" id = "t_id" value="<%=mo.getT_id()%>" autocomplete="off" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">일정 유형</h3>
					</div>
					<div class="domain"> 
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
						<h3 class="zTree-h3">시작 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" value="<%=vo.getS_startDate()%>" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">종료 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" value="<%=vo.getS_endDate()%>" readonly>
					</div>
					<div class="domainTitle">
						<h3 class="zTree-h3">내용</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target form-control" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다" autocomplete="off"><%=vo.getS_content()%></textarea>
					</div>
					<div class="btngroup">
						<button type="button" class="cancel-button  btn btn-primary btn-sm float-right" onclick="history.back();">취소</button> 
						<button type="button" class="ok-button  btn btn-primary btn-sm float-right" onclick="click_up()">확인</button>
						<button type="reset" class="reset-button  btn btn-primary btn-sm float-right">다시쓰기</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
