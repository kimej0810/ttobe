<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연차관리 페이지</title>
</head>
<body>
	<div>
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='/'">근태현황</button>
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='/'">연차관리</button>
	</div>
	<div>기간</div>
	<div>
		<span>발생 연차</span>
		<span>$</span>
		<span>사용 연차</span>
		<span>$</span>
		<span>잔여 연차</span>
		<span>$</span>
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
			<c:forEach items=""></c:forEach>
			<tr>
				<td>${list.a_status}</td>
				<td>${list.memberVO.t_department}</td>
				<td>${list.memberVO.t_id}</td>
				<td>${list.memberVO.t_name}</td>
				<td>${list.a_type}</td>
				<td>${list.a_usedays}</td>
				<td>${list.a_startdate}</td>
				<td>${list.a_enddate}</td>
			</tr>
		</tbody>
	</table>
	<div>
		<input type="button" value="연차등록" onclick="regLeave();">
	</div>
</body>
</html>