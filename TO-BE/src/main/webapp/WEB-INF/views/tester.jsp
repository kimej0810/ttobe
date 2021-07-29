<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>Afps</title> 
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
	$(document).ready(function(){
		$(document).on("click","#btn1",function(){
			$("#creator2").removeClass("show");
			$("#creator3").removeClass("show");
			$("#tester").removeClass("show");
		});
		$(document).on("click","#btn2",function(){
			$("#creator1").removeClass("show");
			$("#creator3").removeClass("show");
			$("#tester").removeClass("show");
		});
		$(document).on("click","#btn3",function(){
			$("#creator1").removeClass("show");
			$("#creator2").removeClass("show");
			$("#tester").removeClass("show");
		});
		$(document).on("click","#btn4",function(){
			$("#creator1").removeClass("show");
			$("#creator2").removeClass("show");
			$("#creator3").removeClass("show");
		});
	});
</script>
<style>
	body{
		background-color: lightgray;
	}
	.content{
		padding:2%;
		width:90%;
		height:94vh;
		background-color: white;
	    margin: auto;
	    margin-top: 3vh;
	    border-radius: 5px;
	    box-shadow: 0 0 5px 5px #afafaf;
	}
	.btnGroup{
		margin-top:3vh;
	}
	.card{
		height:70vh;
	}
	.card-body{
		padding:0;
	}
</style>
</head>
<body>
	<div class="content">
		<div class="mainLogo" >
			<img src="<c:url value="/resources/static/img/sideImg.png"/>" style="width:225px;margin:8px 0 0 15px;" alt='로고이미지'>
		</div>
		<div class="btnGroup input-group">
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator1"
				href="#creator1" role="button" aria-expanded="false" id="btn1">Creator_1</a>
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator2"
				href="#creator2" role="button" aria-expanded="false" id="btn2">Creator_2</a>
				<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator3"
				href="#creator3" role="button" aria-expanded="false" id="btn3">Creator_3</a>
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="tester"
				href="#tester" role="button" aria-expanded="false" id="btn4">Tester</a>
		</div>
		<div class="collapse" id="creator1">
			<div class="card card-body">
			
			</div>
		</div>
		<div class="collapse" id="creator2">
			<div class="card card-body">
			
			</div>
		</div>
		<div class="collapse" id="creator3">
			<div class="card card-body">
			
			</div>
		</div>
		<div class="collapse" id="tester">
			<div class="card  card-body">
				<table class="table" style="text-align:center;">
					<tr style="background-color: #6495ed9e;">
						<th scope="col" width="35%">아이디</th>
						<th scope="col" width="45%">비밀번호</th>
						<th scope="col" width="20%">비고</th>
					</tr>
					<tr>
						<td>admin</td>
						<td>210524</td>
						<td>관리자</td>
					</tr>
					<tr>
						<td>21-0000</td>
						<td>21-0000</td>
						<td>대표</td>
					</tr>
					<tr>
						<td>21-0001</td>
						<td>21-0001</td>
						<td>부장</td>
					</tr>
					<tr>
						<td>21-0002</td>
						<td>21-0002</td>
						<td>과장</td>
					</tr>
					<tr>
						<td>21-0003</td>
						<td>21-0003</td>
						<td>대리</td>
					</tr>
					<tr>
						<td>21-0004</td>
						<td>21-0004</td>
						<td>사원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
