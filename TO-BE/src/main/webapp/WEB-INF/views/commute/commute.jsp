<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function startWork(){
		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth()+1;
		var date = today.getDate();
		
		console.log(year+"/"+month+"/"+date);
	}
</script>
</head>
<body>
	<div>
		<span><a href="">근태현황</a></span>
		<span><a href="">연차일정</a></span>
		<span><a href="">연차관리</a></span>
	</div>
	<div>기간</div>
	<div>
		<span>총 근무시간</span>
		<span></span>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>근태유형</th>
				<th>출퇴근일자</th>
				<th>출근기록</th>
				<th>퇴근기록</th>
				<th>근무시간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>ㄴㄴㄴ</td>
			</tr>
		</tbody>		
	</table>
	
	<button type="button" name="startWork" onclick="startWork();">출근</button>
	<button type="button" name="endWork">퇴근</button>
</body>
</html>