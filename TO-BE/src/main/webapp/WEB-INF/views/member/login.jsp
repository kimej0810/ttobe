<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<style type="text/css">

	.login-form{
		width: 60%;
		height: 50%;
		max-width: 400px;
		max-height: 600px;
		margin: 10vh auto;
	}
	#logo{
		width: 200px;
	}
	.form-control{
		margin: 10px 0px;
	}
	.error{
		color: red;
	}
	#btnLogin{
		margin: 5px 0px;
	}
</style>
<script type="text/javascript">
	var domain = $("#domain").val();
	function checkLogin(){
		
		if($("#t_id").val() == ""){
			$("#empty_id").css("display","block");
			$("#t_id").focus();
			return;
		}else if($("#t_pwd").val() == ""){
			$("#empty_pwd").css("display","block");
			$("#t_pwd").focus();
			return;
		}
		
		frm.action = $("#domain").val()+"/member/loginPost";
		frm.method = "post";
		frm.submit();
	}
	
	function enterLogin(){
		 
		var keyCode = window.event.keyCode;
		 
		 if(keyCode == 13){
			 checkLogin();
		 }
	}
	
	$(document).ready(function(){
		
		var key = getCookie("key");
		$("#t_id").val(key);
		
		if($("#t_id").val != ""){
			$("#useCookie").attr("checked", true);
		}
		
		$("#useCookie").change(function(){
			if($("#useCookie").is(":checked")){
				setCookie("key", $("#t_id").val(), 7);
			}else{
				deleteCookie("key");
			}
		});
		
		$("#t_id").keyup(function(){ 
	        if($("#useCookie").is(":checked")){ 
	            setCookie("key", $("#t_id").val(), 7); 
	        }
	    });
		
	});
	
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1) end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
	function popupOpen(){
		var popupX = (window.screen.width / 2) - (600 / 2);
		var popupY= (window.screen.height / 2) - (350 / 2);
		window.open($("#domain").val()+'/member/findPwd', '비밀번호찾기', 'status=no, height=350, width=600, left='+ popupX + ', top='+ popupY);
	}
</script>
</head>
<body onkeydown="javascript:enterLogin();">
	<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
	<section class="login-form">
		<img id="logo" class="img-responsive w-100" src="<c:url value='/resources/static/img/loginlogo.png'/>" alt="A few persons logo" title="afps_logo_image">
		<form name="frm">
			<div>
				<input type="text" name="t_id" id="t_id" placeholder="아이디" aria-live="assertive" class="form-control">
			</div>
			<div class="error" id="empty_id" style="display:none">아이디를 입력해주세요.</div>
			<div>
				<input type="password" name="t_pwd" id="t_pwd" placeholder="비밀번호" class="form-control">
			</div>
			<div class="error" id="empty_pwd" style="display:none" aria-live="assertive">비밀번호를 입력해주세요.</div>
			<div>
				<input type="checkbox" name="useCookie" id="useCookie">
				<label for="useCookie">아이디 저장</label>
			</div>
			<div>
				<button type="button" onclick="checkLogin();" class="btn btn-primary w-100" id="btnLogin">LOGIN</button>
			</div>
			<div>
				비밀번호를 잊으셨나요?&nbsp;&nbsp;<button type="button" onclick="popupOpen();" class="btn btn-link">비밀번호찾기</button>
			</div>
			<div>
				<%
					Integer admin = 0;
					if(session.getAttribute("admin")!=null){
						admin = (Integer)session.getAttribute("admin");
						if(admin==0){
							
				%>
					<span>관리자가 없습니다.?&nbsp;&nbsp;</span>
					<a href="${pageContext.request.contextPath}/admin/findAdmin">관리자등록</a>
				<%
						}
					}
				%>
			</div>
		</form>
	</section>
</body>
</html>
