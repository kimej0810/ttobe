<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	if(request.getAttribute("idnull")!=null){
		String check = (String)request.getAttribute("idnull");
		if(check.equals("id_error")){
			out.println("<script>alert('아이디가 일치하지않습니다.');history.back();</script>");			
		}else if(check.equals("pw_error")){
			out.println("<script>alert('아이디와 비밀번호가 일치하지않습니다.');history.back();</script>");
		}
	}else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	}
	%>
</body>
</html>