<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 정보</title>
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script>
	$(document).ready(function(){
		var del = $("#delyn").val();
		if(del=="Y"){
			$(".table").attr("id","byeMember");
		}
		//name
		$(document).on("click","#reName",function(){
			var name = $("#userName").text();
			var str = "";
			str += "<input type='text' id='t_name' name='t_name' class='form-control' value='"+name+"' style='height:30px;'>";
			$("#userName").html(str);
			var btn = "";
			btn += "<input type='button' id='subName' class='btn btn-primary btn-sm' value='변경하기'>";
			btn += "<input type='button' id='noName' class='btn btn-danger btn-sm' value='취소'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#noName",function(){
			var str = "";
			var btn = "";
			str += "${member.t_name}";
			$("#userName").html(str);
			btn += "<input type='button' id='reName' class='btn btn-outline-primary btn-sm' value='이름 변경'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#subName",function(){
			var reName = $("#t_name").val();
			var tidx = $("#tidx").val();
			$.ajax({
				url:"/admin/modifyName",
				data:"&reName="+reName+"&tidx="+tidx,
				dataType:"json",
				success:function(result){
					if(result==1){
						alert("정보가 변경되었습니다.");
						location.replace("/admin/info?tidx="+tidx);
					}else{
						alert("정보변경실패");
					}
				}
			});
		});
		//department
		$(document).on("click","#reDepartment",function(){
			var department = $("");
			var str = "";
			str += "<select class='form-select' id='t_department' name='t_department' style='height:30px;'>";
			str += "<option value='no'>부서 선택</option>";
			str += "<option value='마케팅'>마케팅</option>";
			str += "<option value='판매'>판매</option>";
			str += "<option value='디자인'>디자인</option>";
			str += "<option value='인사'>인사</option>";
			str += "<option value='재정'>재정</option>";
			str += "<option value='회계'>회계</option>";
			$("#userDepartment").html(str);
			var btn = "";
			btn += "<input type='button' id='subDepartment' class='btn btn-primary btn-sm' value='변경하기'>";
			btn += "<input type='button' id='noDepartment' class='btn btn-danger btn-sm' value='취소'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#noDepartment",function(){
			var str = "";
			var btn = "";
			str += "${member.t_department}";
			$("#userDepartment").html(str);
			btn += "<input type='button' id='reDepartment' class='btn btn-outline-primary btn-sm' value='부서 변경'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#subDepartment",function(){
			var result = $("#t_department").val();
			var tidx = $("#tidx").val();
			$.ajax({
				url:"/admin/modifyDepartment",
				data:"&reDepartment="+result+"&tidx="+tidx,
				dataType:"json",
				success:function(result){
					if(result==1){
						alert("정보가 변경되었습니다.");
						location.replace("/admin/info?tidx="+tidx);
					}else{
						alert("정보변경실패");
					}
				}
			});
		});
		//position
		$(document).on("click","#rePosition",function(){
			var str = "";
			var btn = "";
			str += "<select class='form-select' id='t_position' name='t_position' style='height:30px;'>";
			str += "<option value='no'>직급 선택</option>";
			str += "<option value='대표'>대표</option>";
			str += "<option value='팀장'>팀장</option>";
			str += "<option value='부장'>부장</option>";
			str += "<option value='과장'>과장</option>";
			str += "<option value='대리'>대리</option>";
			str += "<option value='사원'>사원</option>";
			$("#userPosition").html(str);
			btn += "<input type='button' id='subPosition' class='btn btn-primary btn-sm' value='변경하기'>";
			btn += "<input type='button' id='noPosition' class='btn btn-danger btn-sm' value='취소'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#noPosition",function(){
			var str = "";
			var btn = "";
			str += "${member.t_position}";
			$("#userPosition").html(str);
			btn += "<input type='button' id='rePosition' class='btn btn-outline-primary btn-sm' value='직급 변경'>";
			$(this).parent().html(btn);
		});
		$(document).on("click","#subPosition",function(){
			var result = $("#t_position").val();
			var tidx = $("#tidx").val();
			$.ajax({
				url:"/admin/modifyPosition",
				data:"&rePosition="+result+"&tidx="+tidx,
				dataType:"json",
				success:function(result){
					if(result==1){
						alert("정보가 변경되었습니다.");
						location.replace("/admin/info?tidx="+tidx);
					}else{
						alert("정보변경실패");
					}
				}
			});
		});
	});
	
</script>
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
    #byeMember{
  	background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="100%" x2="100%" y2="0" stroke="gray" /></svg>');
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
	}
%>
	<div class="headerT">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button" onclick="history.back();">사원 정보</button>
	</div>
	<form action="${path}/admin/modify${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}" method="post">
		<input type="hidden" id="tidx" name="tidx" value="${member.tidx}">
		
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
						<input type="hidden" id="delyn" value="${member.delyn}">
					</td>
				</tr>
				<tr>
					<th scope="col" width="20%">사원 번호</th>
					<td colspan="2">${member.t_id}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td id="userName">${member.t_name}</td>
					<td align="right"><input type="button" id="reName" class="btn btn-outline-primary btn-sm" value="이름 변경"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="2">${member.t_birth}</td>
				</tr>
				<tr>
					<th>부서</th>
					<td id="userDepartment">${member.t_department}</td>
					<td align="right"><input type="button" id="reDepartment" class="btn btn-outline-primary btn-sm" value="부서 변경"></td>
				</tr>
				<tr>
					<th>직급</th>
					<td id="userPosition">${member.t_position}</td>
					<td align="right" id="positionBtn"><input type="button" id="rePosition" class="btn btn-outline-primary btn-sm" value="직급 변경"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3" align="left"><a href="#">${member.t_email}</a></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="3" align="left">${member.t_phone}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td colspan="3" align="left">${member.t_addr_zipcode}</td>
				</tr>
				<tr>
					<th rowspan="3">주소</th>
					<td colspan="3" align="left">${member.t_addr_general}</td>
				</tr>
				<tr>
					<td colspan="3" align="left">${member.t_addr_detail}</td>
				</tr>
			</tbody>
		</table>
		<div class="tableBtn">
			<a href="${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}"><input type="button" class="btn btn-primary btn-sm" value="목록"></a>
			<c:set var="del" value="${member.delyn}"/>
			<c:if test="del eq 'N'">
				<a href="${path}/admin/delete?tidx=${member.tidx}"><input type="button" class="saoneBtn btn btn-danger btn-sm" value="퇴사"></a>
			</c:if>
		</div>
	</form>
</body>
</html>