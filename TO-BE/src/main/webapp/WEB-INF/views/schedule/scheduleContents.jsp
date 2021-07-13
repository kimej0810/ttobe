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
	int userTidx = (int)session.getAttribute("userTidx");
	String userGrade = (String) session.getAttribute("userGrade");
	
	if(userTidx == 0){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="UTF-8">
		<title>일정 상세</title>
		<script src="<c:url value="/resources/static/schedule/js/jquery-3.6.0.min.js"/>"></script>		
		<link href="<c:url value="/resources/static/css/bootstrap.css"/>" rel="stylesheet">
		<link href="<c:url value="/resources/static/schedule/css/scheduleContents.css"/>" rel='stylesheet' />
		<script>
			function click_modify(){
					alert("일정 수정페이지로 이동합니다.");
					location.href="scheduleModify?sidx="+"<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>";
			};
			function click_delete(){
				var result = confirm("일정을 삭제하시겠습니까?");
				if(result){
					location.href="scheduleDelete?sidx="+"<%=vo.getSidx()%>&tidx=<%=vo.getTidx()%>";
					alert("일정이 삭제되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			}
		</script>
	</head>
	<body>
		<div class="group" id="popupGroup">
			<div class="group-head">
				<h1 class="zTree-h1">일정 상세내용</h1>
			</div>
			<div class="group-body">
				<form id="scheduleData">
				<input type="hidden" name="sidx" id="sidx" value="<%=vo.getSidx()%>">
				<input type="hidden" name="tidx" id="tidx" value="<%=vo.getTidx()%>">
					<div class="domain">
						<h3 class="zTree-h3">제목</h3>
					</div>
					<div class="top">
						<input type="text" class="s_title form-control" id="s_title" name="s_title" value="<%=vo.getS_title()%>" readonly>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">사원번호</h3>
					</div>
					<div class="domain">
						<input type = "text" class="t_id form-control"  name = "t_id" id = "t_id" value="<%=mo.getT_id()%>" readonly style="width: 200px">
					</div>
					<div  class="domain">
						<h3 class="zTree-h3">일정 유형</h3>
					</div>
					<div  class="domain"> 
						<input type = "text" class="s_type form-control" id="s_type" name="s_type" style="width: 200px" value="<%=vo.getS_type()%>" readonly>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">시작 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date form-control" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" value="<%=vo.getS_startDate()%>" readonly  style="width: 200px">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">종료 날짜</h3>
					</div>
					<div class="domain">
							<input class = "date form-control" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" value="<%=vo.getS_endDate()%>" readonly  style="width: 200px">
					</div>
					<div class="domain">
						<h3 class="zTree-h3">내용</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target form-control" id="s_content" name="s_content" rows="5" cols="20" readonly><%=vo.getS_content()%></textarea>
					</div>
				</form>
				<%if(vo.getTidx() == userTidx){ %>
					<button type="button" class="delete-button btn btn-outline-danger btn-sm" onclick="click_delete();" style="margin-top:20px; height: 30px;">삭제</button>
					<button type="button" class="close-button btn btn-primary btn-sm float-right" onclick="window.close();" style="margin: 20px 15px 0px 0px;height: 30px;">닫기</button>
					<button type="button" class="modify-button btn btn-primary btn-sm float-right" onclick="click_modify();" style="margin:20px 15px 0px 0px; width: 80px; height: 30px;">수정</button>
				<%}else if(userGrade.equals("A")){%>
					<button type="button" class="delete-button btn btn-outline-danger btn-sm" onclick="click_delete();" style="margin-top:20px; height: 30px;">삭제</button>
					<button type="button" class="close-button btn btn-primary btn-sm float-right" onclick="window.close();" style="margin: 20px 15px 0px 0px; height: 30px;">닫기</button>
				<%}else{ %>
					<button type="button" class="close-button btn btn-primary btn-sm float-right" onclick="window.close();" style="margin-top:20px;height: 30px;">닫기</button>
				<%} %>
			</div>
		</div>
	</body>
</html>