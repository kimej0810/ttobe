<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.content{
		display:block;
	}
	.btnwrap{
		text-align: center;
		margin: 10px;
	}
	table{
		margin-top: 70px;
		border-spacing: 10px;
		border-collapse: separate;
	}
</style>
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
<button type="button" class="btn btn-outline-secondary" onclick="location.href='/member/mypage?tidx=${member.tidx}'">사원정보변경</button>
<button type="button" class="btn btn-outline-secondary" onclick="location.href='/member/modifyPwd?t_id=${member.t_id}'">비밀번호변경</button>
<form name="frm">
	<table align="center">
		<tr>
			<td>새 비밀번호</td>
			<td><input type="password" name="t_pwd" id="t_pwd" placeholder="새 비밀번호 입력"></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인</td>
			<td><input type="password" id="newPwd" placeholder="새 비밀번호 입력 확인"></td>
		</tr>
	</table>
	<div class="btnwrap">
		<button type="button" onclick="modifyPwd();" class="btn btn-outline-primary btn-sm">수정</button>
		<button type="button" onclick="location.href='/main/mainPage'" class="btn btn-outline-danger btn-sm">취소</button>
		<input type="hidden" name="t_id" value="${member.t_id}"/>
	</div>
</form>

					
					
</body>
</html>