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
	.error{
		color: red;
	}
</style>
<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
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
                document.getElementById('t_addr_zipcode').value = data.zonecode;
                document.getElementById("t_addr_general").value = addr;
                document.getElementById("t_addr_detail").focus();  
            }
        }).open();
    }
	
	var domain = $("#domain").val();
	function modifyMember(){
		
		if($("#t_email").val() == ""){
			$("#empty_t_email").css("display","block");
			$("#t_email").focus();
			return;
		}else if($("#t_phone").val() == ""){
			$("#empty_t_phone").css("display","block");
			$("#t_phone").focus();
			return;
		}
		
		var result = confirm("정보를 수정하시겠습니까?");
		if(result){
			frm.action = $("#domain").val()+"/member/modifyMember";
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
	<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/member/mypage?tidx=${member.tidx}'">사원정보변경</button>
	<button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/member/modifyPwd?t_id=${member.t_id}'">비밀번호변경</button>
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
							<img id="previewImg" src="<c:url value='/resources/static/profile/${member.f_stored_file_name}'/>" alt="your profile" style="width:200px;height:150px;"/>
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
					<td><input type="text" name="t_email" value="${member.t_email}" id="t_email"><span class="error" id="empty_t_email" style="display:none" aria-live="assertive">*필수입력</span></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="t_phone" value="${member.t_phone}" id="t_phone"><span class="error" id="empty_t_phone" style="display:none" aria-live="assertive">*필수입력</span></td>
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
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/main/mainPage'" class="btn btn-outline-danger btn-sm">취소</button>
		</div>
	</form>
</body>
</html>
