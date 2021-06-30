<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	Object userName = session.getAttribute("userName");
	Object userDep = session.getAttribute("userDep");
	Object userTidx = session.getAttribute("userTidx");
	
	if(userName == null && userDep == null && userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>기안서 작성페이지</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		
		<!-- datepicker -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentWite.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentWite.js"/>"></script>
	</head>
	<body>
		<form id="documentWiteData" name="documentWiteData">
			<input type="hidden" name="tidx" id="tidx" value="<%=userTidx%>">
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
							21-<input type="text" id="e_documentNum" name="e_documentNum" readonly>
						</td>
						<td class="style44 style46" colspan="3">전 결 규 정</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="e_rule" name="e_rule" autocomplete="off">
						</td>
					</tr>
					<tr class="row6">
						<td></td>
						<td class="style2">기 안 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" id="e_draftDate" name="e_draftDate" class="date" autocomplete="off">
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
							<input type="text" id="e_startDay" name="e_startDay" class="date" autocomplete="off">
						</td>
						<td class="style38  style43" colspan="2" rowspan="2">
							<input type="text" id="charge">
						</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="teamLeader">
						</td>
						<td class="style38 style43" colspan="3" rowspan="2">
							<input type="text" id="departmentHead">
						</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="sectionHead">
						</td>
						<td class="style58 style59" rowspan="2">
							<input type="text" id="leader">
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
							<input type="text" id="e_con" name="e_con" autocomplete="off">
						</td>
						<td class="style38 style42" colspan="3" rowspan="2">기 안 자</td>
						<td class="style38 style57" colspan="8" rowspan="2">
							<input type="text" id="e_member" name="e_member" value="<%=userName%>" readonly>
						</td>
					</tr>
					<tr class="row10">
						<td></td>
					</tr>
					<tr class="row11">
						<td></td>
						<td class="style5">수 신 (참조)</td>
						<td class="style44 style46" colspan="2">
							<input type="text" id="e_send" name="e_send" autocomplete="off">
						</td>
						<td class="style44 style45" colspan="3">기 안 부 서</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="e_buseo" name="e_buseo" value="<%=userDep%>"readonly>
						</td>
					</tr>
					<tr class="row12">
						<td></td>
						<td class="style53 style55" colspan="14">
							<div style="width: 35px;">제목 </div>
							<textarea class="target" id="e_textTitle" name="e_textTitle"> </textarea>
						</td>
					</tr>
					<tr class="row15">
						<td></td>
						<td class="style15 style17" colspan="14">
							<div style="width: 35px;">내용 </div>
							<textarea class="target" id="e_textContent" name="e_textContent"> </textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<button type="button" onclick="click_ok();">기안</button>
		</form>
	</body>
</html>