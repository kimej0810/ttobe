<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link href="<c:url value="/resources/static/css/main.css"/>" rel='stylesheet' />
    
    <%-- <link href="<c:url value="/resources/static/css/bootstrap.css"/>" rel='stylesheet' /> --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    
    <%-- <script type="text/javascript" src="<c:url value="/resources/static/js/bootstrap.js"/>"></script> --%>
    
    
    <script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</head>
<body>
<!-- 	<div class="header">
	    <div class="now">메인 페이지</div>
	    <div class="menu">
	        <div>사원관리</div>
	        <div>일정관리</div>
	        <div>근태관리</div>
	        <div>전자결재</div>
	        <div>게시판</div>
	        <div>자료실</div>
	        <div>관리자</div>
	    </div>
	</div> -->
	<div class="wrapper" style="height:65px;">
	<div class="main" style="min-height:65px;">
		<nav class="navbar">
			<div class="navbar-wrapper">
			<img src="<c:url value="/resources/static/img/toggle.png"/>" class="navbar-toggle sidebar-collapse">
			<img src="<c:url value="/resources/static/img/logo3.png"/>" class="navbar-logo">
				<div class="dropdown">
					<img src="<c:url value="/resources/static/img/profile.png"/>" class="btn btn-secondary dropdown-toggle navbar-profile" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" style="padding:0px;">
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" style="width:150px; left: -120px;">
						<li><a class="dropdown-item" href="#">홍길동님</a></li>
						<li><a class="dropdown-item" href="#">LOGOUT</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</body>
</html>