<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="tobe.project.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String domain = request.getContextPath();
	String userName = (String)session.getAttribute("userName");
	String userId = (String)session.getAttribute("userId");
	Integer userIdx = (Integer)session.getAttribute("userTidx");
	MemberDTO member = (MemberDTO)request.getAttribute("member");
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String toDate = simpleDate.format(date);
	if(userName==null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+domain+"/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>휴가 신청서</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
		#noNO{
			position: fixed;
			left: 0;
			right: 0;
			top: 0;
			bottom: 0;
			background: rgba(0,0,0,0.4);
			width: 100%;
			height: 100vh;
			text-align: center;
			display: none;
		}
		#noNO form{
		    position: absolute;
	    	top: 30%;
	    	left: 20%;
	    	width:60%;
		}
		#noCheck{
			position: fixed;
			left: 0;
			right: 0;
			top: 0;
			bottom: 0;
			background: rgba(0,0,0,0.4);
			width: 100%;
			height: 100vh;
			text-align: center;
			display: inline;
		}
		#noCheck form{
			position: absolute;
	    	top: 30%;
	    	left: 20%;
	    	width:60%;
		}
	</style>
</head>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
	<div id="tableDiv">
		<form class="form" name="frm" action="#">
			<div id="tableNum">
				<div>
					<h2>휴 가 신 청 서</h2>
				</div>
				<span>문서 번호 : ${leave.eidx}</span>
			</div>
			<c:set var="e_status" value="${leave.e_status}"/>
			<input type="hidden" id="e_status" value="${fn:trim(e_status)}">
			<input type="hidden" id="eidx" value="${leave.eidx }">
			<table class="table">
				<tr style="border-top:1px solid lightgray;">
					<th rowspan="2" style="border-left: 1px solid lightgray;vertical-align:middle;" width="20%" scope="col">결 재</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">팀 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">과 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">부 장</th>
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
						<c:set var="startDate" value="${leave.e_startday}"/>
						${fn:substring(startDate,0,10)}
					</td>
					<th scope="col" width="14%">종 료 일 자</th>
					<td scope="col">
						<c:set var="endDate" value="${leave.e_endday}"/>
						${fn:substring(endDate,0,10)}
						
					</td>
				</tr>
				<tr>
					<th>휴 가 종 류</th>
					<td>
						${leave.a_type}
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
						${leave.friend_phone }
					</td>
					<th>신청인과의 관계</th>
					<td>
						${leave.friend_name}
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
				<c:if test="${leave.e_status eq '결재대기'}">
					<input type="button" id="modifyBtn" class="btn btn-danger btn-sm" value="수정">
					<input type="button" id="delBtn" class="btn btn-danger btn-sm" value="삭제">	 
				</c:if>
				<c:if test="${leave.e_status eq '결재반려' }">
					<input type="button" id="modifyBtn" class="btn btn-danger btn-sm" value="재등록">
					<input type="button" id="delBtn" class="btn btn-danger btn-sm" value="삭제">	 
				</c:if>
				
			<%
				}else if(userId!=null){
			%>
				<c:set var="check1" value="<%=userId%>"/>
				<c:if test="${leave.teamleader == check1}">
					<c:if test="${leave.status eq '3000' }">
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-danger btn-sm noNO">반려</button>
					</c:if>
				</c:if>
				<c:if test="${leave.sectionhead == check1}">
					<c:if test="${leave.status eq '0300' }">
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-danger btn-sm noNO">반려</button>
					</c:if>
				</c:if>
				<c:if test="${leave.departmenthead == check1}">
					<c:if test="${leave.status eq '0030' }">
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-danger btn-sm noNO">반려</button>
					</c:if>
				</c:if>
				<c:if test="${leave.leader == check1}">
					<c:if test="${leave.status eq '0003' }">
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-danger btn-sm noNO">반려</button>
					</c:if>
				</c:if>
			<%
				}
			%>
			
				<input type="button" class="btn btn-primary btn-sm" onclick="window.close();" value="닫기">
			</div>
		</form>
	</div>
	<div id="noNO">
		<form name="noFrm">
			<table class="table">
				<tr>
					<th>반려자</th>
					<td><%=userName%>
						<input type="hidden" name="e_approvalNoPerson" value="<%=userName%>">
						<input type="hidden" name="eidx" value="${leave.eidx}">
					</td>
					<th>반려일</th>
					<td>
						<%=toDate%>					
					</td>
				</tr>
				<tr>
					<th>반려 사유</th>
					<td colspan="3">
						<input type="text" name="e_reason" id="e_reason" class="form-control" required="required">
					</td>
				</tr>
			</table>
			<div style="float:right;margin:0 5px 5px 0;">
				<input type="button" class="btn btn-danger btn-sm noCheck" value="반려">
				<input type="button" class="btn btn-danger btn-sm noBack" value="취소">
			</div>
		</form>
	</div>
	<c:if test="${leave.e_status eq '결재반려'}">
		<div id="noCheck">
			<form>
				<table class="table chk">
					<tr>
						<th>반려자</th>
						<td>${leave.e_approvalnoperson}</td>
						<th>반려일</th>
						<td>
							<c:set var="noDate" value="${leave.e_approvalnoday}"/>
							${fn:substring(noDate,0,16)}
						
						</td>
					</tr>
					<tr>
						<th>반려 사유</th>
						<td colspan="3">${leave.e_reason}</td>
					</tr>
				</table>
				<div style="float:right;margin:0 5px 5px 0;">
					<input type="button" id="yesBtn" class="btn btn-primary btn-sm" value="확인">
				</div>
			</form>
		</div>
	</c:if>
	<script>
	function ok(){
		var eidx = $("#eidx").val();
		Swal.fire({
			title:"결재 승인",
			text:"승인 처리 하시겠습니까?",
			icon:"question",
			showCancelButton:true,
			confirmButtonText:"승인",
			cancelButtonText:"취소"
		}).then(result => {
			if(result.isConfirmed){
				$.ajax({
					url:$("#domain").val()+"/approval/documentOk?eidx="+eidx,
					dataType:"json",
					success:function(e){
						Swal.fire("결재 승인","승인되었습니다.","success").then(result => {
							opener.parent.location.reload();
							window.close();
						});
					}
				});
			}
		});
	}
	$(document).ready(function(){
		$(document).on("click","#modifyBtn",function(){
			if($("#e_status").val()=="결재대기" || $("#e_status").val()=="결재반려"){
				var eidx = $("#eidx").val();
				Swal.fire({
					title:"결재수정",
					text:"수정페이지로 이동할까요?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"이동",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						self.location.href= $("#domain").val()+"/leave/modify?eidx="+eidx;
					}
				});
			}else{
				Swal.fire({
					title:"결재수정",
					text:"진행중인 결재는 수정이 불가능합니다.",
					icon:"warning"
				});
				return;
			}
		});
		$(document).on("click",".noBack",function(){
			$("#noNO").css("display","none");
		});
		$(document).on("click","#yesBtn",function(){
			$("#noCheck").css("display","none");
		});
		$(document).on("click","#delBtn",function(){
			if($("#e_status").val()=="결재대기" || $("#e_status").val()=="결재반려"){
				Swal.fire({
					title:"결재취소",
					text:"해당 결재를 취소하시겠습니까?",
					icon:"warning",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						Swal.fire({
							title:"결재취소",
							text:"취소된 결재내역은 삭제됩니다.",
							icon:"warning",
							showCancelButton:true,
							confirmButtonText:"확인",
							cancelButtonText:"취소"
						}).then(result => {
							if(result.isConfirmed){
								var eidx = $("#eidx").val();
								$.ajax({
									url: $("#domain").val()+"/leave/delete?eidx="+eidx,
									dataType:'json',
									success:function(e){
										if(e==1){
											opener.parent.location.reload();
											window.close();
										}else if(e==0){
											alert("삭제실패");
										}
									}
								});
								
							}
						})
					}
				});
			}
		});
		$(document).on("click",".noNO",function(){
			Swal.fire({
				title:"결재반려",
				text:"반려처리 하시겠습니까?",
				icon:"warning",
				showCancelButton:true,
				confirmButtonText:"확인",
				cancelButtonText:"취소"
			}).then(result => {
				if(result.isConfirmed){
					$("#noNO").css("display","inline");	
				}
			});
		});
		$(document).on("click",".noCheck",function(){
			var checkStr = $("#e_reason").val();
			Swal.fire({
				title:"결재반려",
				text:"반려 사유  ["+checkStr+"] 가 맞습니까?",
				icon:"warning",
				showCancelButton:true,
				confirmButtonText:"확인",
				cancelButtonText:"취소"
			}).then(result => {
				if(result.isConfirmed){
					var result = $("form[name=noFrm]").serialize();
					$.ajax({
						url: $("#domain").val()+"/leave/no",
						data:result,
						dataType:"JSON",
						success:function(e){
							if(e==1){
								Swal.fire("결재반려","반려처리 되었습니다.","success").then(result => {
									opener.parent.location.reload();
									window.close();	
								});
							}else{
								
							}
						}
					});
				}
			});
		});
	});
	</script>
</body>
</html>
