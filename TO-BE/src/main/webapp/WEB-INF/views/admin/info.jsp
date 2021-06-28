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
    .sub{
	    width: 100%;
	    height: 98vh;
	    padding:1%;
    }
    .infoImg img{
    	width:150px;
    	height:200px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    .saoneBtn{
    	width:100px;
    	height:30px;
	    border-radius: 5px;
	    background-color: #ffd4006e;
    }
    #address{
    	width:350px;
    }
    table a{
    	text-decoration: none;
    	color:black;
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
	<div class="sub">
		<div class="headerT"><h1>사원 정보</h1></div>
		<div class="formDiv">
			<form action="${path}/admin/modify${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}" method="post">
				<input type="hidden" name="tidx" value="${member.tidx}">
				<table>
					<colgroup>
						<col width="20%"></col>
						<col width="80%"></col>
					</colgroup>
					<tbody>
						<tr>
							<td rowspan="6">
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
							<td>
								<label><h2>사원 번호</h2></label>
							</td>
							<td>${member.t_id}</td>
						</tr>
						<tr>
							<td>
								<label><h2>이름</h2></label>
							</td>
							<td>${member.t_name}</td>
						</tr>
						<tr>
							<td>
								<label><h2>생년월일</h2></label>
							</td>
							<td>${member.t_birth}</td>
						</tr>
						<tr>
							<td>
								<label><h2>부서</h2>
							</td>
							<td>${member.t_department}</td>
						</tr>
						<tr>
							<td>
								<label><h2>직급</h2>
							</td>
							<td>${member.t_position}</td>
						</tr>
						<tr>
							<td><h2>이메일</h2></td>
							<td colspan="2" align="left"><a href="#">${member.t_email}</a></td>
						</tr>
						<tr>
							<td><h2>연락처</h2></td>
							<td colspan="2" align="left">${member.t_phone}</td>
						</tr>
						<tr>
							<td><h2>우편번호</h2></td>
							<td colspan="2" align="left">${member.t_addr_zipcode}</td>
						</tr>
						<tr>
							<td rowspan="2"><h2>주소</h2></td>
							<td colspan="2" align="left">${member.t_addr_general}</td>
						</tr>
						<tr>
							<td colspan="2" align="left">${member.t_addr_detail}</td>
						</tr>
					</tbody>
				</table>
				<div class="tableBtn">
					<input type="submit" class="saoneBtn" value="정보 수정">
					<a href="${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}"><input type="button" class="saoneBtn" value="목록"></a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>