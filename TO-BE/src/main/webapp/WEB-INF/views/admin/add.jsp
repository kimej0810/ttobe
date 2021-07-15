<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="tobe.project.dto.*"%>
<%@page import="java.util.*"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>
</head> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script>
	$(document).ready(function(){
		$("#formTag").submit(function(){
			$(".loding-check").css("display","inline");
			setInterval(function(){
				$(".loding1").hide();
				setTimeout(function(){
					$(".loding1").show();
				},1000);
			},750);
			return true;
		});	
		$("#subminBtnn").on("click",function(){
	    	if($("#t_department").val()==null || $("#t_department").val()=="부서없음"){
	    		alert("부서를 선택해주세요.");
	    		return;
	    	}else if($("#t_position").val()==null || $("#t_position").val()==""){
	    		alert("직급을 선택해주세요.");
	    		return;
	    	}else{
				$("#formTag").submit();	
	    	}
		});
		$(document).on("focusout","#t_email",function(){
			var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!emailRule.test($("input[id='t_email']").val())){
				$("#t_email").attr("title","형식이 맞지 않습니다. [예 : 아이디@주소.com]");
				$("#t_email").tooltip({
						animation: true,
						container:"#tootip_area",
						delay:{show:50,hide:10},
						html:false,
						template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
						trigger:'manual'
					});
				$("#t_email").tooltip('show');
				$("#t_email").val("");
				$("#t_email").focus();
			}else{
				$("#t_email").tooltip('hide');
			}
		});
		$(document).on("focusout","#t_phone",function(){
			var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
			if(!regExp.test($("input[id='t_phone']").val())){
				$("#t_phone").attr("title","형식이 맞지 않습니다. [예 : 010-0000-0000]");
				$("#t_phone").tooltip({
						animation: true,
						container:"#tootip_area2",
						delay:{show:50,hide:10},
						html:false,
						template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
						trigger:'manual'
					});
				$("#t_phone").tooltip('show');
				$("#t_phone").val("");
				$("#t_phone").focus();
			}else{
				$("#t_phone").tooltip('hide');
			}
		});
		$(document).on("focusout","#t_birth",function(){
			var birth = /^\d{4}-\d{2}-\d{2}$/;
			if(!birth.test($("input[id='t_birth']").val())){
				$("#t_birth").attr("title","형식이 맞지 않습니다. [예 : 1900-01-01]");
				$("#t_birth").tooltip({
						animation: true,
						container:"#tootip_area3",
						delay:{show:50,hide:10},
						html:false,
						template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
						trigger:'manual'
					});
				$("#t_birth").tooltip('show');
				$("#t_birth").val("");
				$("#t_birth").focus();
			}else{
				$("#t_birth").tooltip('hide');
			}
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
//썸네일 미리보기
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
</script>
<style>
    .infoImg img{
    	width:150px;
    	height:200px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    .tooltip-inner{
		background-color: red;
	}
    #address, #detailAddress{
    	width:71%;
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
	.headerT{
    	margin-bottom:45px;
    }
    table th{
    	text-align:center;
    }
    .loding{
		position: fixed;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		background: rgba(0,0,0,0.4);
		width: 100%;
		height: 100vh;
		text-align: center;
	}
	.loding-check{
		display: none;
	}
	.loding-img{
		position: fixed;
		top: 50vh;
		color: white;
	}
</style>
<body>
<%
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
		String uGrade = (String)session.getAttribute("userGrade");
		if(!uGrade.equals("A")){
			out.println("<script>alert('접근 권한이 없습니다.');history.back();</script>");
		}
	}
%>
	<div class="loding loding-check">
		
		<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-brightness-low loding-img" viewBox="0 0 16 16">
  			<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm.5-9.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 11a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm5-5a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm-11 0a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9.743-4.036a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm-7.779 7.779a.5.5 0 1 1-.707-.707.5.5 0 0 1 .707.707zm7.072 0a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707zM3.757 4.464a.5.5 0 1 1 .707-.707.5.5 0 0 1-.707.707z"/>
		</svg>
		<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-brightness-high loding-img loding1" viewBox="0 0 16 16">
  			<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
		</svg>
	</div>
	<div class="headerT">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button">사원 등록</button>
	</div>
	<form id="formTag" action="/admin/addAction" method="post" enctype="multipart/form-data">
		<table class="table">
			<tbody>
				<tr>
					<td rowspan="6" scope="col" width="30%" style="text-align:center;">
						<div class="infoImg">
							<span id="View_area"></span>
							<label for="file" class="fileLabel">프로필 등록</label>
							<input type="file" name="file" id="file" onchange="previewImage(this,'View_area')" value="사진 등록" required="required">
						</div>
					</td>
					<th>사원 번호</th>
					<td>
						<input type="text" name="t_id" value="${tid}" readonly="readonly" class="form-control">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" placeholder="이름 작성" name="t_name" class="form-control" required="required">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="t_birth" id="t_birth" class="form-control" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" maxlength="12" required="required">
						<span id="tootip_area3"></span>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select class="selectBuseo form-select" name="t_department" id="t_department">
							<option value="부서없음">부서 선택</option>
							<option value="대표">대표</option>
							<option value="마케팅">마케팅</option>
							<option value="판매">판매</option>
							<option value="디자인">디자인</option>
							<option value="인사">인사</option>
							<option value="재정">재정</option>
							<option value="회계">회계</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>
						<select class="selectJk form-select" name="t_position" id="t_position">
							<option value="levelNull">직급 선택</option>
							<option value="대표">대표</option>
							<option value="팀장">팀장</option>
							<option value="부장">부장</option>
							<option value="과장">과장</option>
							<option value="대리">대리</option>
							<option value="사원">사원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2" align="left">
						<input type="text" name="t_email" id="t_email" class="form-control" required="required">
						<span id="tootip_area"></span>
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="2" align="left">
						<input type="text" name="t_phone" id="t_phone" class="form-control" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" maxlength="14" required="required">
						<span id="tootip_area2"></span>
					</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td colspan="2" align="left">
						<input type="text" id="postcode" placeholder="우편번호" name="t_addr_zipcode" class="form-control" style="width:50%;display:inline;">
						<input type="button" class="btn btn-primary btn-sm" onclick="execDaumPostcode()" value="주소 검색" style="width:20%;height:35px;">
					</td>
				</tr>
				<tr>
					<th>일반주소</th>
					<td colspan="2" align="left">
						<input type="text" placeholder="일반주소" id="address" name="t_addr_general" class="form-control" required="required">
					</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td colspan="2" align="left">
						<input type="text" placeholder="상세주소" id="detailAddress" name="t_addr_detail" class="form-control">
						<input type="hidden" placeholder="참고" id="extraAddress" name="addr3" class="form-control">
					</td>
				</tr>
			</tbody>
		</table>
		<div class="tableBtn">
			<input type="button" id="subminBtnn" class="btn btn-primary btn-sm" value="사원 등록">
			<input type="button" class="btn btn-danger btn-sm" onclick="history.go(-1)" value="취소">
		</div>
	</form>
</body>
</html>