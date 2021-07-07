<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberList</title>
<meta name="viewport" content="width=device-width, initial-scal=1.0">
<link href="<c:url value="/resources/static/css/saone.css"/>" rel='stylesheet' />
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>"/>
<script>
	$(document).ready(function(){
		
		$("#t_department").on("change", function(){
			$('#searchType').val("");
			$.ajax({
				url:"/member/buseolist",
				data: $("#t_department").serialize(),
				dataType:"json",
				success:function(searchDepartmentMember){
					var solist = "";
					if(searchDepartmentMember.length>0){
						for(var i=0; i<searchDepartmentMember.length;i++){
							solist += "<div class='info'>";
							solist += "<input type='hidden' id='tidx' name='tidx' value='"+searchDepartmentMember[i].tidx+"'>";
							solist += "<img src='<c:url value='/resources/static/profile/"+searchDepartmentMember[i].f_stored_file_name+"'/>'>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_name;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_department;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_position;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_email;
							solist += "</span>";
							solist += "</div>";
						}
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}else{
						solist += "<span>";
						solist += "해당부서는 사원이 없습니다.";
						solist += "</span>";
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}
				}
			});
		});
		
		$(document).on("click",".info", function(){
			var tidx = $(this).children("#tidx").val();
			if(confirm('해당 사원에게 메일을 발송하시겠습니까?')){
				window.opener.name ="list";
				document.frm.target = "list";
				document.frm.action = "/email/email?tidx="+tidx;
				document.frm.submit();
				self.close();
			}else{
				
			}
		});
		$(document).on("click","#nameSearchBtn",function(){
			$.ajax({
				url:"/member/search",
				data:"t_department="+$('#t_department').serialize()+"&t_name="+$('#searchType').serialize(),
				dataType:"json",
				success:function(searchMember){
					var solist = "";
					if(searchMember.length>0){
						for(var i=0; i<searchMember.length;i++){
							solist += "<div class='info'>";
							solist += "<input type='hidden' id='tidx' name='tidx' value='"+searchMember[i].tidx+"'>";
							solist += "<img src='<c:url value='/resources/static/profile/"+searchMember[i].f_stored_file_name+"'/>'>";
							solist += " <span>";
							solist += searchMember[i].t_name;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_department;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_position;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_email;
							solist += "</span>";
							solist += "</div>";
						}
						$(".saone").html(solist);
					}else{
						solist += "<span>";
						solist += "해당부서는 사원이 없습니다.";
						solist += "</span>";
						$(".saone").html(solist);
					}
				}
			});
		});
	});
</script>
<style>
	#search{
		width:100%;
		display:grid;
		grid-template-columns:1fr minmax(70px, auto);
	}
	.input-group{
		grid-column:2/3;
		margin-top:15px;
	}
	.contentheader{
		grid-template-columns:1fr 2fr 0.1fr;
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
	}else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
	<div class="contentheader" style="box-shadow:0 2px 5px lightgrey;background-color:white;">
		<div class="mainLogo" >
			<img src="<c:url value="/resources/static/img/sideLogo.png"/>" style="width:50px;margin:8px 0 0 15px;">
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
		<div class="saone" style="height:400px;">
			<c:forEach items="${selectAllMember}" var="member">
				<div class="info">
					<input type="hidden" id="tidx" name="tidx" value="${member.tidx}">
					<img src="<c:url value="/resources/static/img/profile.png"/>" alt="프로필이미지">
					<span>${member.t_name}</span>
					<span>${member.t_department}</span>
					<span>${member.t_position}</span>
					<span>${member.t_email}</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<form name="frm" method="post">
	</form>
</body>
</html>