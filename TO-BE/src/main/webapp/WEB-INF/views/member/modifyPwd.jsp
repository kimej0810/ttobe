<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			frm.action = "/member/modifyPwdAction";
			frm.method = "POST";
			frm.submit();
			window.open("about:blank","_self").close();
		}else{
			self.close();
		}
	}
</script>
</head>
<body>
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
	<button type="button" onclick="self.close();">취소</button>
	<input type="hidden" value="${member.t_id}"/>
</form>

					
					
</body>
</html>