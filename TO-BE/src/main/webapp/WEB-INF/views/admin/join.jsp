<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 등록</title>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.css"/>">
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
@font-face {
	font-family: 'NanumSquareRound';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
body, html{
	font-family: 'NanumSquareRound';
	font-size: 15px;
	margin: 0;
	height: 100%;
}
body{
	background-color: #bfbfbf87;
}
.container{
	width:45%;
	margin:5% auto;
	box-shadow: 0 0 5px 5px #a7a7a7;
	background-color: #fff;
	border-radius: 10px;
	padding:2% 5%;
}
input .tooltip{
	position:initial!important;
}
.tooltip-inner{
	background-color: red;
}
.fileLabel{
	padding:.5em .75em;
	color:#999;
	font-size:inherit;
	line-height:normal;
	vertical-align:middle;
	background-color:#fdfdfd;
	cursor:pointer;
	border:1px solid #ebebeb;
	border-bottom-color:#e2e2e2;
	border-radius:.25em;
	display:block;
	text-align:center;
}
input[type="file"]{
	position:absolute;
	width:1px;
	height:1px;
	padding:0;
	margin:-1px;
	overflow:hidden;
	clip:rect(0,0,0,0);
	border:0;
}
</style>
<script>

$(document).ready(function(){
	$(document).on("focusout","#pwd",function(){
		var check = $(this).val();
		if(check.length<6){
			$("#pwd").attr("title","최소6글자 이상입니다.");
			$("#pwd").tooltip({
					animation: true,
					container:"#tootip_area",
					delay:{show:50,hide:10},
					html:false,
					template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
					trigger:'manual'
				});
			$("#pwd").tooltip('show');
			$("#pwd").val("");
			$("#pwd").focus();
		}else{
			$("#pwd").tooltip('hide');
		}
	});
	$(document).on("focusout","#pwdRe",function(){
		var check1 = $("#pwd").val();
		var check2 = $(this).val();
		if(check2!=check1){
			$("#pwdRe").attr("title","비밀번호가 다릅니다.");
			$("#pwdRe").tooltip({
					animation: true,
					container:"#tootip_area2",
					delay:{show:50,hide:10},
					html:false,
					template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
					trigger:'manual'
				});
			$("#pwdRe").tooltip('show');
		}else{
			$("#pwdRe").tooltip('hide');
		}
	});
	$(document).on("click","#joinBtn",function(){
		if($("#pwd").val()==""){
			alert("비밀번호를 입력하세요.");
			$("#pwd").focus();
			return;
		}else if($("#pwdRe").val()==""){
			alert("비밀번호를 재입력하세요.");
			$("#pwdRe").focus();
			return;
		}else if($("#file").val()==null || $("#file").val()==""){
			alert("관리자의 프로필을 등록해주세요.");
			return;
		}else if($("#t_phone1").val()==""){
			alert("연락처를 입력하세요.");
			return;
		}else if($("#t_phone2").val()==""){
			alert("연락처를 입력하세요.");
			return;
		}else if($("#t_phone3").val()==""){
			alert("연락처를 입력하세요.");
			return;
		}else if($("#postcode").val()=="" || $("#address").val()=="" || $("#detailAddress").val()==""){
			alert("우편주소를 입력하세요.");
			return;
		}
		Swal.fire({
			title:"관리자등록",
			text:"관리자가 존재하므로 가입은 불가능합니다.",
			icon:"warning",
			confirmButtonText:"확인",
		}).then(result => {
			if(result.isConfirmed){
				self.location.href= $("#domain").val()+"/member/login";
			}
		});
	});
});
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
var fileArr;
var fileInfoArr=[];
//썸네일 클릭시 삭제.
function fileRemove(index){
	fileInfoArr.splice(index,1);
	var imgId="#img_id_"+index;
	$(imgId).remove();
}
//썸네일 미리보기
function previewImage(targetObj, View_area){
	var files = targetObj.files;
	fileArr = Array.prototype.slice.call(files);
	var preview = document.getElementById(View_area);
	var ua = window.navigator.userAgent;
	//ie일때
	if(ua.indexOf("MSIE")>-1){
		targetObj.select();
		try {
            var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
            var ie_preview_error = document.getElementById("ie_preview_error_" + View_area);
            if (ie_preview_error) {
                preview.removeChild(ie_preview_error); //error가 있으면 delete
            }
            var img = document.getElementById(View_area); //이미지가 뿌려질 곳
            //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
        } catch (e) {
            if (!document.getElementById("ie_preview_error_" + View_area)) {
                var info = document.createElement("<p>");
                info.id = "ie_preview_error_" + View_area;
                info.innerHTML = e.name;
                preview.insertBefore(info, null);
            }
        }
        //ie가 아닐때(크롬,사파리,FF)
	}else{
		var files = targetObj.files;
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            fileInfoArr.push(file);
 
            var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
            if (!file.type.match(imageType))
                continue;
            var prevImg = document.getElementById("img_id_"+i); //이전에 미리보기가 있다면 삭제
            if (prevImg) {
            	preview.removeChild(prevImg);
            }
            var span = document.createElement('span');
            span.id="img_id_" +i;
            span.style.width = '150px';
            span.style.height = '200px';
            preview.appendChild(span);
 
            var img = document.createElement("img");
            img.className="addImg";
            img.classList.add("obj");
            img.file = file;
            img.style.width='inherit';
            img.style.cursor='pointer';
            img.style.height='-webkit-fill-available';
            const idx=i;
            img.onclick=function(){
            	fileRemove(idx);
            }
            span.appendChild(img);
 
            if (window.FileReader) { // FireFox, Chrome, Opera 확인.
                var reader = new FileReader();
                reader.onloadend = (function(aImg) {
                    return function(e) {
                        aImg.src = e.target.result;
                    };
                })(img);
                reader.readAsDataURL(file);
            } else { // safari is not supported FileReader
                //alert('not supported FileReader');
                if (!document.getElementById("sfr_preview_error_"
                    + View_area)) {
                    var info = document.createElement("p");
                    info.id = "sfr_preview_error_" + View_area;
                    info.innerHTML = "not supported FileReader";
                    preview.insertBefore(info, null);
                }
            }
        }
	}
}
function joinAdmin(){
	var tPhone = "";
	tPhone += $("#t_phone1").val();
	tPhone += "-";
	tPhone += $("#t_phone2").val();
	tPhone += "-";
	tPhone += $("#t_phone3").val();
	$("#t_phone").val(tPhone);
	if($("#file").val()==null || $("#file").val()==""){
		alert("관리자의 프로필을 등록해주세요.");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<%-- <%
	String domain = request.getContextPath();
	String check = (String)session.getAttribute("result");
	if(check==null){
		out.println("<script>alert('잘못된 접근입니다.');location.href='"+domain+"/member/login';</script>");
	}else if(check.equals("false")){
		out.println("<script>alert('관리자가 이미 존재합니다.');location.href='"+domain+"/member/login';</script>");
	}
	
%> --%>
<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
	<div class="container">
		<div class="header" style="text-align:center;">
			<img src="<c:url value="/resources/static/img/loginlogo.png"/>" style="width:190px;margin-bottom:10px;" alt="회사로고이미지">
		</div>
		<form action="${pageContext.request.contextPath}/admin/joinAction" method="post" name="frm" class="form" onsubmit="return joinAdmin()" enctype="multipart/form-data">
			<div>
				<span>아이디</span>
				<div class="col-auto input-group" style="margin-bottom:10px;">
					<input type="text" name="t_id" value="admin" class="form-control" readonly="readonly">	
				</div>
				<div>
					<span>비밀번호</span>
					<input type="password" name="t_pwd" id="pwd" class="pw form-control" placeholder="비밀번호 입력" style="margin-bottom:10px;" data-bs-placement="right" required="required">
					<span id="tootip_area"></span>
					<span>비밀번호 확인</span>
					<input type="password" name="t_pwdRe" id="pwdRe" class="pw form-control" placeholder="비밀번호 재입력" style="margin-bottom:10px;" data-bs-placement="right" required="required">
					<span id="tootip_area2"></span>
				</div>
			</div>
			<div class="form-control" style="display:inline-flex;height:113px;">
						<span id="View_area"></span>
						<label for="file" class="fileLabel">프로필 등록</label>
						<input type="file" name="file" id="file" onchange="previewImage(this,'View_area')" value="사진 등록">
			</div>
			<span>연락처</span>
			<div class="col-auto input-group" style="margin-bottom:10px;">
				<input type="text" id="t_phone1" name="t_phone1" class="form-control" placeholder="010" maxlength="4" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required="required">
				<div class="input-group-text">-</div>
				<input type="text" id="t_phone2" name="t_phone2" class="form-control" maxlength="4" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required="required">
				<div class="input-group-text">-</div>
				<input type="text" id="t_phone3" name="t_phone3" class="form-control" maxlength="4" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required="required">
				<input type="hidden" id="t_phone" name="t_phone">
			</div>
			<span>직장주소</span>
			<div class="col-auto input-group" style="margin-bottom:10px;">
				<input type="text" id="postcode" name="t_addr_zipcode" class="form-control" placeholder="우편번호" required="required">
				<input type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()" value="검색">
			</div>
			<div class="col-auto" style="margin-bottom:10px;">
				<input type="text" id="address" name="t_addr_general" class="form-control" placeholder="일반주소" required="required" >
			</div>
			<div class="col-auto" style="margin-bottom:10px;">
				<input type="text" id="detailAddress" name="t_addr_detail" class="form-control" placeholder="상세주소" required="required">
				<input type="hidden" placeholder="참고" id="extraAddress" name="addr3" class="form-control">
			</div>
			<div style="text-align:right;margin-top:20px;">
			<%
				String check = (String)session.getAttribute("result");
				if(check!=null){
					if(check.equals("false")){
						
			%>
						<input type="button" class="btn btn-outline-secondary" id="joinBtn" value="등록하기">
			<%
					}else{
			
			%>
						<input type="submit" class="btn btn-outline-secondary" value="등록하기">
			<%
					}
				}
			%>
				<input type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/member/login';" value="돌아가기">
			</div>
		</form>
	</div>
</body>
</html>