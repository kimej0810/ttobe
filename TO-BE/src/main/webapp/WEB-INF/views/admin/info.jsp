<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 정보</title>
</head>
<style>
    .infoImg img{
    	width:150px;
    	height:200px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    #address{
    	width:350px;
    }
    table a{
    	text-decoration: none;
    	color:black;
    }
    .headerT{
    	margin-bottom:45px;
    }
    table th{
    	text-align:center;
    }
</style>
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
	<div class="headerT">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button" onclick="history.back();">사원 정보</button>
	</div>
	<form action="${path}/admin/modify${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}" method="post">
		<input type="hidden" name="tidx" value="${member.tidx}">
		<table class="table">
			<tbody>
				<tr>
					<td rowspan="6" scope="col" width="30%" style="text-align:center;">
						<div class="infoImg">
							<%
								if(request.getAttribute("file")!=null){
							%>
							<img src="<c:url value="/resources/static/profile/${file.f_stored_file_name}"/>">
							<%
								}else{
							%>
							등록된 프로필 사진이 없습니다.
							<%
								}
							%>
						</div>
					</td>
				</tr>
				<tr>
					<th>사원 번호</th>
					<td>${member.t_id}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${member.t_name}</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${member.t_birth}</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>${member.t_department}</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>${member.t_position}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2" align="left"><a href="#">${member.t_email}</a></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="2" align="left">${member.t_phone}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td colspan="2" align="left">${member.t_addr_zipcode}</td>
				</tr>
				<tr>
					<th rowspan="2">주소</th>
					<td colspan="2" align="left">${member.t_addr_general}</td>
				</tr>
				<tr>
					<td colspan="2" align="left">${member.t_addr_detail}</td>
				</tr>
			</tbody>
		</table>
		<div class="tableBtn">
			<input type="submit" class="btn btn-primary btn-sm" value="정보 수정">
			<a href="${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}"><input type="button" class="btn btn-primary btn-sm" value="목록"></a>
		</div>
	</form>
</body>
</html>