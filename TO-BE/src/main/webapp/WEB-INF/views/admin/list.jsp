<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="tobe.project.dto.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 리스트</title>
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
<style>
    .sub{
	    width: 100%;
	    height: 98vh;
	    padding:1%;
    }
    .tableDiv{
    	margin-top:30px;
    	font-size:18px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    .saoneGo:hover{
    	background-color: #ffd4006e;
    	cursor:pointer;
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
    }
    .searInput{
    	width:140px;
    	height:22px;
 	    border: 2px solid lightgray;
    	border-radius: 5px;
    }
    thead{
    	font-size:20px;
    }
    tbody{
    	text-align:center;
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
    .saoneGoTag{
    	display:none;
    }
	.active{
    	background-color: #ffd4006e;
    }
    .pageDiv a{
    	text-decoration: none;
    	color:black;
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
	<div class="headerT"><h1>사원관리</h1></div>
	<div class="tableDiv">
		<form name="frm" method="post">
			<div class="searDiv">
				<select name="searchType" id="searchType">
					<option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : '' }"/>>:::::선택:::::</option>
					<option value="a" <c:out value="${searchCriteria.searchType eq 'a' ? 'selected' : '' }"/>>일반주소</option>
					<option value="b" <c:out value="${searchCriteria.searchType eq 'b' ? 'selected' : '' }"/>>상세주소</option>
					<option value="u" <c:out value="${searchCriteria.searchType eq 'u' ? 'selected' : '' }"/>>이름</option>
				</select>
				<input type="text" class="searInput" name="keyword" value="${searchCriteria.keyword}" placeholder="검색">
				<input type="button" class="searBtn" value="검색">
			</div>
			<table>
				<colgroup>
					<col width="5%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="10%"></col>
					<col width="15%"></col>
					<col width="15%"></col>
					<col width="20%"></col>
					<col width="10%"></col>
					<col width="5%"></col>
				</colgroup>
				<thead>
					<tr>
						<th>사원이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>이메일</th>
						<th>연락처</th>
						<th>주소</th>
						<th>입사일</th>
						<th>퇴사유무</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${memberList}" var="member">
					<tr class="saoneGo">
						<td>${member.t_name}</td>
						<td>${member.t_department}</td>
						<td>${member.t_position}</td>
						<td>${member.t_email}</td>
						<td>${member.t_phone}</td>
						<td>${member.t_addr_general}</td>
						<td>
							<c:set var="joinDate" value="${member.t_join_date}"/>
							${fn:substring(joinDate,0,10)}
						</td>
						<td>${member.delyn}</td>
					</tr>
					<tr>
						<td colspan="9">
							<div class="saoneGoTag">
								<button type="button" class="saoneBtn" onclick="location.href='${path}/admin/info${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}'">정보보기</button>
								<button type="button" class="saoneBtn" onclick="location.href='${path}/admin/email${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}'">메일전송</button>
								<button type="button" id="deleteBtn" class="saoneBtn">사원 퇴사</button>
								<input type="hidden" value="${member.tidx}">
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="pageDiv">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="pageed"><a href="${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.startPage-1)}">&lt;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
							<a href="${path}/admin/memberlist${pageMaker.makeSearch(idx)}">${idx}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="pageed"><a href="${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.endPage + 1)}">&gt;</a></li>
					</c:if>
				</ul>
			</div>
			<div class="tableBtn">
				<a href="/admin/add"><input type="button" class="saoneBtn" value="사원 등록"></a>
			</div>
		</form>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".searBtn").on("click",function(event){
			self.location = "/admin/memberlist${pageMaker.makeQuery(1)}&searchType="+$("select option:selected").val()
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
				document.frm.action = "/admin/delete?tidx="+tidx;
				document.frm.submit();
			}else{
				
			}
		});
	});
</script>
</body>
</html>
