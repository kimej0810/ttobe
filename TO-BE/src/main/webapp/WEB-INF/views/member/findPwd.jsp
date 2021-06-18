<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find password page</title>
</head>
<body>	
	<form action="/member/findPwd" method="POST">
		<div>
			<label for="t_id">ID</label>
			<input type="text" name="t_id" id="t_id" placeholder="회원가입한 아이디를 입력해주세요." required="required">
		</div>
		<div>
			<label for="t_email">E-MAIL</label>
			<input type="text" name="t_email" id="t_email" placeholder="회원가입한 이메일을 입력해주세요." required="required">
		</div>
		<div>
			<button type="submit" id="btn_findPwd">찾기</button>
			<button type="button" onclick="self.close();">취소</button>
		</div>
		<div>
			가입하신 이메일로 비밀번호를 전송해드리겠습니다.
		</div>
	</form>
</body>
</html>