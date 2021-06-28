<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 상세보기</title>
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
	<table>
		<tr>
			<th>제목</th>
			<td>${emailRead.m_title}</td>
			<th>발송일</th>
			<td>
				<c:set var="sendDate" value="${emailRead.m_senddate}"/>
				${fn:substring(sendDate,0,16)}
			</td>
		</tr>
		<tr>
			<th>수신인</th>
			<th>부서</th>
			<th>직급</th>
		</tr>
		<tr>
			<td>홍</td>
			<td>부서</td>
			<td>직급</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${emailRead.m_content }</td>
		</tr>
	</table>
	<a href="${path}/admin/emaillist${pageMaker.makeSearch(pageMaker.cri.page)}&midx=${emailRead.midx}"><button>목록</button></a>
</body>
</html>