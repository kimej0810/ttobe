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
</head>
<body>
<%--    <div class="wrap">
        <div class="nav">
            <div class="logo">
                <img src="<c:url value="/resources/static/img/logo3.png"/>">
            </div>
            <div class="toggle">
                <img src="<c:url value="/resources/static/img/toggle.png"/>">
            </div>
            <div class="profile">
                <img src="<c:url value="/resources/static/img/profile.png"/>">
                <div class="name">홍길동</div>
                <div class="saown_num">201668451</div>
                <div class="dept_rank">퇴근부 / 대리</div>
                <div class="logout">로그아웃</div>
            </div>
        </div> --%>
        <div class="wrapper">
        <nav id="sidebar" class="sidebar">
            <div class="sidebar-content-wrappper">
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">일정관리</li>
                    <li class="sidebar-menu-item">근태관리</li>
                    <li class="sidebar-menu-item">게시판</li>
                    <li class="sidebar-menu-item">전자결재</li>
                    <li class="sidebar-menu-item">자료실</li>
                    <li class="sidebar-menu-item">사원정보</li>
                </ul>
            </div>
        </nav>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</body>
</html>