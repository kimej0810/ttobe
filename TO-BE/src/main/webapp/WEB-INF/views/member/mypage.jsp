<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my page</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/*
	$(documnet).ready(function(){
		$("#modifyMember").click(function({
			
				
		});
		
	});
	*/
    function findZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
               
                var addr = '';

                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }
				// $("[name=addr1]").val(data.zonecode);
                document.getElementById('t_addr_zipcode').value = data.zonecode;
                document.getElementById("t_addr_general").value = addr;
                document.getElementById("t_addr_detail").focus();
                
            }
        }).open();
    }
	
	function modifyMember(){
		
		var ex = document.getElementById("newPwd").value;
		
		if(frm.t_pwd.value != ex){
			alert("비밀번호 확인이 다릅니다.");
			frm.newPwd.focus();
			return;
		}
		var result = confirm("정보를 수정하시겠습니까?");
		if(result){
			frm.action = "/member/modifyMember";
			frm.method= "POST";
			frm.submit();	
		}else{
			history.go(-1);
		}
	}
	
	
</script>
</head>
<body>
	<form name="frm" enctype="multipart/form-data">
		<table border="1">
			<tbody>
				<tr>
					<td>비밀번호 변경</td>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" name="t_pwd" id="t_pwd" placeholder="새 비밀번호 입력"></td>
					<td>새 비밀번호 확인</td>	
					<td><input type="password" id="newPwd" placeholder="새 비밀번호 입력 확인"></td>
				</tr>
				<tr>
					<td>직장정보</td>
				</tr>
				<tr>
					<td>사원번호</td>
					<td><input type="text" name="t_id" value="${member.t_id}" readonly style="border:0px;"></td>
					<td>부서</td>
					<td><input type="text" name="t_department" value="${member.t_department}" readonly style="border:0px;"></td>
					<td>직책</td>
					<td><input type="text" name="t_position" value="${member.t_position}" readonly style="border:0px;"></td>
				</tr>
				<tr>
					<td>개인정보</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="t_name" value="${member.t_name}" readonly style="border:0px;"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="t_birth" value="${member.t_birth}" readonly style="border:0px;"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="t_email" value="${member.t_email}"></td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="text" name="t_phone" value="${member.t_phone}"></td>
				</tr>
				<tr>
					<td rowspan="2">주소</td>
					<td><input type="text" value="${member.t_addr_zipcode}" id="t_addr_zipcode" name="t_addr_zipcode"></td>
					<td><button type="button" onclick="findZipcode();">우편번호 검색</button></td>
				</tr>
				<tr>
					<td><input type="text" value="${member.t_addr_general}" id="t_addr_general" name="t_addr_general"></td>
					<td><input type="text" value="${member.t_addr_detail}" id="t_addr_detail" name="t_addr_detail"></td>
				</tr>
			</tbody>
		</table>
			<div class="img_wrap">
			사원사진
			<img id="profile_container">
			<input type="file" name="file" accept="image/*">
			</div>
		<button type="button" onclick="modifyMember();">수정</button>
		<button type="button" onclick="history.go(-1);">취소</button>
	</form>
</body>
</html>