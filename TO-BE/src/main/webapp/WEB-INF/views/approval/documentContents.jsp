<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="tobe.project.dto.ApprovalDTO"%>
<%@page import="tobe.project.dto.ApprovalLineVO"%>
<%@page import="tobe.project.dto.MemberVO"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" trimDirectiveWhitespaces="true"%>
<%
	Date Date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
	String toDate = simpleDate.format(Date);
	Integer userTidx = (Integer)session.getAttribute("userTidx");;
	String userPosition = (String)session.getAttribute("userPosition");
	String userId = (String)session.getAttribute("userId");
	String userGrade = (String) session.getAttribute("userGrade");
	String userName = (String)session.getAttribute("userName");	
	
	if(userTidx == null){
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"/member/login';</script>"); 
	}
	
	ApprovalDTO contents = (ApprovalDTO)request.getAttribute("contents");
	ApprovalDTO to = (ApprovalDTO)request.getAttribute("to");
	MemberVO mo = (MemberVO)request.getAttribute("mo");
	List<MemberVO> vo = (List<MemberVO>)request.getAttribute("vo");
	
	
	//멤버리스트에 접근하여 결재라인의 아이디값을 이용해 이름 불러오기
	String lineTeamLeaderId = "";
	String lineSectionHeadId = "";
	String lineDepartmentHeadId = "";
	String lineLeaderId = "";
	
	String lineTeamLeaderName = "";
	String lineSectionHeadName = "";
	String lineDepartmentHeadName = "";
	String lineLeaderName = "";
	String approvalnoperson = "";
	
	for(int i = 0; i<vo.size(); i ++){
		MemberVO name = (MemberVO)vo.get(i);
		if(to.getTeamLeader().equals(name.getT_id()) || to.getTeamLeader().equals(name.getT_name())){
			lineTeamLeaderName = name.getT_name();
			lineTeamLeaderId = name.getT_id();
		}else if(to.getSectionHead().equals(name.getT_id()) || to.getSectionHead().equals(name.getT_name())){
			lineSectionHeadName = name.getT_name();
			lineSectionHeadId = name.getT_id();
		}else if(to.getDepartmentHead().equals(name.getT_id()) || to.getDepartmentHead().equals(name.getT_name())){
			lineDepartmentHeadName = name.getT_name();
			lineDepartmentHeadId = name.getT_id();
		}else if(to.getLeader().equals(name.getT_id()) || to.getLeader().equals(name.getT_name())){
			lineLeaderName = name.getT_name();
			lineLeaderId = name.getT_id();
		}
	}
%>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<title>결제문서 상세보기</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		
		<link href="<c:url value="/resources/static/form/css/documentContents.css"/>" rel='stylesheet' />
		<style type="text/css">
			.modal-header{
				justify-content: center;
				border-bottom: 2px solid #e5e5e5;
			}
			.modal{
				top:262px;
			}
			#approvalNoboard{
				width: 100%;
				height: 100px;
				text-align: center;
			}
			#noth{
				width:80px;
				text-align: center;
			}
			#e_approvalNoDayTd{
				width: 35%;
			}
			#e_approvalNoDay{
				text-align: center;
				border: none;
				font-size: 14px;
			}
			#e_reason{
			    width: 100%;
    			height: 61%;
    			
    		}
		</style>
		<script type="text/javascript">
			//반려된 문서일시 반려사유 로드
			$(window).on('load',function(){
				if(<%=contents.getStatus().equals("3333")%>){
		        	$('#myModalNoinfo').modal('show');
				}
		    });
			//반려사유작성창
			$(document).on("click","#no",function(){
				$('#myModalNo').modal('show');
			});
			//반려처리(입력값 있으면 ajax 호출)
			$(document).on("click","#noOk",function(){
				var returnValue = $("#e_reason").val();
				var returnDate = $("#e_approvalNoDay").val();
				if(returnValue != ""){
					Swal.fire({
						title:"반려 사유 확인",
						text:"반려 사유 : "+returnValue+" 로 반려하시겠습니까?",
						icon:"warning",
						showCancelButton:true,
						confirmButtonText:"확인",
						cancelButtonText:"취소"
					}).then(result => {
						if(result.isConfirmed){
							$.ajax({
								url : "<%=request.getContextPath()%>/approval/documentNo?eidx=<%=contents.getEidx()%>&tidx=<%=userTidx%>&e_reason="+returnValue+"&e_approvalNoDay="+returnDate,
								data: returnValue,
								dateType:"json",
								success:function(){
									Swal.fire("결재 반려","반려 처리되었습니다.","success").then(result => {
										opener.parent.location.reload();
										window.close();	
									});
								},
								error:function(){
									Swal.fire("결재 반려","반려 실패되었습니다.","error").then(result => {
										opener.parent.location.reload();
										window.close();	
									});
								}
							});
						}
					});
				}
			});
			//일반 승인
			function ok(){
				Swal.fire({
					title:"결재 승인",
					text:"결재 승인 하시겠습니까?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						$.ajax({
							url: "<%=request.getContextPath()%>/approval/documentOk?eidx=<%=contents.getEidx()%>",
							dataType:'json',
							success:function(){
								Swal.fire("결재 승인","승인 처리되었습니다.","success").then(result => {
									opener.parent.location.reload();
									window.close();	
								});
							},
							error:function(){
								Swal.fire("결재 승인","승인 실패되었습니다.","error").then(result => {
									opener.parent.location.reload();
									window.close();	
								});
							}
						})
					}
				});
			}
			//대표 승인
			function ok2(){
				Swal.fire({
					title:"최종 승인",
					text:"최종 승인 하시겠습니까?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						$.ajax({
							url: "<%=request.getContextPath()%>/approval/documentOk?eidx=<%=contents.getEidx()%>",
							dataType:'json',
							success:function(){
								Swal.fire("결재 승인","최종승인 처리되었습니다.","success").then(result => {
									opener.parent.location.reload();
									window.close();	
								});
							},
							error:function(){
								Swal.fire("결재 승인","최종승인 실패되었습니다.","error").then(result => {
									opener.parent.location.reload();
									window.close();	
								});
							}
						})
					}
				});
			}
			//수정페이지 이동
			function click_modify(){
				Swal.fire({
					title:"결재문서 수정",
					text:"수정페이지로 이동하시겠습니까?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"이동",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						self.location.href="<%=request.getContextPath()%>/approval/documentModify?eidx=<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>";
					}
				})
			}
			//반려문서 재기안
			function approvalAgain(){
				Swal.fire({
					title:"재기안 페이지 이동",
					text:"재기안 하시겠습니까?",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						self.location.href="<%=request.getContextPath()%>/approval/documentApprovalAgain?eidx=<%=contents.getEidx()%>&tidx=<%=contents.getTidx()%>";
					}
				});
			}
			//결재문서 삭제
			function click_delete(){
				Swal.fire({
					title:"결재 취소",
					text:"결재를 취소 하시겠습니까? (취소 된 결재는 삭제됩니다.)",
					icon:"question",
					showCancelButton:true,
					confirmButtonText:"확인",
					cancelButtonText:"취소"
				}).then(result => {
					if(result.isConfirmed){
						Swal.fire("결재 취소","결재문서가 삭제되었습니다.","success").then(result => {
							location.href="<%=request.getContextPath()%>/approval/documentDelete?eidx=<%=contents.getEidx()%>";
							opener.parent.location.reload();
							window.close();	
						});
					}
				})
			}
		</script>
	</head>
	<body>
		<form id="documentWiteData" name="documentWiteData">
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
								<input type="text" id="e_type" name="e_type" value="<%=contents.getE_type()%>" readonly>
							</td>
						</tr>
						<tr class="row6">
							<td></td>
							<td class="style2">기 안 일 자</td>
 							<td class="style34 style34" colspan="2">
								<input type="text" id="e_draftDate" name="e_draftDate" value="<%=contents.getE_draftDate()%>" autocomplete="off" readonly>
							</td>
							<td class="style33 style33" rowspan="3">결<br><br>재</td>
							<td class="style35 style36" colspan="2"><%=contents.getT_name()%></td>
							<td class="style35 style36" colspan="2">
							<%if(lineTeamLeaderName == ""){%>
								결재권한없음
							<%}else{%>
								<%=lineTeamLeaderName%>
							<%}%>
							</td>
							<td class="style35 style36" colspan="3">
							<%if(lineSectionHeadName == ""){%>
								결재권한없음
							<%}else{%>
								<%=lineSectionHeadName%>
							<%}%>
							</td>
							<td class="style35 style36" colspan="2">
							<%if(lineDepartmentHeadName == ""){%>
								결재권한없음
							<%}else{%>
								<%=lineDepartmentHeadName%>
							<%}%>
							</td>
							<td class="style11 s"><%=lineLeaderName %></td>
						</tr>
						<tr class="row7">
							<td></td>
							<td class="style2">시 행 일 자</td>
							<td class="style34 style34" colspan="2">
								<input type="text" id="e_startDay" name="e_startDay" value="<%=contents.getE_startDay()%>" readonly>
							</td>
							<td class="style38  style43" colspan="2" rowspan="2">
								<input type="text" id="charge" readonly value="승인">
							</td>
							<td class="style38 style43" colspan="2" rowspan="2">
							<%if(lineTeamLeaderId == ""){%>
								<input type="text" id="teamLeader" readonly value="결재권한없음">
							<%}else if(contents.getStatus().equals("3000")){ %>
								<input type="text" id="teamLeader" readonly value="예정">
							<%}else if(lineTeamLeaderId.equals(contents.getE_approvalNoPerson())){%>
								<input type="text" id="teamLeader" readonly value="반려">
							<%}else{%>
								<input type="text" id="teamLeader" readonly value="승인">
							<%}%>
							</td> 
							<td class="style38 style43" colspan="3" rowspan="2">
							<% if(lineSectionHeadId == ""){%>
								<input type="text" id="sectionHead" readonly value="결재권한없음">
							<%}else if(contents.getStatus().equals("3000")){ %>
								<input type="text" id="sectionHead" readonly value="대기">
							<%}else if(contents.getStatus().equals("0300")){ %>
								<input type="text" id="sectionHead" readonly value="예정">
							<%}else if(lineSectionHeadId.equals(contents.getE_approvalNoPerson())){%>
								<input type="text" id="sectionHead" readonly value="반려">
							<%}else{%>
								<input type="text" id="sectionHead" readonly value="승인">
							<%}%>
							</td>
							<td class="style38 style43" colspan="2" rowspan="2">
							<% if(lineDepartmentHeadId == ""){%>
								<input type="text" id="departmentHead" readonly value="결재권한없음">
							<%}else if(contents.getStatus().equals("3000") || contents.getStatus().equals("0300")){ %>
								<input type="text" id="departmentHead" readonly value="대기">
							<%}else if(contents.getStatus().equals("0030")){ %>
								<input type="text" id="departmentHead" readonly value="예정">
							<%}else if(lineDepartmentHeadId.equals(contents.getE_approvalNoPerson())){%>
								<input type="text" id="departmentHead" readonly value="반려">
							<%}else{%>
								<input type="text" id="departmentHead" readonly value="승인">
							<%} %>
							</td>
							<td class="style58 style59" rowspan="2">
							<%if(contents.getStatus().equals("0003")){ %>
								<input type="text" id="leader" readonly value="예정">
							<%}else if(contents.getStatus().equals("0000")){%>
								<input type="text" id="leader" readonly value="승인">
							<%}else if(lineLeaderId.equals(contents.getE_approvalNoPerson())){%>
								<input type="text" id="leader" readonly value="반려">
							<%}else{%>
								<input type="text" id="leader" readonly value="대기">
							<%} %>
							</td>
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
								<textarea class="target" id="e_textTitle" name="e_textTitle" readonly> <%=contents.getE_textTitle()%></textarea>
							</td>
						</tr>
						<tr class="row15">
							<td></td>
							<td class="style15 style17" colspan="14">
								<div id="contents">내용 </div>
								<textarea class="target" id="e_textContent" name="e_textContent" readonly> <%=contents.getE_textContent()%></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="documentBtn">
				<%if(userTidx != null){ %>
					<%if(userTidx == mo.getTidx() && contents.getE_status().trim().equals("결재대기")){%>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="click_modify();">수정</button>
						<button type="button" class="btn btn-outline-danger btn-sm" onclick="click_delete();">삭제</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userGrade.equals("A") && contents.getE_status().trim().equals("결재대기")){%>
						<button type="button" class="btn btn-outline-danger btn-sm" onclick="click_delete();">삭제</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userTidx != mo.getTidx() && userPosition.equals("팀장") && userId.equals(to.getTeamLeader()) && to.getStatus().equals("3000")){ %>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-outline-danger btn-sm" id="no">반려</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userTidx != mo.getTidx() && userPosition.equals("과장") && userId.equals(to.getSectionHead()) && to.getStatus().equals("0300")){ %>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-outline-danger btn-sm" id="no">반려</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userTidx != mo.getTidx() && userPosition.equals("부장") && userId.equals(to.getDepartmentHead()) && to.getStatus().equals("0030")){ %>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok()">승인</button>
						<button type="button" class="btn btn-outline-danger btn-sm" id="no">반려</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userTidx != mo.getTidx() && userPosition.equals("대표") && userId.equals(to.getLeader()) && to.getStatus().equals("0003")){ %>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="ok2()">최종승인</button>
						<button type="button" class="btn btn-outline-danger btn-sm" id="no">반려</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else if(userTidx == mo.getTidx() && to.getStatus().equals("3333") && contents.getE_status().trim().equals("결재반려")){%>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="approvalAgain()">재기안</button>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%}else{ %>
						<button type="button" class="btn btn-primary btn-sm float-right" onclick="window.close();">닫기</button>
					<%} %>
				<%} %>
				</div>
			</div>
		</form>
		<!-- 반려정보 Modal -->
		<div class="modal fade" id="myModalNoinfo" role="dialog" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog">
		    <!-- 반려정보 Modal content-->
	    		<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"></button>
						<h4 class="modal-title">반려 내용</h4>
					</div>
					<div class="modal-body">
						<table id="approvalNoboard">
							<tr>
								<th id="noth">반려자</th>
								<td id="notd">
									<c:forEach items="${vo}" var="vo">
										<c:choose>
											<c:when test="${vo.t_id == contents.e_approvalNoPerson }">
												${vo.t_name}
											</c:when>
										</c:choose>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th id="noth">반려 사유</th>
								<td id="notd"><%=contents.getE_reason() %></td>
							</tr>
							<tr>
								<th id="noth">반려 일자</th>
								<td id="notd">${fn:substring(contents.e_approvalNoDay,0,16)}</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 반려 Modal -->
		<div class="modal fade" id="myModalNo" role="dialog" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog">
		    <!-- 반려 Modal content-->
	    		<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"></button>
						<h4 class="modal-title">반려 사유 작성</h4>
					</div>
					<div class="modal-body">
						<table id="approvalNoboard">
							<tr>
								<th id="noth">반려자</th>
								<td id="notd"><%=userName%></td>
								<th id="noth">반려 일자</th>
								<td id="e_approvalNoDayTd">
									<input type="hidden" id="e_approvalNoDay" value="<%=toDate %>" readonly>
									<%=toDate %>
								</td>
							</tr>
							<tr>
								<th id="noth">반려사유</th>
								<td id="notd" colspan="4">
									<input type="text" id="e_reason" autocomplete="off">
								</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-confirm="modal" id="noOk">OK</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>