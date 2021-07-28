<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>Afps</title> 
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
$(document).ready(function(){
	var domain = $("#domain").val();
	Swal.fire({
		title: "<img src='<c:url value='/resources/static/img/loginlogo.png'/>' style='width:200px;'>",
		text:"어서와",
		showCancelButton:true,
		confirmButtonText:"로그인",
		cancelButtonText:"테스터",
		cancelButtonColor:"#2778c4"
	}).then(result => {
		if(result.isConfirmed){
			location.href=domain+'/member/login';
		}else{
			var url = domain+"/tester";
			var name = "tester";
			var option = "width = 500, height = 400";
			window.open(url,name,option);
			location.href=domain+"/member/login";
		}
	});
});
</script>
</head>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
</body>
</html>
