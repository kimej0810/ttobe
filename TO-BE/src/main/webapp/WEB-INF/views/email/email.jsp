<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tobe.project.dto.MemberVO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 발송</title>
</head>
<body>
<%
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
		String uGrade = (String)session.getAttribute("userGrade");
		if(!uGrade.equals("A")){
			out.println("<script>alert('접근 권한이 없습니다.');history.back();</script>");
		}
	}/* else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	} */
%>
	<form method="post" action="<%=request.getContextPath()%>/admin/emailAction">
		<%
			MemberVO memberVO = (MemberVO)request.getAttribute("member");
			if(memberVO!=null){
		%>
		수신자 이메일<input type="text" name="m_addressee" value="${member.t_email}"><br>
		<%
			}else{
		%>
			수신자 이메일<input type="text" name="m_addressee"><br>
		<%
			}
		%>
		제목<input type="text" name="m_title"><br>
		내용<textarea rows="5" cols="80" name="m_content"></textarea><br>
		<input type="submit" value="전송">
		<input type="button" onclick="history.go(-1)" value="취소">
	</form>
</body>
</html>