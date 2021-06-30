<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>my page</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- ------------------------------------------------------------- 
<script type="text/javascript" src="./js/bootstrap.js"></script>
<link type="text/css" rel="stylesheet" href="./css/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="./css/dogMain.css" />
<style>
    #div1, #div2 {
        width: 1000px;
        height: 1000px;
        border: 1px solid black;
        position: relative;
    }

</style>-->
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

	<button type="button"><a href="/member/mypage?tidx=${member.tidx}">사원정보변경</a></button>
	<button type="button"><a href="/member/modifyPwd?t_id=${member.t_id}">비밀번호번경</a></button>
	<form name="frm" enctype="multipart/form-data">
		<table border="1">
			<tbody>
				<%-- <tr>
					<td>비밀번호</td>
					<td><a href="/member/modifyPwd?t_id=${member.t_id}" onclick="window.open(this.href, '비밀번호변경', 'width=500,height=500,top=200,left=100'); return false;">변경하기</a></td>
				</tr> --%>
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
<!-- 
<button type="button" id="first">첫번째</button>
<button type="button" id="second">두번째</button>
<div style="" id="div1">
<form name="frm" enctype="multipart/form-data">
		<table border="1">
			<tbody>
				<tr>
					<td>비밀번호</td>
					<td><a href="/member/modifyPwd?t_id=${member.t_id}" onclick="window.open(this.href, 'modifyPwd', 'width=500,height=500,top=200,left=100'); return false;">변경하기</a></td>
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
</div>
<div style="top: -500px; display:none;" id="div2">
<form name="frm1">
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
	<input type="hidden" name="t_id" value="${member.t_id}"/>
</form>
</div>  -->
</body>
</html>
