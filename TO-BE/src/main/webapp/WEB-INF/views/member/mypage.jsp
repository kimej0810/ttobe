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
		
		var result = confirm("정보를 수정하시겠습니까?");
		if(result){
			frm.action = "/member/modifyMember";
			frm.method = "POST";
			frm.submit();	
		}else{
			history.go(-1);
		}
	}
	
	$(function(){
		$("#inputImg").on('change',function(){
			readURL(this);
		});
	});
		
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			
			reader.onload = function(e){
				$("#previewImg").attr('src',e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	
</script>
</head>
<body>
	<form name="frm" enctype="multipart/form-data">
		<table border="1">
			<tbody>
				<tr>
					<td>비밀번호</td>
					<td><a href="/member/modifyPwd?t_id=${member.t_id}" onclick="window.open(this.href, '비밀번호변경', 'width=500,height=500,top=200,left=100'); return false;">변경하기</a></td>
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
				<img id="previewImg" src="<c:url value="/resources/static/profile/${member.f_stored_file_name}"/>" alt="your image" style="width:200px;height:150px;"/>
				<input type="file" id="inputImg" name="file" accept="image/*"/>
				<input type="hidden" id="tidx" name="tidx" value="${member.tidx}"/>
			</div>
		<button type="button" onclick="modifyMember();">수정</button>
		<button type="button" onclick="history.go(-1);">취소</button>
	</form>
</body>
</html>
