<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home33</title>
</head>
<body>
<p>
	<button type="button" onclick="location.href='/main'">메인페이지</button>
	
	<a href="/member/list">일반사원리스트</a>
	<a href="/admin/memberlist">관리자사원리스트</a>
	<a href="/admin/add2">관리자사원리스트2</a>
	<a href="/admin/email">메일발송</a>
	<a href="/admin/emaillist">발송함</a>
	<a href="/admin/sendlist2">발송함연습</a>
	<a href="/schedule/fullcalendar">륜광</a>
	<a href="/admin/emaillist">페이징연습</a>
	<a href="/member/login">로그인</a>
	<a href="/member/findPwd">비밀번호찾기</a>
</p>
</body>
</html>
