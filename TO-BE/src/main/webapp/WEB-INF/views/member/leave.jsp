<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yy/MM/dd");
	String toDate = simpleDate.format(date);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>휴가 신청</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	<script src="<c:url value="/resources/static/js/bootstrap-datepicker.js"/>"></script>
	<script src="<c:url value="/resources/static/js/bootstrap-datepicker.ko.min.js"/>"></script>
	<link rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap-datepicker.css"/>"/>
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
	$(document).ready(function(){
		$(document).on("focusout","#e_con",function(){
			var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
			if(!regExp.test($("input[id='e_con']").val())){
				$("#e_con").attr("title","형식이 맞지 않습니다. [예 : 010-0000-0000]");
				$("#e_con").tooltip({
						animation: true,
						container:"#tootip_area2",
						delay:{show:50,hide:10},
						html:false,
						template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
						trigger:'manual'
					});
				$("#e_con").tooltip('show');
				$("#e_con").val("");
				$("#e_con").focus();
			}else{
				$("#e_con").tooltip('hide');
			}
		});
		$("#startDay").click(function(){
			$("#startD").datepicker({
				format:"yy/mm/dd",
				startDate:'+1d',
				autoclose:true,
				daysOfWeekDisabled:[0,6],
				title:"시작날짜",
				todayHighlight:true,
				language:"ko"
			}).on('changeDate',function(selectedDate){
					if($("#endD").val()!=""){
						if($("#startD").val() > $("#endD").val()){
							$("#startD").datepicker('setDate',new Date($("#endD").val()));
							return;
						}
					}
			});
		});
		$("#endDay").click(function(){
			$("#endD").datepicker({
				format:"yy/mm/dd",
				startDate:'+1d',
				autoclose:true,
				daysOfWeekDisabled:[0,6],
				title:"종료날짜",
				todayHighlight:true,
				language:"ko"
			}).on('changeDate',function(){
				if($(this).val()!=""){
					if($("#endD").val() < $("#startD").val()){
						$(this).datepicker('setDate', new Date($("#startD").val()));
					}
				}
			});
		});
		$("#subBtn").on("click",function(){
			if($("#t_name").val()!=$("#t_name2").val()){
				$("#t_name2").val("");
				alert("신청자와 이름이 다릅니다.");
			}
			$("#a_type").val($("#e_type").val());
			$("#a_startdate").val($("#startD").val());
			var result = $("form[name=frm]").serialize();
			$.ajax({
				url: "/member/leaveAction",
				data:result,
				type:"POST",
				dataType: "json",
				success:function(e){
					alert("신청이 완료되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			});
		});
/* 		$("#endD").on("focusout",function(){
			var stDate = new Date($("#startD").val());
			var enDate = new Date($("#endD").val());
			var chDate = enDate - stDate;
			var reDate = chDate/(1000*60*60*24);
			alert(reDate);
			$("#u_useddays").val(reDate);
		}); */
	});
	</script>
</head>
<body>
	<div id="tableDiv">
		<form class="form" name="frm" action="#">
			<div id="tableNum">
				<div>
					<h2>휴 가 신 청 서</h2>
				</div>
				<span>문서 번호 :</span>
			</div>
			<table class="table">
				<tr style="border-top:1px solid lightgray;">
					<th rowspan="2" style="border-left: 1px solid lightgray;vertical-align:middle;" width="20%" scope="col">결 재</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">담 당</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">팀 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">부 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">과 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%" scope="col">대 표</th>
				</tr>
				<tr>
					<td style="text-align:center;">${member.t_name }</td>
					<td>
						<select class="form-select" name="teamleader" required="required">
							<option value="no">선 택</option>
							<c:choose>
								<c:when test="${member.t_position eq '팀장' || member.t_position eq '부장' || member.t_position eq '과장'}">
									<option value="null" selected="selected">선택불가</option>
								</c:when>
								<c:otherwise>
									<c:forEach items="${memberList}" var="list">
										<c:if test="${list.t_position eq '팀장' }">
											<c:if test="${list.t_department eq member.t_department}">
												<option value="${list.t_id}">${list.t_name}</option>
											</c:if>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td>
						<select class="form-select" name="departmenthead" required="required">
							<option value="no">선 택</option>
							<c:choose>
								<c:when test="${member.t_position eq '부장' || member.t_position eq '과장'}">
									<option value="null" selected="selected">선택불가</option>
								</c:when>
								<c:otherwise>
									<c:forEach items="${memberList}" var="list">
										<c:if test="${list.t_position eq '부장' }">
											<c:if test="${list.t_department eq member.t_department}">
												<option value="${list.t_id}">${list.t_name}</option>
											</c:if>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td>
						<select class="form-select" name="sectionhead" required="required">
							<option value="no">선 택</option>
							<c:choose>
								<c:when test="${member.t_position eq '과장'}">
									<option value="null" selected="selected">선택불가</option>
								</c:when>
								<c:otherwise>
									<c:forEach items="${memberList}" var="list">
										<c:if test="${list.t_position eq '과장' }">
											<c:if test="${list.t_department eq member.t_department}">
												<option value="${list.t_id}">${list.t_name}</option>
											</c:if>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td>
						<select class="form-select" required="required" name="leader">
							<option value="no">선 택</option>
							<c:forEach items="${memberList}" var="list">
								<c:if test="${list.t_position eq '대표' }">
									<option value="${list.t_id}" selected="selected">${list.t_name}</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			<table class="table">
				<tr style="border-top:1px solid lightgray;">
					<th scope="col" width="14%">신 청 일 자</th>
					<td scope="col"><%=toDate %>
						<input type="hidden" name="e_draftdate" value="<%=toDate %>">
					</td>
					<th scope="col" width="14%">시 작 일 자</th>
					<td scope="col">
						<div class="input-group">
							<label for="startD" style="display: inherit;">
							<input type="text" class="form-control" id="startD" name="e_startday" required="required">
							<input type="hidden" name="a_startdate" id="a_startdate">
								<span id="startDay" class="calendar">
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-calendar-date" viewBox="0 0 16 16">
		  								<path d="M6.445 11.688V6.354h-.633A12.6 12.6 0 0 0 4.5 7.16v.695c.375-.257.969-.62 1.258-.777h.012v4.61h.675zm1.188-1.305c.047.64.594 1.406 1.703 1.406 1.258 0 2-1.066 2-2.871 0-1.934-.781-2.668-1.953-2.668-.926 0-1.797.672-1.797 1.809 0 1.16.824 1.77 1.676 1.77.746 0 1.23-.376 1.383-.79h.027c-.004 1.316-.461 2.164-1.305 2.164-.664 0-1.008-.45-1.05-.82h-.684zm2.953-2.317c0 .696-.559 1.18-1.184 1.18-.601 0-1.144-.383-1.144-1.2 0-.823.582-1.21 1.168-1.21.633 0 1.16.398 1.16 1.23z"/>
		  								<path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
									</svg>
								</span>
							</label>
						</div>
					</td>
					<th scope="col" width="14%">종 료 일 자</th>
					<td scope="col">
						<div class="input-group">
						<label for="endD" style="display: inherit;">
							<input type="text" class="form-control" name="a_enddate" id="endD" required="required">
								<span id="endDay" class="calendar">
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-calendar-date-fill" viewBox="0 0 16 16">
										<path d="M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v1h16V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5zm5.402 9.746c.625 0 1.184-.484 1.184-1.18 0-.832-.527-1.23-1.16-1.23-.586 0-1.168.387-1.168 1.21 0 .817.543 1.2 1.144 1.2z"/>
										<path d="M16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zm-6.664-1.21c-1.11 0-1.656-.767-1.703-1.407h.683c.043.37.387.82 1.051.82.844 0 1.301-.848 1.305-2.164h-.027c-.153.414-.637.79-1.383.79-.852 0-1.676-.61-1.676-1.77 0-1.137.871-1.809 1.797-1.809 1.172 0 1.953.734 1.953 2.668 0 1.805-.742 2.871-2 2.871zm-2.89-5.435v5.332H5.77V8.079h-.012c-.29.156-.883.52-1.258.777V8.16a12.6 12.6 0 0 1 1.313-.805h.632z"/>
									</svg>
								</span>
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>휴 가 종 류</th>
					<td>
						<select class="form-select" name="e_type" id="e_type" required="required">
							<option value="null">선 택</option>
							<option value="연차">연차</option>
							<option value="월차">월차</option>
							<option value="반차">반차</option>
							<option value="병가">병가</option>
							<option value="기타">기타</option>
						</select>
						<input type="hidden" name="a_type" id="a_type">
					</td>
					<th>신 청 자</th>
					<td>${member.t_name }
						<input type="hidden" name="t_name" id="t_name" value="${member.t_name }">
						<input type="hidden" name="tidx" value="${member.tidx }">
					</td>
					<th>부 서</th>
					<td>${member.t_department }</td>
				</tr>
				<tr>
					<th>신 청 일 수</th>
					<td>
						<input type="text" class="form-control" name="u_useddays" id="u_useddays" required="required" maxlength="2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</td>
					<th>비상연락망</th>
					<td>
						<input type="text" class="form-control" name="e_con" id="e_con" required="required" maxlength="15" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');">
						<span id="tootip_area2"></span>
					</td>
					<th>관 계</th>
					<td>
						<input type="text" class="form-control" name="e_send" required="required">
					</td>
				</tr>
				<tr>
					<th>제 목</th>
					<td colspan="5">
						<input type="text" class="form-control" name="e_texttitle" required="required">
					</td>
				</tr>
				<tr>
					<th style="vertical-align:middle;">내 용</th>
					<td colspan="5">
						<textarea class="form-control" style="height:200px;" name="e_textcontent" required="required"></textarea>
					</td>
				</tr>
				<tr>
					<th>신 청 일 자</th>
					<td><%=toDate %></td>
					<th>신 청 인</th>
					<td>
						<input type="text" class="form-control" id="t_name2" required="required">
					</td>
					<td colspan="2">
						<span>위 사유로 휴가를 신청합니다.</span>
					</td>
				</tr>
			</table>
			<div style="float:right;">
				<input type="button" id="subBtn" class="btn btn-primary btn-sm" value="신청">
				<input type="button" class="btn btn-danger btn-sm" value="취소">
			</div>
		</form>
	</div>
</body>
</html>
