<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	ApprovalVO contents = (ApprovalVO)request.getAttribute("contents");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>결제문서 상세보기</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		
		<!-- datepicker -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentWite.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentWite.js"/>"></script>
		<script type="text/javascript">
		
			function click_modify(){
				var e_status = $('#e_status').val();
				
				if(e_status == 0){
					location.href="documentModify?e_documentNum="+<%=contents.getE_documentNum()%>
				}else{
					alert("수정을 할 수 있는 상태가 아닙니다.");
				}
			};
			function click_delete(){
				var e_status = $('#e_status').val();
				
				if(e_status == 0){
					alert("정말 삭제하시겠습니까?");
					location.href="documentDelete?eidx="+<%=contents.getEidx()%>;
					opener.parent.location.reload();
					window.close();
				}else{
					alert("삭제를 할 수 있는 상태가 아닙니다.");
				}
			}
			function click_ok(){
				opener.parent.location.reload();
				window.close();
			}
		</script>
	</head>
	<body>
		<form id="documentWiteData" name="documentWiteData">
		<input type="hidden" name="e_status" id="e_status" value="<%=contents.getE_status()%>">
		<input type="hidden" name="eidx" id="eidx" value="<%=contents.getEidx() %>">
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
							<input type="text" id="e_rule" name="e_rule" value="<%=contents.getE_rule()%>" readonly>
						</td>
					</tr>
					<tr class="row6">
						<td></td>
						<td class="style2">기 안 일 자</td>
						<td class="style34 style34" colspan="2">
							<%=contents.getE_draftDate()%>
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
							<%=contents.getE_startDay()%>
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
							<input type="text" id="e_con" name="e_con" value="<%=contents.getE_con()%>" readonly>
						</td>
						<td class="style38 style42" colspan="3" rowspan="2">기 안 자</td>
						<td class="style38 style57" colspan="8" rowspan="2">
							<input type="text" id="e_member" name="e_member" value="<%=contents.getE_member()%>" readonly>
						</td>
					</tr>
					<tr class="row10">
						<td></td>
					</tr>
					<tr class="row11">
						<td></td>
						<td class="style5">수 신 (참조)</td>
						<td class="style44 style46" colspan="2">
							<input type="text" id="e_send" name="e_send" value="<%=contents.getE_send()%>" readonly>
						</td>
						<td class="style44 style45" colspan="3">기 안 부 서</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="e_buseo" name="e_buseo" value="<%=contents.getE_buseo()%>" readonly>
						</td>
					</tr>
					<tr class="row12">
						<td></td>
						<td class="style53 style55" colspan="14">
							<div style="width: 35px;">제목 </div>
							<textarea class="target" id="e_textTitle" name="e_textTitle" readonly><%=contents.getE_textTitle()%></textarea>
						</td>
					</tr>
					<tr class="row15">
						<td></td>
						<td class="style15 style17" colspan="14">
							<div style="width: 35px;">내용 </div>
							<textarea class="target" id="e_textContent" name="e_textContent" readonly><%=contents.getE_textContent()%></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btngroup">
			<button type="button" onclick="click_ok()">확인</button>
			<button type="button" onclick="click_modify();">수정</button>
			<button type="button" onclick="click_delete();">삭제</button>
		</div>
	</body>
</html>