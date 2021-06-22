<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>되는거야마는거야</title>

</head>
<body>
<p>
	<button type="button" onclick="location.href='/main'">메인페이지</button>
	
	<a href="approval/documentListMain">전자결재</a>
	<a href="/member/list">일반사원리스트</a>
	<a href="/admin/memberlist">관리자사원리스트</a>
	<a href="/admin/emaillist">발송함</a>
	<a href="/schedule/fullcalendar">륜광</a>
	<a href="/member/login">로그인</a>
	<a href="/member/findPwd">비밀번호찾기</a>
	<a href="/board/list">통합게시판</a>
	<a href="/data/list">자료실</a>
</p>
</body>
</html>
