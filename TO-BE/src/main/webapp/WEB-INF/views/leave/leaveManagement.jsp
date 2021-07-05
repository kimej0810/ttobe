<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연차관리 페이지</title>
<script type="text/javascript">
	function regLeave(){ //기안서 팝업창
		var url = "addLeave";
		var name = "addLeave";
		var option = "width = 660, height = 870 left = 100, top=50,location=no";
		window.open(url,name,option)
	}
</script>
</head>
<body>
	<div>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='/commute/commute?t_id=${list[0].memberVO.t_id}'">근태현황</button>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='/leave/leaveManagement?t_id=${list[0].memberVO.t_id}'">연차관리</button>
		<%-- <c:forEach var="list" items="${list}" begin="1" end="1">
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='/commute/commute?t_id=${list.memberVO.t_id}'">근태현황</button>
			<button type="button" class="btn btn-outline-secondary" onclick="location.href='/leave/leaveManagement?t_id=${list.memberVO.t_id}'">연차관리</button>
		</c:forEach><!-- 그냥 리스트로 하면 안됨 왜안됨 버튼에 포이치를 쓰다니--> --%>
	</div>
	<div>기간</div>
	<div>
		<table class="table" border="1">
			
			<tr>
				<%-- <c:forEach var="list" items="${list}" begin="1" end="1"> --%>
				<th>발생 연차</th>
				<td>${list[0].memberVO.t_leave_get}</td>
			<%-- 	</c:forEach> --%>
				<th>사용 연차</th>
				<c:forEach var="alist" items="${list}" varStatus="status">
					<c:set var="sum" value="${sum+alist.a_useddays}"></c:set>
				</c:forEach>
				<td><c:out value="${sum}"/></td>
				<th>잔여 연차</th>
				
				<td></td>
			</tr>
		</table>
	</div>
	<table class="table" border="1">
		<thead>
			<tr>
				<th>상태</th>
				<th>부서</th>
				<th>사원번호</th>
				<th>이름</th>
				<th>연차유형</th>
				<th>사용일수</th>
				<th>시작일</th>
				<th>종료일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="alist">
				<tr>
					<td>${alist.a_status}</td>
					<td>${alist.memberVO.t_department}</td>
					<td>${alist.memberVO.t_id}</td>
					<td>${alist.memberVO.t_name}</td>
					<td>${alist.a_type}</td>
					<td>${alist.a_useddays}</td>
					<td>${alist.a_startdate}</td>
					<td>${alist.a_enddate}</td>
				</tr>
				<input type="hidden" value="${alist.aidx}" id="aidx" name="aidx">
			</c:forEach>
		</tbody>
	</table>
	<div>
		<input type="button" value="연차등록" onclick="regLeave();">
		
	</div>
</body>
</html>