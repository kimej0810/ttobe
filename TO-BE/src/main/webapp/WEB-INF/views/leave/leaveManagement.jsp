<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<span><a href="">근태현황</a></span>
		<span><a href="">연차일정</a></span>
		<span><a href="">연차관리</a></span>
	</div>
	<div>
		<input type="button" value="연차등록" onclick="regLeave();">
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
	<table border="1">
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
		</tbody>
	</table>
</body>
</html>