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
		<script src="<c:url value="/resources/static/fullcalendar/js/jquery-3.6.0.min.js"/>"></script>		
		<link href="<c:url value="/resources/static/fullcalendar/css/schedule.css"/>" rel='stylesheet' />
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
		<style type="text/css">
		</style>
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
						<input type="text" class="s_title" id="s_title" name="s_title" placeholder="제목을 입력하세요" value="<%=vo.getS_title()%>" readonly>
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
						<%=vo.getS_type()%>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">시작 날짜</h3>
					</div>
					<div class="domain">
						<input class = "date" id = "s_startDate" type = "text" name = "s_startDate" id = "s_startDate" value="<%=vo.getS_startDate()%>" readonly>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">종료 날짜</h3>
					</div>
					<div class="domain">
							<input class = "date" id = "s_endDate" type = "text" name = "s_endDate" id = "s_endDate" value="<%=vo.getS_endDate()%>" readonly>
					</div>
					<div class="domain">
						<h3 class="zTree-h3">내용</h3>
					</div>
					<div class="domain">
						<textarea class="s_content target" id="s_content" name="s_content" rows="5" cols="20" placeholder="100글자까지 입력 가능합니다" readonly><%=vo.getS_content()%></textarea>
					</div>
				</form>
				<div class="btngroup">
				<%if(vo.getTidx() == userTidx){ %>
					<button type="button" class="close-button" onclick="window.close();">닫기</button>
					<button type="button" class="delete-button" onclick="click_delete();">삭제</button>
					<button type="button" class="modify-button" onclick="click_modify();">수정</button>
				<%}else if(userGrade.equals("A")){%>
					<button type="button" class="delete-button" onclick="click_delete();">삭제</button>
					<button type="button" class="close-button" onclick="window.close();">닫기</button>
				<%}else{ %>
					<button type="button" class="close-button" onclick="window.close();">닫기</button>
				<%} %>
				</div>
				
			</div>
		</div>
	</body>
</html>