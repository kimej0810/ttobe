<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>find password page</title>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
<style type="text/css">
	@font-face {
            font-family: 'NanumSquareRound';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
	html{
		font-family: 'NanumSquareRound';
        font-size: 15px;
	}
	form{
		width: 60%;
		height: 60%;
		margin: 5vh auto;
	}
	.btnWrap{
		text-align: right;
		margin: 10px 0px;
	}
	#title{
		text-align: center;
		font-size: 20px;
		font-weight: bold;
	}
	.inputWrap{
		margin: 10px 0px;
	}
</style>
</head>
<body>	
	<form action="${pageContext.request.contextPath}/member/findPwd" method="POST">
		<div id="title">비밀번호 찾기</div>
		<div class="inputWrap">
			<label for="t_id">ID</label>
			<input type="text" name="t_id" id="t_id" class="form-control" placeholder="회원가입한 아이디를 입력해주세요." required="required">
		</div>
		<div class="inputWrap">
			<label for="t_email">E-MAIL</label>
			<input type="text" name="t_email" id="t_email" class="form-control" placeholder="회원가입한 이메일을 입력해주세요." required="required">
		</div>
		<div class="btnWrap">
			<button type="submit" id="btn_findPwd" class="btn btn-outline-primary btn-sm">찾기</button>
			<button type="button" onclick="self.close();" class="btn btn-outline-danger btn-sm">취소</button>
		</div>
		<div>
			가입하신 이메일로 비밀번호를 전송해드리겠습니다.
		</div>
	</form>
</body>
</html>