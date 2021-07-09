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
<style>
	table th{
		text-align:center;
	}
	.headerT{
		margin-bottom:45px;
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
	<div class="headerT">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button" onclick="history.back();">메일 발송함</button>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th>부서</th>
				<td>${emailRead.t_department }</td>
				<th>수신인</th>
				<td>${emailRead.t_name }</td>
				<th>직급</th>
				<td>${emailRead.t_position }</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td colspan="3">${emailRead.m_title}</td>
				<th>발송일</th>
				<td>
					<c:set var="sendDate" value="${emailRead.m_senddate}"/>
					${fn:substring(sendDate,0,16)}
				</td>
			</tr>
			<tr style="height:300px;">
				<th style="border-right: 1px solid #dee2e6;">내용</th>
				<td colspan="5">${emailRead.m_content }</td>
			</tr>
		</tbody>
	</table>
	<div>
		<a href="${path}/email/list${pageMaker.makeSearch(pageMaker.cri.page)}&midx=${emailRead.midx}">
			<button class="saoneBtn btn btn-primary btn-sm" style="float:right;">목록</button>
		</a>
	</div>
</body>
</html>