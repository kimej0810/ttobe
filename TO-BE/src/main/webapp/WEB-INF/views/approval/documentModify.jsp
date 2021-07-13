<%@page import="tobe.project.dto.ApprovalDTO"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	if(session.getAttribute("userTidx") == null){ 
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
	
	Integer userTidx = (Integer)session.getAttribute("userTidx");
	ApprovalDTO contents = (ApprovalDTO)request.getAttribute("contents");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>결제문서 수정페이지</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	 	
		<!-- datepicker -->
		<link href="<c:url value="/resources/static/form/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<script src="<c:url value="/resources/static/form/js/jquery.datetimepicker.full.min.js"/>"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentModify.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentModify.js"/>"></script>
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		<script type="text/javascript">
			if(<%=userTidx %> != <%=contents.getTidx()%>){
				alert('권한이 없습니다');
				history.back();
			}	 
			function click_up(){
				var draftDate = $("#e_draftDate").val().replace("-","/");
				var startDay = $("#e_startDay").val().replace("-","/");
				var draft = new Date(draftDate);
				var start = new Date(startDay);
				
				if($("#e_rule").val() == ""){
					alert("전결자를 선택해주세요.");
					$("#e_rule").focus();
					return false;
				}else if($("#e_draftDate").val() == "" || $("#e_startDay").val() == "" || draft>start){
					alert("날짜를 올바르게 선택해주세요. [시행일자보다 기안일자가 작아야 합니다.]");
					return false;
				}else if($("#e_con").val() == ""){
					alert("협의 및 결재조건을 입력해주세요. [5글자 이상 50글자 이하]");
					$("#e_con").focus();
					return false;
				}else if($("#e_send").val() == ""){
					alert("수신자를 입력해주세요. [5글자 이상 50글자 이하]");
					$("#e_send").focus();
					return false;
				}else if($("#e_textTitle").val() == "" || $("#e_textTitle").val().length < 10 || $("#e_textTitle").val().length > 80){
					alert("제목을 입력해주세요. [10글자 이상 80글자 이하]");
					$("#e_textTitle").focus();
					return false;
				}else if($("#e_textContent").val() == "" || $("#e_textContent").val().length < 30 || $("#e_textContent").val().length > 2048){
					alert("내용을 입력해주세요. [30글자 이상 2048글자 이하]");
					$("#e_textContent").focus();
					return false;
				}
				
				var draftLetterData = JSON.stringify($('form#draftLetterData').serializeObject());
				var result = confirm("수정하시겠습니까?");
				if(result){
					$.ajax({
						type:'POST',
						url:"/approval/ModifyDocumentWite?eidx="+"<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>",
						dataType:'JSON',
						data: draftLetterData,
						contentType : "application/json; charset=UTF-8",
						success: function(data){
							alert("수정이 완료되었습니다.");
							opener.parent.location.reload();
							window.close();
						}
					});
				}
			};
		</script>
	</head>
	<body>
		<form id="draftLetterData" name="draftLetterData">
		<input type="hidden" name="e_status" id="e_status" value="<%=contents.getE_status()%>">
		<input type="hidden" name="eidx" id="eidx" value="<%=contents.getEidx() %>">
		<div id="documentWrite">
			<table id="sheet0" class="sheet0">
				<col class="col0">
				<col class="col1">
				<col class="col2">
				<col class="col3">
				<col class="col4">
				<col class="col5">
				<col class="col6">
				<col class="col7">
				<col class="col8">	
				<col class="col9">
				<col class="col10">
				<col class="col11">
				<col class="col12">
				<col class="col13">
				<col class="col14">
				<tbody>
					<tr class="row0">
						<td></td>
						<td class="style24 style32" colspan="14" rowspan="5">기
							안 서</td>
					</tr>
					<tr class="row1">
					</tr>
					<tr class="row2">
					</tr>
					<tr class="row3">
					</tr>
					<tr class="row4">
					</tr>
					<tr class="row5">
						<td></td>
						<td class="style2">문 서 번 호</td>
						<td class="style44 style46" colspan="2">
							21-<input type="text" id="e_documentNum" name="e_documentNum" value="<%=contents.getE_documentNum()%>" readonly>
						</td>
						<td class="style44 style46" colspan="3">전 결 규 정</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="e_rule" name="e_rule" value="<%=contents.getE_rule()%>" >
							<span id="tootip_area"></span>
						</td>
					</tr>
					<tr class="row6">
						<td></td>
						<td class="style2">기 안 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" id="e_draftDate" name="e_draftDate" class="date" value="<%=contents.getE_draftDate()%>" autocomplete="off" readonly>
							<span id="tootip_area2"></span>
						</td>
						<td class="style33 style33" rowspan="3">결<br><br>재</td>
						<td class="style35 style36" colspan="2">담당</td>
						<td class="style35 style36" colspan="2">팀장</td>
						<td class="style35 style36" colspan="3">부장</td>
						<td class="style35 style36" colspan="2">과장</td>
						<td class="style11 s">대 표</td>
					</tr>
					<tr class="row7">
						<td></td>
						<td class="style2">시 행 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" id="e_startDay" name="e_startDay" class="date" value="<%=contents.getE_startDay()%>" autocomplete="off">
							<span id="tootip_area3"></span>
						</td>
						<td class="style38  style43" colspan="2" rowspan="2">
							<input type="text" id="charge" readonly>
						</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="teamLeader" readonly>
						</td>
						<td class="style38 style43" colspan="3" rowspan="2">
							<input type="text" id="departmentHead" readonly>
						</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="sectionHead" readonly>
						</td>
						<td class="style58 style59" rowspan="2">
							<input type="text" id="leader" readonly>
						</td>
					</tr>
					<tr class="row8">
						<td></td>
						<td class="style2 s">보 존 기 한</td>
						<td class="style34 style34" colspan="2">1년</td>
					</tr>
					<tr class="row9">
						<td></td>
						<td class="style3" rowspan="2">협 의 <br>및<br> 결 재 조 건</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="e_con" name="e_con" value="<%=contents.getE_con()%>">
							<span id="tootip_area4"></span>
						</td>
						<td class="style38 style42" colspan="3" rowspan="2">기 안 자</td>
						<td class="style38 style57" colspan="8" rowspan="2">
							<input type="text" id="t_name" name="t_name" value="${mo.t_name }" readonly>
						</td>
					</tr>
					<tr class="row10">
						<td></td>
					</tr>
					<tr class="row11">
						<td></td>
						<td class="style5">수 신 (참조)</td>
						<td class="style44 style46" colspan="2">
							<input type="text" id="e_send" name="e_send" value="<%=contents.getE_send()%>">
							<span id="tootip_area5"></span>
						</td>
						<td class="style44 style45" colspan="3">기 안 부 서</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="t_department" name="t_department" value="${mo.t_department }" readonly>
						</td>
					</tr>
					<tr class="row12">
						<td></td>
						<td class="style53 style55" colspan="14">
							<div id="title">제목 </div>
							<textarea class="target" id="e_textTitle" name="e_textTitle"><%=contents.getE_textTitle()%></textarea>
							<span id="tootip_area6"></span>
						</td>
					</tr>
					<tr class="row15">
						<td></td>
						<td class="style15 style17" colspan="14">
							<div id="contents">내용 </div>
							<textarea class="target" id="e_textContent" name="e_textContent"><%=contents.getE_textContent()%></textarea>
							<span id="tootip_area7"></span>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="documentBtn">
				<button type="reset" class="btn btn-primary btn-sm float-right">다시쓰기</button>
				<button type="button" class="btn btn-primary btn-sm float-right" onclick="click_up();">확인</button>
				<button type="reset" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
			</div>
			</div>
		</form>
	</body>
</html>