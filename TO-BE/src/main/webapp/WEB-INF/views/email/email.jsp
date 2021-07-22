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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script>
$(document).ready(function(){
	$("#formTag").submit(function(){
		$(".loding-check").css("display","inline");
		setInterval(function(){
			$(".loding1").hide();
			setTimeout(function(){
				$(".loding1").show();
			},1000);
		},750);
		return true;
	});	
});
</script>
<style>
	table th{
		text-align:center;
	}
	.loding{
		position: fixed;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		background: rgba(0,0,0,0.4);
		width: 100%;
		height: 100vh;
		text-align: center;
	}
	.loding-check{
		display: none;
	}
	.loding-img{
		position: fixed;
		top: 50vh;
		color: white;
	}
	.content{
		height:0px;
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
	<div class="loding loding-check">
		
		<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-brightness-low loding-img" viewBox="0 0 16 16">
  			<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm.5-9.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 11a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm5-5a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm-11 0a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9.743-4.036a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm-7.779 7.779a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm7.072 0a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707zM3.757 4.464a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707z"/>
		</svg>
		<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-brightness-high loding-img loding1" viewBox="0 0 16 16">
  			<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
		</svg>
	</div>
	<div>
		<button class="btn btn-outline-secondary" type="button" style="cursor:default;margin-bottom:45px;">메일 발송</button>
	</div>
	<form id="formTag" method="post" action="<%=request.getContextPath()%>/email/emailAction">
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
			<input type="hidden" name="m_type" value="일반">
		</div>
	</form>
</body>
</html>