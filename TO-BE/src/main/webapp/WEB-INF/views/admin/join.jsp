<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 등록</title>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<style>
body{
	background-color: #bfbfbf87;
}
.container{
	width:45%;
	height:85vh;
	margin:5% auto;
	box-shadow: 0 0 5px 5px lightgray;
	background-color: #fff;
	border-radius: 10px;
}
</style>
<script>

</script>
</head>
<body>
	<div class="container">
		<div class="header" style="text-align:center;">
			<img src="<c:url value="/resources/static/img/loginlogo.png"/>" style="width:150px;" alt="회사로고이미지">
		</div>
		<form action="/admin/joinAction" method="post" class="form">
			<div>
				<input type="text" name="t_id" value="" class="form-control" readonly="readonly">
				<input type="password" name="t_pwd" id="pwd" class="form-control">
				<input type="password" name="t_pwdRe" id="pwdRe" class="form-control">
			</div>
			<div style="text-align:right;">
				<input type="submit" class="btn btn-outline-secondary" value="등록하기">
			</div>
		</form>
	</div>
</body>
</html>