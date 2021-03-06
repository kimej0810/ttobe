<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="tobe.project.dto.*"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 리스트</title>
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script>
	$(document).ready(function(){
		$(".searBtn").on("click",function(event){
			self.location = $("#domain").val()+"/admin/memberlist${pageMaker.makeQuery(1)}&searchType="+$("select option:selected").val()
			+ "&keyword="+encodeURIComponent($(".searInput").val());
		});
		$(".saoneGo").on("click",function(){
			var saoneGoTag = $(this).next("tr").children().children(".saoneGoTag");
			if(saoneGoTag.is(":visible")){
				saoneGoTag.slideUp();
			}else{
				saoneGoTag.slideDown();
			}
		});
		$(document).on("click","#deleteBtn", function(){
			var tidx = $(this).next().val();
			if(confirm('해당을 퇴사처리 하시겠습니까?')){
				document.frm.action = $("#domain").val()+"/admin/delete?tidx="+tidx;
				document.frm.submit();
			}else{
				
			}
		});
		$(document).on("click","#active",function(e){
			e.preventDefault();
		});
	});
</script>
<style>
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    .searDiv{
    	width:100%;
		display:grid;
		grid-template-columns:1fr minmax(70px, auto);
    }
    .input-group{
		grid-column:2/3;
	}
    .saoneGoTag{
    	display:none;
    }
	#active a{
    	background-color: #0a58ca7d;
    	color:black;
    	cursor: context-menu;
    }
    .pageDiv a{
    	color:#0a58ca;
    }
    .pageDiv ul{
    	justify-content:center;
    }
    table{
    	text-align:center;
    }
    .saoneGo:hover{
    	cursor: pointer;
    }
    .page-item{
    	padding:0;
    }
    #byeMember{
  	background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="" y1="50%" x2="100%" y2="50%" stroke="gray" /></svg>');
  }
</style>
</head>
<body>
<%
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
		String uGrade = (String)session.getAttribute("userGrade");
		if(!uGrade.equals("A")){
			out.println("<script>alert('접근 권한이 없습니다.');history.back();</script>");
		}
	}
%>
<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
<div class="sub">
	<div class="headerT">
		<button class="btn btn-outline-secondary" type="button">사원관리</button>
	</div>
	<div class="tableDiv">
		<form name="frm" method="post">
			<div class="searDiv">
				<div class="input-group mb-3">
					<select name="searchType" id="searchType" class="form-select" style="height:30px; font-size:0.5rem;">
						<option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : '' }"/>>::선택::</option>
						<option value="u" <c:out value="${searchCriteria.searchType eq 'u' ? 'selected' : '' }"/>>이름</option>
						<option value="d" <c:out value="${searchCriteria.searchType eq 'd' ? 'selected' : '' }"/>>부서</option>
						<option value="p" <c:out value="${searchCriteria.searchType eq 'p' ? 'selected' : '' }"/>>직급</option>
					</select>
					<input type="text" style="height:30px; width:40%; font-size:0.5rem;" class="searInput form-control" name="keyword" value="${searchCriteria.keyword}" placeholder="검색">
					<input type="button" style="height:30px; font-size:0.5rem;" class="searBtn btn btn-outline-secondary" value="검색">
				</div>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col" width="10%">사원이름</th>
						<th scope="col" width="8%">부서</th>
						<th scope="col" width="7%">직급</th>
						<th scope="col" width="20%">이메일</th>
						<th scope="col" width="15%">연락처</th>
						<th scope="col" width="15%">입사일</th>
						<th scope="col" width="10%">퇴사유무</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${memberList}" var="member">
					<c:if test="${member.delyn eq 'A' }">
					
					</c:if>
					<c:if test="${member.delyn eq 'N' }">
						<tr class="saoneGo">
							<td>${member.t_name}</td>
							<td>${member.t_department}</td>
							<td>${member.t_position}</td>
							<td>${member.t_email}</td>
							<td>${member.t_phone}</td>
							<td>
								<c:set var="joinDate" value="${member.t_join_date}"/>
								${fn:substring(joinDate,0,10)}
							</td>
							<td class="delyn">재직중</td>
						</tr>
					</c:if>
					<c:if test="${member.delyn eq 'Y' }">
						<tr class="saoneGo" id="byeMember" style="cursor: context-menu;">
							<td>${member.t_name}</td>
							<td>${member.t_department}</td>
							<td>${member.t_position}</td>
							<td>${member.t_email}</td>
							<td>${member.t_phone}</td>
							<td>
								<c:set var="joinDate" value="${member.t_join_date}"/>
								${fn:substring(joinDate,0,10)}
							</td>
							<td class="delyn">퇴사</td>
						</tr>
					</c:if>
					<c:if test="${member.delyn eq 'N' }">
					<tr>
						<td colspan="9" style="padding:0;text-align:center;">
							<div class="saoneGoTag">
								<button type="button" class="saoneBtn btn btn-outline-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/admin/info${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}'">정보보기</button>
								<button type="button" class="saoneBtn btn btn-outline-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/email/email${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}'">메일전송</button>
								<button type="button" id="deleteBtn" class="saoneBtn btn btn-outline-danger btn-sm">사원 퇴사</button>
								<input type="hidden" value="${member.tidx}">
							</div>
						</td>
					</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
			<div class="pageDiv">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/memberlist${pageMaker.makeSearch(pageMaker.startPage-1)}">&lt;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li  class="page-item" <c:out value="${pageMaker.cri.page == idx ? 'id=active' : ''}"/>>
							<a class="page-link" href="${pageContext.request.contextPath}/admin/memberlist${pageMaker.makeSearch(idx)}">${idx}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin/memberlist${pageMaker.makeSearch(pageMaker.endPage + 1)}">&gt;</a></li>
					</c:if>
				</ul>
			</div>
			<div class="tableBtn">
				<a href="${pageContext.request.contextPath}/admin/add"><input type="button" class="saoneBtn btn btn-primary btn-sm" value="사원 등록"></a>
			</div>
		</form>
	</div>
</div>
<script>
	$("#xlawkd").on("click",function(){
		var searchType = $(this).val();
		var keyword = $.trim($(this).text());
		$.ajax({
			url:$("#domain").val()+"/admin/test",
			data:"searchType="+searchType+"&keyword="+keyword,
			dataType:"json",
			success:function(mvo){
				var timList = "";
				
				for(var i = 0 ; i < mvo.length; i++){
					timList += "<option value='"+mvo[i].t_name+"'>"+mvo[i].t_name+mvo[i].t_department+"</option>";
				}
				$("#xlawkd").html(timList);
				$("#xlawkd").attr("id","xladnjs");
			}
		});
	});
	$("#btbtn").on("click",function(){
		alert($("#xladnjs").val());
	});
</script>
</body>
</html>
