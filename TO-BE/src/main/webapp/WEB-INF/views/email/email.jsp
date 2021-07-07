<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tobe.project.dto.MemberVO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 발송</title>
<style>
	table th{
		text-align:center;
	}
</style>
</head>
<body>
<%
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
		String uGrade = (String)session.getAttribute("userGrade");
		if(!uGrade.equals("A")){
			out.println("<script>alert('접근 권한이 없습니다.');history.back();</script>");
		}
	}
%>
	<div>
		<button class="btn btn-outline-secondary" type="button" style="cursor:default;margin-bottom:45px;">메일 발송</button>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/email/emailAction">
		<table class="table">
			<%	
				if(request.getAttribute("member")!=null){
					MemberVO memberVO = (MemberVO)request.getAttribute("member");
					if(memberVO!=null){
			%>
			<tr>
				<th>수신자</th>
				<td><input type="text" name="t_name" class="form-control" value="${member.t_name}" readonly="readonly"></td>
				<th>직급</th>
				<td><input type="text" name="t_position" class="form-control" value="${member.t_position}" readonly="readonly"></td>
			</tr>
			<tr>
				<th>부서</th>
				<td><input type="text" name="t_department" class="form-control" value="${member.t_department}" readonly="readonly"></td>
				<th>수신자 이메일<input type="hidden" name="tidx" value="${member.tidx }"></th>
				<td><input type="text" name="m_addressee" class="form-control" value="${member.t_email}" readonly="readonly"></td>
			</tr>
			<%
					}
				}else{
			%>
			<tr>
				<th>수신자</th>
				<td><input type="text" name="t_name" class="form-control" required="required"></td>
				<th>직급</th>
				<td><input type="text" name="t_position" class="form-control" required="required"></td>
			</tr>
			<tr>
				<th>부서</th>
				<td><input type="text" name="t_department" class="form-control" required="required"></td>
				<th>수신자 이메일<input type="hidden" name="tidx" value="0"></th>
				<td><input type="text" name="m_addressee" class="form-control" required="required"></td>
			</tr>
			<%
				}
			%>
			<tr>
				<th>제목</th>
				<td colspan="3"><input type="text" name="m_title" class="form-control" required="required"></td>
			</tr>
			<tr style="height:300px;">
				<th>내용</th>
				<td colspan="3"><textarea rows="12" cols="80" name="m_content" class="form-control" style="resize: none;" required="required"></textarea></td>
			</tr>
		</table>
		<div style="float:right;">
			<input type="submit" class="btn btn-primary btn-sm" value="전송">
			<input type="button" class="btn btn-danger btn-sm" onclick="history.go(-1)" value="취소">
		</div>
	</form>
</body>
</html>