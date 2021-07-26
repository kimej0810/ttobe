<%@page import="tobe.project.dto.ApprovalDTO"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	Integer userTidx = (Integer)session.getAttribute("userTidx");
	ApprovalDTO contents = (ApprovalDTO)request.getAttribute("contents");
	
	if(userTidx == null){ 
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"/member/login';</script>");
	}
%>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<title>결제문서 수정페이지</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	 	
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
				var startDay = $("#e_startDay").val().replace("-","/");
				var endDay = $("#e_endDay").val().replace("-","/");
				var start = new Date(startDay);
				var end = new Date(endDay);
					
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
				
				Swal.fire({
					title:"결재 수정",
					text:"결재문서를 수정하시겠습니까?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					var draftLetterData = JSON.stringify($('form#draftLetterData').serializeObject());
					if(result.isConfirmed){
						$.ajax({
							data: draftLetterData,
							url: "<%=request.getContextPath()%>/approval/ModifyDocumentWite",
							type:'POST',
							dataType:'JSON',
							contentType : "application/json; charset=UTF-8",
							success: function(data){
								Swal.fire("결재 수정 완료","문서 수정이 완료되었습니다.","success").then(result => {
									opener.parent.location.reload();
									location.href="<%=request.getContextPath()%>/approval/documentContents?eidx=<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>";
								});
							},
							error:function(){
								Swal.fire("결재 수정 실패","문서 수정에 실패했습니다.","error").then(result => {
									opener.parent.location.reload();
								});
							}
						});
					}
				});
			}
		</script>
	</head>
	<body>
		<form id="draftLetterData" name="draftLetterData">
			<input type="hidden" name="e_status" id="e_status" value="<%=contents.getE_status()%>">
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
								<input type="text" id="e_draftDate" name="e_draftDate" value="<%=contents.getE_draftDate()%>" autocomplete="off" readonly>
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
								<input type="text" id="e_startDay" name="e_startDay" value="<%=contents.getE_startDay()%>" autocomplete="off">
							</td>
							<td class="style38  style43" colspan="2" rowspan="2">
								<input type="text" id="charge" value="${mo.t_name }" readonly>
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
								<%}else{ %>
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
								<input type="text" id="e_endDay" name="e_endDay" value="<%=contents.getE_endDay()%>" autocomplete="off">
							</td>
						</tr>
						<tr class="row9">
							<td></td>
							<td class="style3" rowspan="2">합 의 부 서</td>
							<td class="style38 style43" colspan="2" rowspan="2">
								<input type="text" id="e_con" name="e_con" title="2글자 이상 10글자 이하로 입력해주세요." value="<%=contents.getE_con()%>">
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
								<textarea class="target" id="e_textTitle" name="e_textTitle" title="10글자 이상 40글자 이하로 입력해주세요"> <%=contents.getE_textTitle()%></textarea>
							</td>
						</tr>
						<tr class="row15">
							<td></td>
							<td class="style15 style17" colspan="14">
								<div id="contents">내용 </div>
								<textarea class="target" id="e_textContent" name="e_textContent" title="30글자 이상 1024글자 이하로 입력해주세요"> <%=contents.getE_textContent()%></textarea>
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