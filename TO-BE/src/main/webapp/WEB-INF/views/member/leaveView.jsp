<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="tobe.project.dto.*" %>
<%
	String userName = (String)session.getAttribute("userName");
	MemberDTO member = (MemberDTO)request.getAttribute("member");
	if(userName==null){
		out.println("<script>alert('잘못된 접근입니다.');window.close();</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>휴가 신청서</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<style>
/* 		html{
			min-width:650px;
		} */
		body{
			background-color: lightgray;
		}
		table th{
			text-align: center;
			border-left: 1px solid lightgray;
		}
		form{
			outline: 2px solid black;
			font-size: 0.9em;
			background-color: white;
		}
		#tableDiv{
			padding: 2%;
		}
		table td{
			border-left: 1px solid lightgray;
		}
		textarea{
			resize: none;
		}
		.form-control, .form-select{
			height: 30px;
			font-size: 0.7em;
		}
		#tableNum{
			font-size: 0.75em;
			margin-right: 1%;
			padding-top: 1%;
			text-align:center;
		}
		#tableNum span{
			float:left;
		}
		.calendar{
			cursor: pointer;
		}
		.tooltip-inner{
			background-color: red;
		}
	</style>
	<script>

	</script>
</head>
<body>
	<div id="tableDiv">
		<form class="form" name="frm" action="#">
			<div id="tableNum">
				<div>
					<h2>휴 가 신 청 서</h2>
				</div>
				<span>문서 번호 : ${leave.e_documentnum }</span>
			</div>
			<c:set var="e_status" value="${leave.e_status}"/>
			<input type="hidden" id="e_status" value="${fn:trim(e_status)}">
			<input type="hidden" id="eidx" value="${leave.eidx }">
			<table class="table">
				<tr style="border-top:1px solid lightgray;">
					<th rowspan="2" style="border-left: 1px solid lightgray;vertical-align:middle;" width="20%" scope="col">결 재</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">팀 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">부 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">과 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">대 표</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">상 태</th>
				</tr>
				<tr>
					<td style="text-align:center;">
						<c:choose>
							<c:when test="${leave.status eq '3000'}">
								예정
							</c:when>
							<c:when test="${leave.status eq '3333'}">
								반려
							</c:when>
							<c:otherwise>
								승인
							</c:otherwise>
						</c:choose>
					</td>
					<td style="text-align:center;">
						<c:choose>
							<c:when test="${leave.status eq '3000'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0300'}">
								예정
							</c:when>
							<c:when test="${leave.status eq '3333'}">
								반려
							</c:when>
							<c:otherwise>
								승인
							</c:otherwise>
						</c:choose>
					</td>
					<td style="text-align:center;">
						<c:choose>
							<c:when test="${leave.status eq '3000'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0300'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0030'}">
								예정
							</c:when>
							<c:when test="${leave.status eq '3333'}">
								반려
							</c:when>
							<c:otherwise>
								승인
							</c:otherwise>
						</c:choose>
					</td>
					<td style="text-align:center;">
						<c:choose>
							<c:when test="${leave.status eq '3000'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0300'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0030'}">
								대기
							</c:when>
							<c:when test="${leave.status eq '0003'}">
								예정
							</c:when>
							<c:when test="${leave.status eq '3333'}">
								반려
							</c:when>
							<c:otherwise>
								승인
							</c:otherwise>
						</c:choose>
					</td>
					<td style="text-align:center;">
						<c:choose>
							<c:when test="${leave.status eq '0000' }">
								결재 승인
							</c:when>
							<c:when test="${leave.status eq '3333' }">
								결재 반려
							</c:when>
							<c:otherwise>
								결재 대기
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
			<table class="table">
				<tr style="border-top:1px solid lightgray;">
					<th scope="col" width="14%">신 청 일 자</th>
					<td scope="col">${leave.e_draftdate}
					</td>
					<th scope="col" width="14%">시 작 일 자</th>
					<td scope="col">
						<c:set var="startDate" value="${leave.a_startdate}"/>
						${fn:substring(startDate,0,10)}
					</td>
					<th scope="col" width="14%">종 료 일 자</th>
					<td scope="col">
						<c:set var="endDate" value="${leave.a_enddate}"/>
						${fn:substring(endDate,0,10)}
						
					</td>
				</tr>
				<tr>
					<th>휴 가 종 류</th>
					<td>
						${leave.e_rule}
					</td>
					<th>신 청 자</th>
					<td>${member.t_name }</td>
					<th>부 서</th>
					<td>${member.t_department }</td>
				</tr>
				<tr>
					<th>신 청 일 수</th>
					<td>
						${leave.a_useddays }
					</td>
					<th>비상연락망</th>
					<td>
						${leave.e_con }
					</td>
					<th>관 계</th>
					<td>
						${leave.e_send}
					</td>
				</tr>
				<tr>
					<th>제 목</th>
					<td colspan="5">
						${leave.e_texttitle}
					</td>
				</tr>
				<tr>
					<th style="vertical-align:middle;">내 용</th>
					<td colspan="5" style="height:200px;">
						${leave.e_textcontent}
					</td>
				</tr>
				<tr>
					<th>신 청 일 자</th>
					<td>${leave.e_draftdate}</td>
					<th>신 청 인</th>
					<td>${member.t_name}</td>
					<td colspan="2">
						<span>위 사유로 휴가를 신청합니다.</span>
					</td>
				</tr>
			</table>
			<div style="float:right;">
			<%
				if(userName.equals(member.getT_name())){
			%>
				<input type="button" id="modifyBtn" class="btn btn-danger btn-sm" value="수정">
				<input type="button" id="delBtn" class="btn btn-danger btn-sm" value="삭제"> 
			<%
				}
			%>
				<input type="button" class="btn btn-primary btn-sm" onclick="window.close();" value="닫기">
			</div>
		</form>
	</div>
	<script>
	$(document).ready(function(){
		$(document).on("click","#modifyBtn",function(){
			var eidx = $("#eidx").val();
			self.location.href="/member/leaveModify?eidx="+eidx;
			
		});
		$(document).on("click","#delBtn",function(){
			if($("#e_status").val()=="결재대기"){
				if(confirm("해당 결재를 취소하시겠습니까?")){
					if(confirm("취소된 결재내역은 삭제됩니다.")){
						var eidx = $("#eidx").val();
						$.ajax({
							url:"/member/leaveDelete?eidx="+eidx,
							dataType:'json',
							success:function(e){
								if(e==1){
									alert("삭제되었습니다.");
									opener.parent.location.reload();
									window.close();
								}else if(e==0){
									alert("삭제실패");
								}
							}
						});
					}
				}
			}
		});
	});
	</script>
</body>
</html>