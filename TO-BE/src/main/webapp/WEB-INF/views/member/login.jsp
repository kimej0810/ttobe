<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script language="javascript">
	function checkLogin(){
		
		if(frm.t_id.value == ""){
			document.getElementById("empty_id").style.display = "block";
			frm.t_id.focus();
			return;
		}else if(frm.t_pwd.value == ""){
			document.getElementById("empty_pwd").style.display = "block";
			frm.t_pwd.focus();
			return;
		}
		
		frm.action = "/member/loginPost";
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
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
</script>
</head>
<body onkeydown="javascript:enterLogin();">
	<section class="login-form">
		<h1>TO-BE</h1>
		<form name="frm">
			<div>
				<input type="text" name="t_id" id="t_id" placeholder="아이디" aria-live="assertive">
			</div>
			<div class="error" id="empty_id" style="display:none">아이디를 입력해주세요.</div>
			<div>
				<input type="password" name="t_pwd" id="t_pwd" placeholder="비밀번호">
			</div>
			<div class="error" id="empty_pwd" style="display:none" aria-live="assertive">비밀번호를 입력해주세요.</div>
			<div>
				<input type="checkbox" name="useCookie" id="useCookie">
				<label for="useCookie">아이디 저장</label>
			</div>
			<div>
				<button type="button" onclick="checkLogin();">LOGIN</button>
			</div>
			<div>
				비밀번호를 잊으셨나요?<a href="/member/findPwd" onclick="window.open(this.href, '비밀번호찾기', 'width=500,height=500,top=200,left=100'); return false;">비밀번호 찾기</a>
			</div>
		</form>
	</section>
</body>
</html>