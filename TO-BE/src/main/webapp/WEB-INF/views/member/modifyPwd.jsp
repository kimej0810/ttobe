<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function modifyPwd(){
	
		var ex = document.getElementById("newPwd").value;
		
		if(frm.t_pwd.value != ex){
			alert("비밀번호 확인이 다릅니다.");
			frm.newPwd.focus();
			return;
		}
		var result = confirm("비밀번호를 변경하시겠습니까?");
		if(result){
			//window.opener.name ="modify";
			//document.frm.target = "modify";
			frm.action = "/member/modifyPwdAction";
			frm.method = "POST";
			frm.submit();
			//frm.target = "_self";
			//setTimeout(closeFn(),5000);
			//closeFn();
			//window.open("about:blank","_self").close();
		}//else{
			//self.close();
		//}
	}
</script>
</head>
<body>
<button type="button"><a href="/member/mypage?tidx=${member.tidx}">사원정보변경</button>
<button type="button"><a href="/member/modifyPwd?t_id=${member.t_id}">비밀번호번경</a></button>
<form name="frm">
	<table>
		<tr>
			<td>새 비밀번호</td>
			<td><input type="password" name="t_pwd" id="t_pwd" placeholder="새 비밀번호 입력"></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인</td>	
			<td><input type="password" id="newPwd" placeholder="새 비밀번호 입력 확인"></td>
		</tr>
	</table>
	<button type="button" onclick="modifyPwd();">수정</button>
	<button type="button" onclick="history.go(-2);">취소</button>
	<input type="hidden" name="t_id" value="${member.t_id}"/>
</form>

					
					
</body>
</html>