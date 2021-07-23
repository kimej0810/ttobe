<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 정보</title>
<meta name="viewport" content="width=device-width, initial-scal=1.0">
<link href="<c:url value="/resources/static/css/saone.css"/>" rel='stylesheet' />
<link href="<c:url value="/resources/static/css/member_list.css"/>" rel='stylesheet' />
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/static/js/member_list.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>"/>
</head>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
<%
	String domain = request.getContextPath();
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
	}else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+domain+"/member/login';</script>");
	}
%>
	<div class="contentheader" style="box-shadow:0 2px 5px lightgrey;background-color:white;">
		<div class="mainLogo" >
			<img src="<c:url value="/resources/static/img/sideImg.png"/>" style="width:225px;margin:8px 0 0 15px;">
		</div>
		<div class="search">
			<div class="input-group mb-3">
				<select id="t_department" name="t_department" class="selectBuseo form-select" style="height:30px; font-size:0.5rem;">
					<option value="all">::부서::</option>
					<option value="마케팅">마케팅</option>
					<option value="판매">판매</option>
					<option value="디자인">디자인</option>
					<option value="인사">인사</option>
					<option value="재정">재정</option>
					<option value="회계">회계</option>
				</select>
				<input type="text" style="height:30px; width:40%; font-size:0.5rem;" id="searchType" name="searchType" class="form-control">
				<input type="button" id="nameSearchBtn"  style="height:30px; font-size:0.5rem;" class="btn btn-outline-secondary" value="검색">
			</div>
		</div>
	</div>
	<div class="content">
		<div class="saone">
			<c:forEach items="${selectAllMember}" var="member">
				<div class="info">
					<input type="hidden" id="tidx" name="tidx" value="${member.tidx}">
					<c:set var="profile" value="${member.f_stored_file_name}"/>
					<c:choose>
						<c:when test="${profile == null }">
							<img src="<c:url value="/resources/static/profile/notprofile.jpg"/>" alt="프로필이미지">		
						</c:when>
						<c:otherwise>
							<img src="<c:url value="/resources/static/profile/${member.f_stored_file_name}"/>" alt="프로필이미지"  style='width:60px;height:40px;border:1px solid lightgray;'>
						</c:otherwise>
					</c:choose>
					<span>${member.t_name}</span>
					<span>${member.t_department}</span>
					<span>${member.t_position}</span>
					<span>${member.t_email}</span>
				</div>
			</c:forEach>
		</div>
		<div class="content2">
			<div class="userinfo">
				<table class="table" style="margin-top:45px;">
					<tbody id="tbodyx">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>