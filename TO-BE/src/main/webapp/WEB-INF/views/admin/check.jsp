<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>check</title>
</head>
<body>
<%
	String message = (String)request.getAttribute("message");
	String check = (String)request.getAttribute("check");
	String domain = request.getContextPath();
	if(check.equals("0")){
		out.println("<script>alert('"+message+"');location.href='"+domain+"/admin/join';</script>");
	}else if(check.equals("1")){
		out.println("<script>alert('"+message+"');location.href='"+domain+"/member/login';</script>");
	}
%>
</body>
</html>