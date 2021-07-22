<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>되는거야마는거야</title> 

</head>
<body>
<%
	out.println("<script>alert('로그인페이지로 이동합니다.');location.href='/member/login';</script>");
%>
</body>
</html>
