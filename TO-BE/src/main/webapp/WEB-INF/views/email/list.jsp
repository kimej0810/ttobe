<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 발송함</title>
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<link href="<c:url value="/resources/static/css/bootstrap.css"/>" rel='stylesheet' />
<script>
	
	$(document).ready(function(){
		$(".searBtn").on("click",function(event){
			self.location = "/admin/emaillist${pageMaker.makeQuery(1)}&searchType="+$("select option:selected").val()
			+ "&keyword="+encodeURIComponent($(".searInput").val());
		});
	});
	function sendFn(){
		window.open(
			"/admin/memberList",
			"memberList",
			"width=600,height=550,location=no,status=no,toolbar=no,scrollbars=no"
		);
	}
</script>
<style>
    .sub{
	    width: 100%;
	    height: 98vh;
	    padding:1%;
    }
    .tableDiv{
    	font-size:18px;
		float:right;	
    }
    .tableBtn{
    	text-align:right;
    	margin-right:1%;
    }
    .saoneGo:hover{
    	background-color: #ffd4006e;
    }
    .pageDiv a{
    	text-decoration: none;
    	color:black;
    }
    a:hover{
    	color:red;
    }
    .pagination li{
    	list-style-type:none;
    	float:left;
    	margin:0 10px 0 0;
    	border:1px solid black;
    	width:30px;
    	height:30px;
    	border-radius:5px;
    }
    .pageed{
    	width:50px;
    }
    .pageDiv{
    	width:400px;
    	height:50px;
    	margin:0 auto;
    	text-align:center;
    }
    .saoneBtn{
    	width:100px;
    	height:30px;
	    border-radius: 5px;
	    background-color: #ffd4006e;
    }
    .searDiv{
    	text-align:right;
    	margin-right:1%;
    }
    .searBtn{
    	width:80px;
    	height:30px;
	border-radius: 5px;
	background-color: #ffd4006e;
	padding:0;
	margin:-8px;
	color:black;
    }
    .searInput{
    	width:140px;
    	height:22px;
 	border: 2px solid lightgray;
    	border-radius: 5px;
	display:inline;
    }
    thead{
    	font-size:20px;
    }
    tbody{
    	text-align:center;
    }
	#searchType{
    	display:inline;
    	width:120px;
    }
    .active{
    	background-color: #ffd4006e;
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
	}/* else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	} */
%>
<div class="sub">
	<div class="headerT"><h1>메일 발송함</h1></div>
	<div class="tableDiv">
		<form>
			<div class="searDiv">
				<!-- 없음n 제목t, 내용c, 작성자w, -->
				<select name="searchType" id="searchType" class="form-select form-select-sm">
					<option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : '' }"/>>:::::선택:::::</option>
					<option value="t" <c:out value="${searchCriteria.searchType eq 't' ? 'selected' : '' }"/>>제목</option>
					<option value="c" <c:out value="${searchCriteria.searchType eq 'c' ? 'selected' : '' }"/>>내용</option>
					<option value="w" <c:out value="${searchCriteria.searchType eq 'w' ? 'selected' : '' }"/>>수신인</option>
				</select>
				<input type="text" class="searInput form-control form-control-sm"" name="keyword" value="${searchCriteria.keyword}" placeholder="검색">
				<input type="button" class="searBtn btn btn-outline-warning" value="검색">
			</div>
			<table>
				<colgroup>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="20%"></col>
					<col width="20%"></col>
					<col width="10%"></col>
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox"></th>
						<th>번호</th>
						<th>수신인</th>
						<th>부서</th>
						<th>직급</th>
						<th>이메일</th>
						<th>제목</th>
						<th>발송일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${articles}" var="email">
					<tr class="saoneGo">
						<td><input type="checkbox" value="${email.midx}"></td>
						<td>${email.midx}</td>
						<td>받은사람</td>
						<td>부서</td>
						<td>직급</td>
						<td>${email.m_addressee}</td>
						<td>
							<a href="${path}/admin/emailread${pageMaker.makeSearch(pageMaker.cri.page)}&midx=${email.midx}">${email.m_title}</a>
						</td>
						<td>
							<c:set var="sendDate" value="${email.m_senddate}"/>
							${fn:substring(sendDate,0,16)}
						</td>
						<td><input type="hidden" value="${email.midx}"></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="pageDiv">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="pageed"><a href="${path}/admin/emaillist${pageMaker.makeSearch(pageMaker.startPage-1)}">&lt;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
							<a href="${path}/admin/emaillist${pageMaker.makeSearch(idx)}">${idx}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="pageed"><a href="${path}/admin/emaillist${pageMaker.makeSearch(pageMaker.endPage + 1)}">&gt;</a></li>
					</c:if>
				</ul>
			</div>
			<div class="tableBtn">
				<input type="button" class="saoneBtn" onclick="sendFn()" value="메일 발송">
				<input type="button" class="saoneBtn" value="삭제">
			</div>
		</form>
		<form id="listPageForm">
			<input type="hidden" name="page" value="${pageMaker.cri.page}">
			<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}">
		</form>
	</div>
</div>
</body>
</html>
