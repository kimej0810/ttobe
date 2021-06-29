<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 정보 수정</title>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
	            span.style.width = '170px';
	            span.style.height = '200px';
	            preview.appendChild(span);
	 
	            var img = document.createElement("img");
	            img.className="addImg";
	            img.classList.add("obj");
	            img.file = file;
	            img.style.width='inherit';
	            img.style.height='inherit';
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
    	width:100px;
    	height:150px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    #address, #detailAddress{
    	width:71%;
    }
    .headerT{
    	margin-bottom:45px;
    }
    table th{
    	text-align:center;
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
	.fileLabel:hover{
		background-color:lightgray;
		color:white;
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
	}/* else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	} */
%>
	<div class="headerT">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button">사원 정보 수정</button>
	</div>
	<form action="${path}/admin/modifyAction${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}" method="post">
		<table class="table">
			<tbody>
				<tr>
					<td rowspan="6" scope="col" width="30%" style="text-align:center;">
						<div class="infoImg">
							<span id="View_area"></span>
							<label for="file" class="fileLabel">프로필 변경</label>
							<input type="file" name="file" id="file" onchange="previewImage(this,'View_area')" value="사진 등록">
						</div>
					</td>
				</tr>
				<tr>
					<th>사원 번호</th>
					<td>
						<input type="text" value="${member.t_id}" class="form-control" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" value="${member.t_name}" class="form-control" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" value="${member.t_birth}" class="form-control" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>현재 부서</th>
					<td><input type="text" class="form-control" value="${member.t_department}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select class="selectBuseo form-select" name="t_department">
							<option value="부서없음">부서 선택</option>
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
					<th>현재 직급</th>
					<td colspan="2"><input type="text" class="form-control" value="${member.t_position}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>직급</th>
					<td colspan="2">
						<select class="selectJk form-select" name="t_position">
							<option value="levelNull">직급 선택</option>
							<option value="회장">회장</option>
							<option value="부회장">부회장</option>
							<option value="사장">사장</option>
							<option value="부사장">부사장</option>
							<option value="전무">전무</option>
							<option value="상무">상무</option>
							<option value="이사">이사</option>
							<option value="본부장">본부장</option>
							<option value="실장">실장</option>
							<option value="팀장">팀장</option>
							<option value="부장">부장</option>
							<option value="차장">차장</option>
							<option value="과장">과장</option>
							<option value="대리">대리</option>
							<option value="주임">주임</option>
							<option value="사원">사원</option>
							<option value="인턴">인턴</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2" align="left"><input type="text" class="form-control" value="${member.t_email}"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="2" align="left"><input type="text" class="form-control" value="${member.t_phone}"></td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td colspan="2" align="left">
						<input type="text" id="postcode" class="form-control" value="${member.t_addr_zipcode}" style="width:50%;display:inline;">
						<input type="button" class="btn btn-primary btn-sm" onclick="execDaumPostcode()" value="주소지 변경" style="width:20%;height:35px;">
					</td>
				</tr>
				<tr>
					<th>일반주소</th>
					<td colspan="2" align="left">
						<input type="text" class="form-control" value="${member.t_addr_general}" id="address">
					</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td colspan="2" align="left">
						<input type="text" class="form-control" value="${member.t_addr_detail}" id="detailAddress">
						
					</td>
				</tr>
			</tbody>
		</table>
		<div class="tableBtn">
			<input type="submit" class="btn btn-primary btn-sm" value="정보 수정">
			<input type="button" class="btn btn-danger btn-sm" onclick="history.back();" value="취소">
			<input type="hidden" name="tidx" value="${member.tidx}">
		</div>
	</form>
</body>
</html>