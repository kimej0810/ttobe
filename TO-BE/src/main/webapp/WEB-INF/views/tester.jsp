<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>Afps</title> 
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>

</script>
<style>
	body{
		background-color: lightgray;
	}
	.content{
		padding:2%;
		width:90%;
		height:90vh;
		background-color: white;
	    margin: auto;
	    margin-top: 5vh;
	    border-radius: 5px;
	    box-shadow: 0 0 5px 5px #afafaf;
	}
	.user{
		margin-top:5vh;
	}
</style>
</head>
<body>
	<div class="content">
		<div class="mainLogo" >
			<img src="<c:url value="/resources/static/img/sideImg.png"/>" style="width:225px;margin:8px 0 0 15px;" alt='로고이미지'>
		</div>
		<div class="user">
			<table class="table" style="text-align:center;">
				<tr style="background-color: #6495ed9e;">
					<th scope="col" width="35%">아이디</th>
					<th scope="col" width="45%">비밀번호</th>
					<th scope="col" width="20%">비고</th>
				</tr>
				<tr>
					<td>admin</td>
					<td>123456789</td>
					<td>관리자</td>
				</tr>
				<tr>
					<td>admin</td>
					<td>123456789</td>
					<td>관리자</td>
				</tr>
				<tr>
					<td>admin</td>
					<td>123456789</td>
					<td>관리자</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
