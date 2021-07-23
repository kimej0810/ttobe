<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="tobe.project.dto.MemberDTO" %>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>메인</title>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/bootstrap.js"/>"></script>
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/static/css/bootstrap.css"/>">
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/static/css/newMain.css"/>">
<style>
.sidebar-menu-item:hover {
	color: rgb(95, 129, 228);
	transition: all .3s ease;
	background-color: rgba(95, 129, 228, 0.1);
}

.sidebar-menu-item::after {
	content: '';
	width: 0%;
	left: 50%;
	height: 1px;
	display: block;
	position: absolute;
	margin-top: 3px;
	border-bottom: 3px solid rgb(95, 129, 228);
	background-color: black;
	transition: all .3s ease;
}

.sidebar-menu-item:hover::after {
	content: '';
	width: 100%;
	left: 0px;
	height: 1px;
	display: block;
	position: absolute;
	margin-top: 3px;
	border-bottom: 3px solid rgb(95, 129, 228);
	background-color: black;
	background-color: gray;
	transition: all .3s ease;
}
</style>
</head>
<body>
	<%
	//MemberDTO member = (MemberDTO) request.getAttribute("member");
	String userProfile = (String) session.getAttribute("userProfile");
	Integer userTidx = (Integer) session.getAttribute("userTidx");
	String userId = (String) session.getAttribute("userId");
	String userName = (String) session.getAttribute("userName");
	String userGrade = (String) session.getAttribute("userGrade");
	String userPosition = (String) session.getAttribute("userPosition");
	String domain = request.getContextPath();
	if (userTidx == null) {
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+domain+"/member/login';</script>");
	}
	%>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content-wrappper">
				<img id="sideImg" 
					src="<c:url value="/resources/static/img/sideImg.png"/>"
					style="width: 215px;">
				<ul class="sidebar-menu">
					<li class="sidebar-menu-item"
						onclick="location.href='${pageContext.request.contextPath}/schedule/scheduleCalendar'">
						<p class="menu-name">일정관리</p>
					</li>
					<li class="sidebar-menu-item"
						onclick="location.href='${pageContext.request.contextPath}/commute/commute?t_id=<%=userId%>'">
						<p class="menu-name">근태관리</p>
					</li>
					<li class="sidebar-menu-item" onclick="location.href='${pageContext.request.contextPath}/board/list'">
						<p class="menu-name">게시판</p>
					</li>
					<li class="sidebar-menu-item"
						onclick="location.href='${pageContext.request.contextPath}/approval/documentListMain'">
						<p class="menu-name">전자결재</p>
					</li>
					<li class="sidebar-menu-item" onclick="location.href='${pageContext.request.contextPath}/data/list'">
						<p class="menu-name">자료실</p>
					</li>
					<%
						if(userGrade!=null){
							if(userGrade.equals("A")){
					%>
						<li class="sidebar-menu-item"
							onclick="location.href='${pageContext.request.contextPath}/admin/memberlist'">
							<p class="menu-name">사원정보</p>
						</li>
					<%		
							}else{
					%>
						<li class="sidebar-menu-item"
						onclick="window.open('${pageContext.request.contextPath}/member/list','사원정보','width=900,height=630,location=no,status=no');">
						<p class="menu-name">사원정보</p>
					</li>
					<%		
							}
						}
					 %>
					
				</ul>
			</div>
		</nav>
		<div class="main">
			<nav class="navbar">
				<div class="navbar-wrapper">
					<img
						src="<c:url value="/resources/static/img/toggle.png"/>"
						class="navbar-toggle sidebar-collapse"> 
					<img
						src="<c:url value="/resources/static/img/realLogo.png"/>"
						onclick="location.href='/main/mainPage'"
						style="width: 90px; grid-column: 2/3; text-align: center; margin: auto; cursor: pointer;">
					<div>
						<c:set var="profile" value="<%=userProfile %>"/>
						<img src="<c:url value="/resources/static/profile/${profile }"/>" type="button"
							id="profile"
							style="padding: 0px; width: 50px; height:50px; border-radius: 70%;">
						<div id="dropDown" class="list-group"
							style="width: 130px; height: 50px; position: absolute; right: 25px; text-align:center;">
							<a href="#" class="list-group-item list-group-item-action"
								onclick="location.href='${pageContext.request.contextPath}/member/mypage?tidx=<%=userTidx%>'">
								<%=userName %>님
							</a>
							<a href="#" class="list-group-item list-group-item-action"
								onclick="location.href='${pageContext.request.contextPath}/member/myHome?userIdx=<%=userTidx%>'">
								정보
							</a>
							<%
							if(userGrade!=null){
								if(userGrade.equals("A")){
							%>
								<a href="#" class="list-group-item list-group-item-action"
								onclick="location.href='${pageContext.request.contextPath}/email/list'">메일함</a>
							<%
								}
							}
							%>
							<a href="#" class="list-group-item list-group-item-action"
								onclick="location.href='${pageContext.request.contextPath}/member/logout'"> 로그아웃 </a>
						</div>
					</div>

				</div>
			</nav>
			<main class="content">
</body>
<script>
	$(document).ready(function() {
		var width = $(window).width();
		var main = $('.main');
		$("#dropDown").toggle();
		$('.navbar-toggle').off().on('click', function() {
			$('.sidebar').toggleClass('active');
		});
		$('#profile').on('click', function() {
			$("#dropDown").toggle();
		});

	});
</script>
</html>
