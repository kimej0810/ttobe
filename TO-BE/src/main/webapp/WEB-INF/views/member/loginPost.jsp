<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</head>
<body>
	<script type="text/javascript">
		var domain = document.getElementById("domain").value;
		self.location = domain+"/main/main";
	</script>
	<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
</body>
</html>