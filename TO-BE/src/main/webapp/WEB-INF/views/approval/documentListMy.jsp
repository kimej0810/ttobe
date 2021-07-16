<%@page import="tobe.project.domain.PageMaker"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<% 
	List<ApprovalVO> elist = (List<ApprovalVO>)request.getAttribute("elist"); 
	PageMaker paging = (PageMaker)request.getAttribute("paging");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>나의 결재문서 리스트</title>
		<link href="<c:url value="/resources/static/form/css/documentListMy.css"/>" rel='stylesheet'/>
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
							<option value="문서번호"  <c:out value = "${scri.searchType eq '문서 번호' ? 'selected' : '' }"/>>문서 번호</option>
							<option value="기안부서"  <c:out value = "${scri.searchType eq '기안 부서' ? 'selected' : '' }"/>>기안 부서</option>
							<option value="기안자이름" <c:out value = "${scri.searchType eq '기안자 이름' ? 'selected' : '' }"/>>기안자 이름</option>
							<option value="기안제목"  <c:out value = "${scri.searchType eq '기안 제목' ? 'selected' : '' }"/>>기안 제목</option>
							<option value="기안일시"  <c:out value = "${scri.searchType eq '기안 일시' ? 'selected' : '' }"/>>기안 일시</option>
							<option value="결재상태"  <c:out value = "${scri.searchType eq '결재 상태' ? 'selected' : '' }"/>>결재 상태</option>
							<option value="제목+내용" <c:out value = "${scri.searchType eq '제목+내용' ? 'selected' : '' }"/>>제목+내용</option>
						</select>
						<input type="text" id="keyword" class="form-control" name="keyword" value="${scri.keyword }" style="height:30px; width:40%; font-size:0.5rem;">
						<div class="input-group-prepend">
							<button type="button" id="searchBtn" style="height:30px; font-size:0.5rem;" class="btn btn-outline-secondary">검색</button>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					function documentWite(){ //기안서 팝업창
						var url = "documentWite";
						var name = "documentWite";
						var option = "width = 770, height = 915 left = 100, top=50,location=no";
						window.open(url,name,option)
					}
					$(function(){
						$('#searchBtn').on("click",function(){
							var check = $("#searchWord").val();
							self.location = "documentListMy" + '${paging.makeQuery(1)}' + "&searchWord=" + check + "&searchType=" + $('select option:selected').val() 
							+ "&keyword=" + encodeURIComponent($('#keyword').val()) + "&userId=<%=userId%>";
						});
						$('#waitingDocument').on("click",function(){
							self.location = "documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재대기"+"&t_id=<%=userId%>";
						});
						$('#progressDocument').on("click",function(){
							self.location = "documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재진행"+"&t_id=<%=userId%>";
						});
						$('#completedDocument').on("click",function(){
							self.location = "documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재완료"+"&t_id=<%=userId%>";
						});
						$('#NoDocument').on("click",function(){
							self.location = "documentListMain" + '${paging.makeQuery(1)}' + "&searchWord=결재반려"+"&t_id=<%=userId%>";
						});
						
					});
				</script>
				<div id="documentTable">
					<table class="table table-hover" id="board">
						<thead>
							<tr>
								<th width="100px">문서번호</th>
								<th width="100px">기안 유형</th>
								<th width="100px">기안 부서</th>
								<th width="100px">기안자</th>
								<th>제목</th> 
								<th width="150px">기안 일시</th>
								<th width="70px">상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${elist}" var="elist" varStatus="status">
								<tr class="waitingList">
								<td>
									<c:choose>
										<c:when test="${elist.e_rule == null}">
											<a href="documentContents?eidx=${elist.eidx}&tidx=${elist.tidx}" onclick="window.open(this.href, '_blank', 'width=770, height=915'); return false;" style="text-decoration : none; color:black;">${elist.e_documentNum }</a>
										</c:when>
										<c:otherwise>
											<a href="/member/leaveView?eidx=${elist.eidx}" onclick="window.open(this.href, '_blank', 'width=770, height=630'); return false;" style="text-decoration : none; color:black;">${elist.e_documentNum }</a>
										</c:otherwise> 
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${elist.e_rule == null}">
											${elist.e_type}
										</c:when>
										<c:otherwise>
											${elist.e_rule}
										</c:otherwise> 
									</c:choose>
								</td>
								<td>${elist.memberVO.t_department }</td>
								<td>${elist.memberVO.t_name }</td>
								<td>
									<c:choose>
										<c:when test="${elist.e_rule == null}">
											<a href="documentContents?eidx=${elist.eidx}&tidx=${elist.tidx}" onclick="window.open(this.href, '_blank', 'width=770, height=915'); return false;" style="text-decoration : none; color:black;">
												<c:set var="content" value="${elist.e_textTitle}"/>
												<c:choose>
													<c:when test="${fn:length(elist.e_textTitle) > 50}">
														<c:out value="${fn:substring(content,0,50)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${elist.e_textTitle}"/>
													</c:otherwise> 
												</c:choose>
											</a>
										</c:when>
										<c:otherwise>
											<a href="/member/leaveView?eidx=${elist.eidx}" onclick="window.open(this.href, '_blank', 'width=770, height=630'); return false;" style="text-decoration : none; color:black;"><c:set var="content" value="${elist.e_textTitle}"/>
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
								<td>${elist.e_status }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div>
						
					</div>
					<div id="BtnBox">
						<%if(userPosition.equals("팀장")){%>
							<button type="button" class="btn btn-primary btn-sm float-right" id="myMust" onclick="self.location='documentListMy${paging.makeQuery(1)}&searchWord=<%=userPosition %>&userId=<%=userId%>&t_id=<%=userId%>'">나의 결재대기문서</button>
							<button type="button" id="writeBtn" class="btn btn-primary btn-sm float-right" onclick="documentWite()">기안 작성</button>
						<%}else{%>
							<button type="button" class="btn btn-primary btn-sm float-right" id="myMust" onclick="self.location='documentListMy${paging.makeQuery(1)}&searchWord=<%=userPosition %>&userId=<%=userId%>&t_id=<%=userId%>'">나의 결재대기문서</button>
							<button type="button" class="btn btn-primary btn-sm float-right" id="myToDo" onclick="self.location='documentListMy${paging.makeQuery(1)}&searchWord=<%=userPosition %>예정&userId=<%=userId%>&t_id=<%=userId%>'">나의 결재예정문서</button>
							<button type="button" id="writeBtn" class="btn btn-primary btn-sm float-right" onclick="documentWite()">기안 작성</button>
						<%} %>
					</div>
					</div>
					<div id="paging">
						<nav aria-label="Page navigation example" id="paging">
							<ul class="pagination">
								<c:if test="${paging.prev}">
									<li class="page-item" style="color:black;">
										<a class="page-link" href="documentListMy${paging.makeSearch(pageMaker.startPage - 1)}&t_id=<%=userId%>" aria-label="Previous">
										    <span aria-hidden="true">&laquo;</span>
										    <span class="sr-only"></span>
										</a>
									</li>
								</c:if> 
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
									<li class="page-item">
										<a class="page-link" href="documentListMy${paging.makeSearch(idx)}&t_id=<%=userId%>">${idx}</a>
									</li>
								</c:forEach>
								<c:if test="${paging.next && paging.endPage > 0}">
									<li class="page-item">
										<a class="page-link" href="documentListMy${paging.makeSearch(pageMaker.endPage + 1)}&t_id=<%=userId%>" aria-label="Next">
										    <span aria-hidden="true">&raquo;</span>
										    <span class="sr-only"></span>
										</a>
									</li>
								</c:if> 
							</ul>
			 			</nav>
					</div>
			</form>
		</div>
	</body>
</html>