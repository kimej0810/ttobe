<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my page</title>
<style type="text/css">
	.content{
		display:block;
	}
	.table{
		min-width: 650px;
	}
	.btnwrap{
		text-align: right;
	}
	#previewImg{
		border-radius: 50%;
		border: 1px solid lightgray;
	}
</style>
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
	//////////////////////////////////////////////////////////////
	 /*$(document).ready(function() {
        $('#first').click(function() {
            $("#div1").attr('style', 'display:block;');
            $("#div2").attr('style', 'display:none;');
        });
        $('#second').click(function() {
            $("#div2").attr('style', 'display:block;');
            $("#div1").attr('style', 'display:none;');
        });

    });
	
		function modifyPwd(){
	
		var ex = document.getElementById("newPwd").value;
		
		if(frm1.t_pwd.value != ex){
			alert("비밀번호 확인이 다릅니다.");
			frm1.newPwd.focus();
			return;
		}
		var result = confirm("비밀번호를 변경하시겠습니까?");
		if(result){
			frm1.action = "/member/modifyPwdAction";
			frm1.method = "POST";
			frm1.submit();
			//frm.target = "_self";
			//window.open("about:blank","_self").close();

		} else{
			self.close();
		} 
	}*/
	
</script>
</head>
<body>
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='/member/mypage?tidx=${member.tidx}'">사원정보변경</button>
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='/member/modifyPwd?t_id=${member.t_id}'">비밀번호변경</button>
	<form name="frm" enctype="multipart/form-data">
		<table class="table">
			<tbody>
				<tr>
					<td colspan="4" width="500px" style="font-size:1.3rem; font-weight:bold;">직장정보</td>
				</tr>
				<tr>
					<th>사원번호</th>
					<td colspan="3"><input type="text" name="t_id" value="${member.t_id}" readonly style="border:0px;"></td>
				</tr>
				<tr>	
					<th>부서</th>
					<td><input type="text" name="t_department" value="${member.t_department}" readonly style="border:0px;"></td>
					<th>직책</th>
					<td><input type="text" name="t_position" value="${member.t_position}" readonly style="border:0px;"></td>
				</tr>
				<tr>
					<td colspan="4" style="font-size:1.3rem; font-weight:bold;">개인정보</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="t_name" value="${member.t_name}" readonly style="border:0px;"></td>
					<td rowspan="4"  colspan="2">
						<div class="img_wrap">
							<img id="previewImg" src="<c:url value="/resources/static/profile/${member.f_stored_file_name}"/>" alt="your image" style="width:200px;height:150px;"/>
							<input type="file" id="inputImg" name="file" accept="image/*"/>
							<input type="hidden" id="tidx" name="tidx" value="${member.tidx}"/>
						</div>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="t_birth" value="${member.t_birth}" readonly style="border:0px;"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="t_email" value="${member.t_email}"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="t_phone" value="${member.t_phone}"></td>
				</tr>
				<tr>
					<th rowspan="2">주소</th>
					<td><input type="text" value="${member.t_addr_zipcode}" id="t_addr_zipcode" name="t_addr_zipcode"></td>
					<td colspan="2"><button type="button" onclick="findZipcode();" class="btn btn-primary btn-sm">우편번호 검색</button></td>
				</tr>
				<tr>
					<td><input type="text" value="${member.t_addr_general}" id="t_addr_general" name="t_addr_general"></td>
					<td colspan="2"><input type="text" value="${member.t_addr_detail}" id="t_addr_detail" name="t_addr_detail"></td>
				</tr>
			</tbody>
		</table>
		<div class="btnwrap">
			<button type="button" onclick="modifyMember();" class="btn btn-outline-primary btn-sm">수정</button>
			<button type="button" onclick="history.go(-1);" class="btn btn-outline-danger btn-sm">취소</button>
		</div>
	</form>
</body>
</html>
