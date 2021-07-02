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
<script>
	$(document).ready(function(){
		$(".searBtn").on("click",function(event){
			self.location = "/admin/emaillist${pageMaker.makeQuery(1)}&searchType="+$("select option:selected").val()
			+ "&keyword="+encodeURIComponent($(".searInput").val());
		});
		$("#checkAll").click(function(){
			if($(this).prop("checked")){
				$(".btn").prop("checked",true);
			}else{
				$(".btn").prop("checked",false);
			}
		});
		$("#deleteBtn").on("click",function(){
			var chkArray = new Array();
			$(".btn:checked").each(function(){
				chkArray.push(this.value);				
			});
			if(confirm('해당 글을 삭제하시겠습니까?')){
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				url:"/admin/emailDelete",
				data:{"eidxList" : chkArray},
				dataType:"json",
				success:function(data){
					if(data==0){
						alert("삭제실패");
					}else{
						location.href = "/admin/emaillist";
					}
				}
			});
			}else{
				$(".btn").prop("checked",false);
			}
		});
	});
	function sendFn(){
		if(confirm('사원리스트를 보시겠습니까?')){
			window.open(
				"/admin/memberList",
				"memberList",
				"width=600,height=550,location=no,status=no,toolbar=no,scrollbars=no"
			);	
		}else{
			location.href = "/admin/email";
		}
		
	}
</script>
<style>
    .tableBtn{
    	float:right;
    }
    .pageDiv a{
    	color:#0a58ca;
    }
    .emailtable a{
    	text-decoration: none;
    	color:black;
    }
    .emailtable a:hover{
    	color:red;
    }
	.saoneBtn{
    	grid-column:2/3;
    	display:inline;
    }
    #active a{
    	background-color: #0a58ca7d;
    	color:black;
    }
    #search{
		width:100%;
		display:grid;
		grid-template-columns:1fr minmax(70px, auto);
	}
	.input-group{
		grid-column:2/3;
	}
	.page-item{
		padding:0;
	}
	.pageDiv ul{
		justify-content:center;
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

<form>
	<div class="headerT">
		<button class="btn btn-outline-secondary" type="button">메일 발송함</button>
	</div>
	<div id="search">
		<div class="input-group mb-3">
			<!-- 없음n 제목t, 내용c, 작성자w, -->
			<select name="searchType" id="searchType" class="form-select" style="height:30px; font-size:0.5rem;">
				<option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : '' }"/>>::선택::</option>
				<option value="t" <c:out value="${searchCriteria.searchType eq 't' ? 'selected' : '' }"/>>제목</option>
				<option value="c" <c:out value="${searchCriteria.searchType eq 'c' ? 'selected' : '' }"/>>내용</option>
				<option value="w" <c:out value="${searchCriteria.searchType eq 'w' ? 'selected' : '' }"/>>수신인</option>
			</select>
			<input type="text" style="height:30px; width:40%; font-size:0.5rem;" class="searInput form-control" name="keyword" value="${searchCriteria.keyword}" placeholder="검색">
			<div class="input-group-prepend">
				<button style="height:30px; font-size:0.5rem;" class="searBtn btn btn-outline-secondary" type="button">검색</button>
			</div>
		</div>
	</div>
	<table class="emailtable table table-hover" style="text-align:center;">
		<thead>
			<tr>
				<th scope="col" width="3%"><input type="checkbox" class="btnAll" id="checkAll"></th>
				<th scope="col" width="5%">번호</th>
				<th scope="col" width="10%">수신인</th>
				<th scope="col" width="7%">부서</th>
				<th scope="col" width="5%">직급</th>
				<th scope="col" width="20%">이메일</th>
				<th scope="col" width="30%">제목</th>
				<th scope="col">발송일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${articles}" var="email">
			<tr class="saoneGo">
				<td><input type="checkbox" value="${email.midx}" class="btn"></td>
				<td>${email.midx}</td>
				<td>${email.t_name }</td>
				<td>${email.t_department}</td>
				<td>${email.t_position}</td>
				<td>${email.m_addressee}</td>
				<td>
					<a href="${path}/admin/emailread${pageMaker.makeSearch(pageMaker.cri.page)}&midx=${email.midx}">${email.m_title}</a>
				</td>
				<td>
					<c:set var="sendDate" value="${email.m_senddate}"/>
					${fn:substring(sendDate,0,16)}
					<input type="hidden" value="${email.midx}">
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<nav class="pageDiv">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="page-item"><a class="page-link" href="${path}/admin/emaillist${pageMaker.makeSearch(pageMaker.startPage-1)}">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li class="page-item" <c:out value="${pageMaker.cri.page == idx ? 'id=active' : ''}"/>>
					<a class="page-link" href="${path}/admin/emaillist${pageMaker.makeSearch(idx)}">${idx}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class="page-item"><a class="page-link" href="${path}/admin/emaillist${pageMaker.makeSearch(pageMaker.endPage + 1)}">&raquo;</a></li>
			</c:if>
		</ul>
	</nav>
	<div class="tableBtn">
		<input type="button" class="saoneBtn btn btn-primary btn-sm float-right" onclick="sendFn()" value="메일 발송">
		<input type="button" id="deleteBtn" class="saoneBtn btn btn-danger btn-sm float-right" value="삭제">
	</div>
</form>
</body>
</html>
