<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String userName = (String)session.getAttribute("userName");
	String userDep = (String)session.getAttribute("userDep");
	Object userTidx = session.getAttribute("userTidx");
	String userPosition = (String)session.getAttribute("userPosition");
	
	if(userName == null || userDep == null || userTidx == null || userPosition == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>결재문서 작성페이지</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<!-- datepicker -->
		<link href="<c:url value="/resources/static/form/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<script src="<c:url value="/resources/static/form/js/jquery.datetimepicker.full.min.js"/>"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentWite.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentWite.js"/>"></script>
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
	</head>
	<body>
		<form id="documentWiteData" name="documentWiteData" method="POST">
			<input type="hidden" name="tidx" id="tidx" value="<%=userTidx%>">
			<input type="hidden" name="t_position" id="t_position" value="<%=userPosition %>">
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
								21-<input type="text" id="e_documentNum" name="e_documentNum" readonly>
							</td>
							<td class="style44 style46" colspan="3">기 안 유 형</td> 
							<td class="style44 style63" colspan="8">
						 		<input type="text" id="e_rule" name="e_rule" autocomplete="off" title="2글자 이상 10글자 이하로 입력해주세요.">
						 		<span id="tootip_area"></span>
							</td>
						</tr> 
						<tr class="row6">
							<td></td>
							<td class="style2">기 안 일 자</td>
							<td class="style34 style34" colspan="2">
								<input type="text" class="date" id="e_draftDate" name="e_draftDate" class="date" autocomplete="off" readonly title="날짜를 선택해주세요.">
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
								<input type="text" class="date" id="e_startDay" name="e_startDay" class="date" autocomplete="off" readonly title="날짜를 선택해주세요.">
								<span id="tootip_area3"></span>
							</td>
							<td class="style38  style43" colspan="2" rowspan="2">
								<input type="text" id="charge" value="<%=userName%>" readonly>
							</td>
							<%if(userPosition != null){ %>
								<%if(userPosition.equals("팀장")){ %>
									<td class="style38 style43" colspan="2" rowspan="2">
										<input type="text" id="teamLeader" name="teamLeader" value="<%=userName%>" readonly>
									</td>
									<td class="style38 style43" colspan="3" rowspan="2">
										<select id="departmentHead" name="departmentHead">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${userDep == allMember.t_department && allMember.t_position == '부장'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="style38 style43" colspan="2" rowspan="2">
										<select id="sectionHead" name="sectionHead">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${userDep == allMember.t_department && allMember.t_position == '과장'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="style58 style59" rowspan="2">
										<select id="leader" name="leader">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${allMember.t_position == '대표'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								<%}else if(userPosition.equals("부장")){ %>
									<td class="style38 style43" colspan="2" rowspan="2">
											<input type="text" id="teamLeader" name="teamLeader" value="권한 없음" readonly>
									</td>
									<td class="style38 style43" colspan="3" rowspan="2">
										<input type="text" id="departmentHead" name="departmentHead" value="<%=userName%>" readonly>
									</td>
									<td class="style38 style43" colspan="2" rowspan="2">
									<select id="sectionHead" name="sectionHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${userDep == allMember.t_department && allMember.t_position == '과장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
									</td>
									<td class="style58 style59" rowspan="2">
										<select id="leader" name="leader">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${allMember.t_position == '대표'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								<%}else if(userPosition.equals("과장")) {%>
									<td class="style38 style43" colspan="2" rowspan="2">
											<input type="text" id="teamLeader" name="teamLeader" value="권한 없음" readonly>
									</td>
									<td class="style38 style43" colspan="3" rowspan="2">
										<input type="text" id="departmentHead" name="departmentHead" value="권한 없음" readonly>
									</td>
									<td class="style38 style43" colspan="2" rowspan="2">
											<input type="text" id="sectionHead" name="sectionHead" value="<%=userName %>" readonly>
									</td>
									<td class="style58 style59" rowspan="2">
										<select id="leader" name="leader">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${allMember.t_position == '대표'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								<%}else{ %>
									<td class="style38 style43" colspan="2" rowspan="2">
									<select id="teamLeader" name="teamLeader">
										<c:forEach items="${allMember}" var="allMember" varStatus="status">
											<c:if test="${userDep == allMember.t_department && allMember.t_position == '팀장'}">
												<option value="${allMember.t_id}">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
									</td>
									<td class="style38 style43" colspan="3" rowspan="2">
										<select id="departmentHead" name="departmentHead">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${userDep == allMember.t_department && allMember.t_position == '부장'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="style38 style43" colspan="2" rowspan="2">
										<select id="sectionHead" name="sectionHead">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${userDep == allMember.t_department && allMember.t_position == '과장'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
									<td class="style58 style59" rowspan="2">
										<select id="leader" name="leader">
											<c:forEach items="${allMember }" var="allMember" varStatus="status">
												<c:if test="${allMember.t_position == '대표'}">
													<option value="${allMember.t_id }">${allMember.t_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								<%} %>
							<%} %>
							</tr>
							<tr class="row8">
								<td></td>
								<td class="style2 s">보 존 기 한</td>
								<td class="style34 style34" colspan="2">1년</td>
							</tr>
							<tr class="row9">
								<td></td>
								<td class="style3" rowspan="2">합 의 부 서</td>
								<td class="style38 style43" colspan="2" rowspan="2">
									<input type="text" id="e_con" name="e_con" autocomplete="off" title="2글자 이상 10글자 이하로 입력해주세요.">
								</td>
								<td class="style38 style42" colspan="3" rowspan="2">기 안 자</td>
								<td class="style38 style57" colspan="8" rowspan="2">
									<input type="text" id="t_name" name="t_name" value="<%=userName%>" readonly>
								</td>
							</tr>
							<tr class="row10">
								<td></td>
							</tr>
							<tr class="row11">
								<td></td>
								<td class="style5">수 신 (참조)</td>
								<td class="style44 style46" colspan="2">
									<input type="text" id="e_send" name="e_send" autocomplete="off" title="2글자 이상 10글자 이하로 입력해주세요.">
									<span id="tootip_area5"></span>
								</td>
								<td class="style44 style45" colspan="3">기 안 부 서</td>
								<td class="style44 style63" colspan="8">
									<input type="text" id="t_department" name="t_department" value="<%=userDep%>"readonly>
								</td>
							</tr>
							<tr class="row12">
								<td></td>
								<td class="style53 style55" colspan="14">
									<div id="title">제목 </div>
									<textarea class="target" id="e_textTitle" name="e_textTitle" title="10글자 이상 40글자 이하로 입력해주세요"> </textarea>
								</td>
							</tr>
							<tr class="row15">
								<td></td>
								<td class="style15 style17" colspan="14">
									<div id="contents">내용 </div>
									<textarea class="target" id="e_textContent" name="e_textContent" title="30글자 이상 1024글자 이하로 입력해주세요"> </textarea>
								</td>
							</tr>
						</tbody>
					</table>
				<div id="documentBtn">
					<button type="reset" class="btn btn-primary btn-sm float-right">다시쓰기</button>
					<button type="button" onclick="click_ok();" class="btn btn-primary btn-sm float-right">기안</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				</div>
			</div>
		</form>
	</body>
</html>