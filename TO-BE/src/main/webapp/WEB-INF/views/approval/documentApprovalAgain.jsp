<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="tobe.project.dto.ApprovalDTO"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	Date Date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String toDate = simpleDate.format(Date);
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
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		<!-- datepicker -->
		<link href="<c:url value="/resources/static/form/css/jquery.datetimepicker.css"/>" rel="stylesheet">
		<script src="<c:url value="/resources/static/form/js/jquery.datetimepicker.full.min.js"/>"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentApprovalAgain.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentApprovalAgain.js"/>"></script>
		<script type="text/javascript">
			if(<%=userTidx%> != <%=contents.getTidx()%>){
				alert('권한이 없습니다');
				history.back();
			}
			function click_up(){
				var draftDate = $("#e_draftDate").val().replace("-","/");
				var startDay = $("#e_startDay").val().replace("-","/");
				var draft = new Date(draftDate); 
				var start = new Date(startDay);
				
				
				if($("#e_con").val() == "" || $("#e_con").val().length < 2 || $("#e_con").val().length > 10){
					alert("합의부서를 입력해주세요. [2글자 이상 10글자 이하]");
					$("#e_con").focus();
					return false;
				}else if($("#e_textTitle").val() == "" || $("#e_textTitle").val().length < 10 || $("#e_textTitle").val().length > 40){
					alert("제목을 입력해주세요. [10글자 이상 40글자 이하]");
					$("#e_textTitle").focus();
					return false;
				}else if($("#e_textContent").val() == "" || $("#e_textContent").val().length < 30 || $("#e_textContent").val().length > 1024){
					alert("내용을 입력해주세요. [30글자 이상 1024글자 이하]");
					$("#e_textContent").focus();
					return false;
				}
				
				var draftLetterData = JSON.stringify($('form#draftLetterData').serializeObject());
				var result = confirm("재기안 하시겠습니까?");
				if(result){
					$.ajax({
						type:'POST',
						url:"/approval/documentApprovalAgainOk",
						dataType:'JSON',
						data: draftLetterData,
						contentType : "application/json; charset=UTF-8",
						success: function(data){
							alert("재기안이 완료되었습니다.");
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
		<input type="hidden">
		<input type="hidden" name="tidx" id="tidx" value="<%=contents.getTidx() %>">
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
							21-<input type="text" id="eidx" name="eidx" value="<%=contents.getEidx()%>" readonly>
						</td>
						<td class="style44 style46" colspan="3">기 안 유 형</td>
						<td class="style44 style63" colspan="8">
							<select id="e_type" name="e_type">
									<option value="회사일정">회사일정</option>
									<option value="중요일정">중요일정</option>
									<option value="외근">외근</option>
									<option value="출장">출장</option>
							</select>
						</td>
					</tr>
					<tr class="row6">
						<td></td>
						<td class="style2">기 안 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" id="e_draftDate" name="e_draftDate" class="date" value="<%=contents.getE_draftDate()%>" autocomplete="off" readonly>
						</td>
						<td class="style33 style33" rowspan="3">결<br><br>재</td>
						<td class="style35 style36" colspan="2">담당</td>
						<%if(contents.getT_position().equals("과장")){ %>
						<td class="style35 style36" colspan="2">결재권한없음</td>
						<td class="style35 style36" colspan="3">과장</td>
						<td class="style35 style36" colspan="2">부장</td>
						<%}else if(contents.getT_position().equals("부장")){%>
						<td class="style35 style36" colspan="2">결재권한없음</td>
						<td class="style35 style36" colspan="3">결재권한없음</td>
						<td class="style35 style36" colspan="2">부장</td>
						<%}else{%>
						<td class="style35 style36" colspan="2">팀장</td>
						<td class="style35 style36" colspan="3">과장</td>
						<td class="style35 style36" colspan="2">부장</td>
						<%}%>
						<td class="style11 s">대 표</td>
					</tr> 
					<tr class="row7">
						<td></td>
						<td class="style2">시 행 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" class="date" id="e_startDay" name="e_startDay" class="date" autocomplete="off" readonly title="날짜를 선택해주세요." value="<%=contents.getE_startDay()%>">
						</td>
						<td class="style38  style43" colspan="2" rowspan="2">
							<input type="text" id="charge" value="<%=contents.getT_name()%>">
						</td>
						<%if(contents.getT_position() != null){ %>
							<%if(contents.getT_position().equals("팀장")){ %>
								<td class="style38 style43" colspan="2" rowspan="2">
									<input type="text" id="teamLeader" name="teamLeader" value="<%=contents.getT_name()%>" readonly>
								</td>
								<td class="style38 style43" colspan="3" rowspan="2">
									<select id="sectionHead" name="sectionHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '과장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style38 style43" colspan="2" rowspan="2">
									<select id="departmentHead" name="departmentHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '부장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style58 style59" rowspan="2">
									<c:forEach items="${allMember }" var="allMember" varStatus="status">
										<c:if test="${allMember.t_position == '대표'}">
											<input type="hidden" id="leader" name="leader" value="${allMember.t_id}">
											<input type="text" id="leaderRead" value="${allMember.t_name}" readonly>
										</c:if>
									</c:forEach>
								</td>
							<%}else if(contents.getT_position().equals("과장")){ %>
								<td class="style38 style43" colspan="2" rowspan="2">
										<input type="text" id="teamLeader" name="teamLeader" value="결재권한없음" readonly>
								</td>
								<td class="style38 style43" colspan="3" rowspan="2">
									<input type="text" id="sectionHead" name="sectionHead" value="<%=contents.getT_name()%>" readonly>
								</td>
								<td class="style38 style43" colspan="2" rowspan="2">
									<select id="departmentHead" name="departmentHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '부장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style58 style59" rowspan="2">
									<c:forEach items="${allMember }" var="allMember" varStatus="status">
										<c:if test="${allMember.t_position == '대표'}">
											<input type="hidden" id="leader" name="leader" value="${allMember.t_id}">
											<input type="text" id="leaderRead" value="${allMember.t_name}" readonly>
										</c:if>
									</c:forEach>
								</td>
							<%}else if(contents.getT_position().equals("부장")) {%>
								<td class="style38 style43" colspan="2" rowspan="2">
									<input type="text" id="teamLeader" name="teamLeader" value="결재권한없음" readonly>
								</td>
								<td class="style38 style43" colspan="3" rowspan="2">
									<input type="text" id="sectionHead" name="sectionHead" value="결재권한없음" readonly>
								</td>
								<td class="style38 style43" colspan="2" rowspan="2">
									<input type="text" id="departmentHead" name="departmentHead" value="<%=contents.getT_name() %>" readonly>
								</td>
								<td class="style58 style59" rowspan="2">
									<c:forEach items="${allMember }" var="allMember" varStatus="status">
										<c:if test="${allMember.t_position == '대표'}">
											<input type="hidden" id="leader" name="leader" value="${allMember.t_id}">
											<input type="text" id="leaderRead" value="${allMember.t_name}" readonly>
										</c:if>
									</c:forEach>
								</td>
							<%}	else{ %>
								<td class="style38 style43" colspan="2" rowspan="2">
									<select id="teamLeader" name="teamLeader">
										<c:forEach items="${allMember}" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '팀장'}">
												<option value="${allMember.t_id}">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style38 style43" colspan="3" rowspan="2">
									<select id="sectionHead" name="sectionHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '과장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style38 style43" colspan="2" rowspan="2">
									<select id="departmentHead" name="departmentHead">
										<c:forEach items="${allMember }" var="allMember" varStatus="status">
											<c:if test="${contents.t_department == allMember.t_department && allMember.t_position == '부장'}">
												<option value="${allMember.t_id }">${allMember.t_name}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="style58 style59" rowspan="2">
									<c:forEach items="${allMember }" var="allMember" varStatus="status">
										<c:if test="${allMember.t_position == '대표'}">
											<input type="hidden" id="leader" name="leader" value="${allMember.t_id}">
											<input type="text" id="leaderRead" value="${allMember.t_name}" readonly>
										</c:if>
									</c:forEach>
								</td>
							<%} %>
						<%} %>
					</tr>
					<tr class="row8">
						<td></td>
						<td class="style2 s">종 료 일 자</td>
						<td class="style34 style34" colspan="2">
							<input type="text" id="e_endDay" name="e_endDay" value="<%=contents.getE_endDay()%>" readonly>
						</td>
					</tr>
					<tr class="row9">
						<td></td>
						<td class="style3" rowspan="2">합 의 부 서</td>
						<td class="style38 style43" colspan="2" rowspan="2">
							<input type="text" id="e_con" name="e_con" value="<%=contents.getE_con()%>">
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
						<td class="style5">보 존 기 한</td>
						<td class="style44 style46" colspan="2">1년</td>
						<td class="style44 style45" colspan="3">기 안 부 서</td>
						<td class="style44 style63" colspan="8">
							<input type="text" id="t_department" name="t_department" value="${mo.t_department }" readonly>
						</td>
					</tr>
					<tr class="row12">
						<td></td>
						<td class="style53 style55" colspan="14">
							<div id="title">제목 </div>
							<textarea class="target" id="e_textTitle" name="e_textTitle"> <%=contents.getE_textTitle()%></textarea>
						</td>
					</tr>
					<tr class="row15">
						<td></td>
						<td class="style15 style17" colspan="14">
							<div id="contents">내용 </div>
							<textarea class="target" id="e_textContent" name="e_textContent"> <%=contents.getE_textContent()%></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="documentBtn">
				<button type="reset" class="btn btn-primary btn-sm float-right">다시쓰기</button>
				<button type="button" class="btn btn-primary btn-sm float-right" onclick="click_up();">확인</button>
				<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
			</div>
			</div>
		</form>
	</body>
</html>