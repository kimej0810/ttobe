<%@page import="java.util.List"%>
<%@page import="tobe.project.dto.ApprovalDTO"%>
<%@page import="tobe.project.dto.ApprovalLineVO"%>
<%@page import="tobe.project.dto.MemberVO"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" trimDirectiveWhitespaces="true"%>
<%
	ApprovalDTO contents = (ApprovalDTO)request.getAttribute("contents");
	ApprovalDTO to = (ApprovalDTO)request.getAttribute("to");
	MemberVO mo = (MemberVO)request.getAttribute("mo");
	List<MemberVO> vo = (List<MemberVO>)request.getAttribute("vo");
	
	String lineTeamLeader = "";
	String lineDepartmentHead = "";
	String lineSectionHead = "";
	String lineLeader = "";
	for(int i = 0; i<vo.size(); i ++){
		MemberVO name = (MemberVO)vo.get(i);
		if(to.getTeamLeader().equals(name.getT_id())){
			lineTeamLeader = name.getT_name();
		}else if(to.getDepartmentHead().equals(name.getT_id())){
			lineDepartmentHead = name.getT_name();
		}else if(to.getSectionHead().equals(name.getT_id())){
			lineSectionHead = name.getT_name();
		}else if(to.getLeader().equals(name.getT_id())){
			lineLeader = name.getT_name();
		}
		
	}
	int userTidx = (int)session.getAttribute("userTidx");
	String userPosition = (String)session.getAttribute("userPosition");
	String userId = (String)session.getAttribute("userId");
	String userGrade = (String) session.getAttribute("userGrade");
	
	if(userTidx == 0){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>"); 
	}
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
		
		<link href="<c:url value="/resources/static/form/css/documentContents.css"/>" rel='stylesheet' />
		<script src="<c:url value="/resources/static/form/js/documentWite.js"/>"></script>
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		<script type="text/javascript">
			function click_modify(){
					alert("수정페이지로 이동합니다.");
					location.href="documentModify?eidx="+"<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>";
			};
			function click_delete(){
					var result = confirm("삭제 하시겠습니까?");
					if(result){
						location.href="documentDelete?eidx="+<%=contents.getEidx()%>;
						alert("결재문서가 삭제되었습니다.");
						opener.parent.location.reload();
						window.close();
					}
			}
			function ok(){
				var result = confirm("승인 처리 하시겠습니까?");
				if(result){
					location.href="documentOk?eidx="+"<%=contents.getEidx()%>";
					alert("승인처리 되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			}
			function no(){
				var returnValue = prompt("반려 사유 작성","");
				if(returnValue != ""){
					if(returnValue){
						var result = confirm("반려 처리 하시겠습니까?");
						if(result){
							location.href = "documentNo?eidx="+"<%=contents.getEidx()%>"+"&e_reason="+returnValue;
							alert("반려처리 되었습니다.");
							opener.parent.location.reload();
							window.close();
						}else{
							alert("반려처리 취소되었습니다.");
						}
					}
				}else{
					alert("반려 사유를 작성하세요.");
				}
			}
			function approvalAgain(){
				var result = confirm("재기안 하시겠습니까?");
				if(result){
					alert("기안서 작성페이지로 이동합니다");
					location.href="documentApprovalAgain?eidx="+"<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>";
				}
			}
		</script>
	</head>
	<body>
		<form id="documentWiteData" name="documentWiteData">
			<input type="hidden" name="e_status" id="e_status" value="<%=contents.getE_status()%>">
			<input type="hidden" name="eidx" id="eidx" value="<%=contents.getEidx() %>">
			<div>
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
							<td class="style35 style36" colspan="2">${mo.t_name }</td>
							<td class="style35 style36" colspan="2"><%=lineTeamLeader %></td>
							<td class="style35 style36" colspan="3"><%=lineDepartmentHead %></td>
							<td class="style35 style36" colspan="2"><%=lineSectionHead %></td>
							<td class="style11 s"><%=lineLeader %></td>
						</tr>
						<tr class="row7">
							<td></td>
							<td class="style2">시 행 일 자</td>
							<td class="style34 style34" colspan="2">
								<%=contents.getE_startDay()%>
							</td>
							<td class="style38  style43" colspan="2" rowspan="2">
								<input type="text" id="charge" readonly value="O">
							</td>
							<td class="style38 style43" colspan="2" rowspan="2">
							<%if(contents.getStatus().equals("0300") || contents.getStatus().equals("0030") ||contents.getStatus().equals("0003")){ %>
								<input type="text" id="teamLeader" readonly value="O">
							<% }else{%>
								<input type="text" id="teamLeader" readonly value="X">
							<% }%>
							</td>
							<td class="style38 style43" colspan="3" rowspan="2">
							<%if(contents.getStatus().equals("0030") ||contents.getStatus().equals("0003")){ %>
								<input type="text" id="departmentHead" readonly value="O">
							<% }else{%>
								<input type="text" id="departmentHead" readonly value="X">
							<% }%>
							</td>
							<td class="style38 style43" colspan="2" rowspan="2">
							<%if(contents.getStatus().equals("0003")){ %>
								<input type="text" id="sectionHead" readonly value="O">
							<% }else{%>
								<input type="text" id="sectionHead" readonly value="X">
							<% }%>
							</td>
							<td class="style58 style59" rowspan="2">
							<%if(contents.getStatus().equals("0000")){ %>
								<input type="text" id="leader" readonly value="O">
							<% }else{%>
								<input type="text" id="leader" readonly value="X">
							<% }%>
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
								<input type="text" id="e_send" name="e_send" value="<%=contents.getE_send()%>" readonly>
							</td>
							<td class="style44 style45" colspan="3">기 안 부 서</td>
							<td class="style44 style63" colspan="8">
								<input type="text" id="t_department" name="t_department" value="${mo.t_department }" readonly>
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
				<div id="documentBtn">
				<%if(userTidx == mo.getTidx() && contents.getE_status().trim().equals("결재대기")){%>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="click_modify();">수정</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="click_delete();">삭제</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userGrade.equals("A") && contents.getE_status().trim().equals("결재대기")){%>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="click_delete();">삭제</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userTidx != mo.getTidx() && userPosition.equals("팀장") && userId.equals(to.getTeamLeader()) && to.getStatus().equals("3000")){ %>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="no()">반려</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userTidx != mo.getTidx() && userPosition.equals("부장") && userId.equals(to.getDepartmentHead()) && to.getStatus().equals("0300")){ %>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="no()">반려</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userTidx != mo.getTidx() && userPosition.equals("과장") && userId.equals(to.getSectionHead()) && to.getStatus().equals("0030")){ %>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="no()">반려</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userTidx != mo.getTidx() && userPosition.equals("대표") && userId.equals(to.getLeader()) && to.getStatus().equals("0003")){ %>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">최종승인</button>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="no()">반려</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else if(userTidx == mo.getTidx() && to.getStatus().equals("3333") && contents.getE_status().trim().equals("결재반려")){%>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="approvalAgain()">재기안</button>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%}else{ %>
					<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
				<%} %>
				</div>
			</div>
		</form>
	</body>
</html>