<%@page import="tobe.project.domain.PageMaker"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<% 
	if(userTidx == null){ 
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='"+request.getContextPath()+"'/member/login';</script>");
	}

	List<ApprovalVO> elist = (List<ApprovalVO>)request.getAttribute("elist"); 
	PageMaker paging = (PageMaker)request.getAttribute("paging");
%>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<title>모든 결재문서 리스트</title>
		<link href="<c:url value="/resources/static/form/css/documentListMain.css"/>" rel='stylesheet'/>
		<style type="text/css">
		.pagination{
			position: relative;
    		bottom: 90px;
		}
		</style>
	</head>
	<body>
		<div id="approvalContent">
			<form name="frm" id="frm" method="post">
				<input type="hidden" id="userId" name="userId" value="<%=userId%>">
				<div id="category">
					<button type="button" class="btn btn-outline-secondary" id="waitingDocument">결재대기문서</button>
					<button type="button" class="btn btn-outline-secondary" id="progressDocument">결재진행문서</button>
					<button type="button" class="btn btn-outline-secondary" id="completedDocument">결재완료문서</button>
					<button type="button" class="btn btn-outline-secondary" id="NoDocument">결재반려문서</button>
					<%if(userPosition != null){ %>
						<%if(userPosition.equals("팀장") || userPosition.equals("부장") || userPosition.equals("과장") || userPosition.equals("대표")){ %>
							<button type="button" class="btn btn-outline-secondary" id="my" 
							onclick="location.href='<%=request.getContextPath()%>/approval/documentListMy${paging.makeQuery(1)}&searchWord=<%=userPosition %>&userId=<%=userId%>&t_id=<%=userId%>'">나의 결재문서</button>
						<%}%>
					<%}%>
					<%if(userPosition != "대표" || userGrade != "A"){ %>
						<button type="button" class="btn btn-outline-secondary" id="myWriteDocument">내가 쓴 결재문서</button>
					<%} %>
				</div>
				<div id="statusGroup">
					<table id="statusTable">
						<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<tr>
							<th id="waiting">결재요청문서</th>
							<th id="count">${wa}</th>
							<th id="progress">결재진행문서</th>
							<th id="count">${pr }</th>
							<th id="complete">결재완료문서</th>
							<th id="count">${co }</th>
							<th id="no">결재반려문서</th>
							<th id="count">${no }</th>
						</tr>
					</table>
				</div>
				<div id="waitingListGroup" class="search">
					<div id="searchBtnGroup" class="input-group">
						<input type="hidden" id="searchWord" value="${scri.searchWord}">
						<select id="searchType" class="form-control" name="searchType" style="height:30px; font-size:0.5rem;">
							<option value="전체보기"  <c:out value = "${scri.searchType == null ? 'selected' : '' }"/>>전체보기</option>
 							<option value="기안부서"  <c:out value = "${scri.searchType eq '기안 부서' ? 'selected' : '' }"/>>기안 부서</option>
							<option value="기안자이름" <c:out value = "${scri.searchType eq '기안자 이름' ? 'selected' : '' }"/>>기안자 이름</option>
							<option value="기안일시"  <c:out value = "${scri.searchType eq '기안 일시' ? 'selected' : '' }"/>>기안 일시</option>
							<option value="결재상태"  <c:out value = "${scri.searchType eq '결재 상태' ? 'selected' : '' }"/>>결재 상태</option>
							<option value="기안 제목"  <c:out value = "${scri.searchType eq '기안 제목' ? 'selected' : '' }"/>>기안 제목</option>
							<option value="기안내용"  <c:out value = "${scri.searchType eq '기안 내용' ? 'selected' : '' }"/>>기안 내용</option>
							<option value="제목+내용" <c:out value = "${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
						</select>
						<input type="text" id="keyword" class="form-control" name="keyword" value="${scri.keyword}" style="height:30px; width:40%; font-size:0.5rem;">
						<div class="input-group-prepend">
							<button type="button" id="searchBtn" style="height:30px; font-size:0.5rem;" class="btn btn-outline-secondary">검색</button>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					function documentWite(){ //기안서 팝업창
						var url = "<%=request.getContextPath()%>/approval/documentWite";
						var name = "documentWite";
						var option = "width = 770, height = 915 left = 100, top=50,location=no";
						window.open(url,name,option)
					}
					$(function(){
						$('#searchBtn').on("click",function(){
							var check = $("#searchWord").val();
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=" + check + "&searchType=" + $("select option:selected").val() 
							+ "&keyword=" + encodeURIComponent($('#keyword').val()) + "&t_id=<%=userId%>";
						});
						$('#waitingDocument').on("click",function(){
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재대기"+"&t_id=<%=userId%>";
						});
						$('#progressDocument').on("click",function(){
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재진행"+"&t_id=<%=userId%>";
						});
						$('#completedDocument').on("click",function(){
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재완료"+"&t_id=<%=userId%>";
						});
						$('#NoDocument').on("click",function(){
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재반려"+"&t_id=<%=userId%>";
						});
						$('#myWriteDocument').on("click",function(){
							self.location = "<%=request.getContextPath()%>/approval/documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=내가 쓴 결재문서"+"&userId=<%=userId%>"+"&t_id=<%=userId%>";
						});
					});
				</script>
				<div id="documentTable">
					<table class="table table-hover" id="board">
						<thead>
							<tr>
								<th scope="col" width="5%">문서번호</th>
								<th scope="col" width="5%">기안 유형</th>
								<th scope="col" width="5%">기안 부서</th>
								<th scope="col" width="5%">기안자</th> 
								<th scope="col" width="20%">제목</th>
								<th scope="col" width="5%">기안 일자</th>
								<th scope="col" width="8%">시행 일자</th>
								<th scope="col" width="8%">종료 일자</th>
								<th scope="col" width="5%">반려자</th>
								<th scope="col" width="5%">상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${elist}" var="elist" varStatus="status">
								<tr class="waitingList">
								<td>
									<c:choose>
										<c:when test="${elist.e_type == '중요일정' || elist.e_type == '회사일정' || elist.e_type == '외근' || elist.e_type == '출장'}">
											<a href="<%=request.getContextPath()%>/approval/documentContents?eidx=${elist.eidx}&tidx=${elist.tidx}" onclick="window.open(this.href, '_blank', 'width=770, height=915'); return false;" style="text-decoration : none; color:black;">${elist.eidx }</a>
										</c:when>
										<c:otherwise>
											<a href="<%=request.getContextPath()%>/leave/view?eidx=${elist.eidx}" onclick="window.open(this.href, '_blank', 'width=770, height=650'); return false;" style="text-decoration : none; color:black;">${elist.eidx }</a>
										</c:otherwise> 
									</c:choose>
								</td>
								<td>
									${elist.e_type}
								</td>
								<td>${elist.t_department }</td>
								<td>${elist.t_name }</td>
								<td>
									<c:choose>
										<c:when test="${elist.e_type == '중요일정' || elist.e_type == '회사일정' || elist.e_type == '외근' || elist.e_type == '출장'}">
											<a href="<%=request.getContextPath()%>/approval/documentContents?eidx=${elist.eidx}&tidx=${elist.tidx}" onclick="window.open(this.href, '_blank', 'width=770, height=915'); return false;" style="text-decoration : none; color:black;">
												<c:set var="content" value="${elist.e_textTitle}"/>
												<c:choose>
													<c:when test="${fn:length(elist.e_textTitle) > 40}">
														<c:out value="${fn:substring(content,0,40)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${elist.e_textTitle}"/>
													</c:otherwise> 
												</c:choose>
											</a>
										</c:when>
										<c:otherwise>
											<a href="<%=request.getContextPath()%>/leave/view?eidx=${elist.eidx}" onclick="window.open(this.href, '_blank', 'width=770, height=650'); return false;" style="text-decoration : none; color:black;"><c:set var="content" value="${elist.e_textTitle}"/>
												<c:choose>
													<c:when test="${fn:length(elist.e_textTitle) > 50}">
														<c:out value="${fn:substring(content,0,50)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${elist.e_textTitle}"/>
													</c:otherwise> 
												</c:choose></a>
										</c:otherwise> 
									</c:choose>
								</td>
								<td>${elist.e_draftDate }</td>
								<td>${elist.e_startDay }</td>
								<td>${elist.e_endDay }</td>
								<c:choose>
									<c:when test="${scri.searchWord eq '결재반려' || elist.status eq '3333'}">	
										<td>${elist.e_approvalNoPerson}</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<td>${elist.e_status }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${userPosition != '대표' && userPosition != 'admin'}">
						<div id="writeBtnBox">
							<button type="button" id="writeBtn" class="btn btn-primary btn-sm float-right" onclick="documentWite()">기안 작성</button>
						</div>
					</c:if>
					</div>
					</form>
						</div>
					<div id="paging">
						<nav aria-label="Page navigation example" id="paging">
							<ul class="pagination">
								<c:if test="${paging.prev}">
									<li class="page-item" style="color:black;">
										<a class="page-link" href="<%=request.getContextPath()%>/approval/documentListMain${paging.makeSearch(pageMaker.startPage - 1)}&t_id=<%=userId%>" aria-label="Previous">
										    <span aria-hidden="true">&laquo;</span>
										    <span class="sr-only"></span>
										</a>
									</li>
								</c:if> 
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
									<li class="page-item">
										<a class="page-link" href="<%=request.getContextPath()%>/approval/documentListMain${paging.makeSearch(idx)}&t_id=<%=userId%>">${idx}</a>
									</li>
								</c:forEach>
								<c:if test="${paging.next && paging.endPage > 0}">
									<li class="page-item">
										<a class="page-link" href="<%=request.getContextPath()%>/approval/documentListMain${paging.makeSearch(pageMaker.endPage + 1)}&t_id=<%=userId%>" aria-label="Next">
										    <span aria-hidden="true">&raquo;</span>
										    <span class="sr-only"></span>
										</a>
									</li>
								</c:if> 
							</ul>
			 			</nav>
					</div>
	
	</body>
</html>
