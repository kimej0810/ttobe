<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</script>
<style>
    .sub{
	    width: 100%;
	    height: 98vh;
	    padding:1%;
    }
    .infoImg{
    	width:100px;
    	height:150px;
    }
    .infoImg img{
    	width:100px;
    	height:150px;
    }
    .tableBtn{
    	text-align:right;
    	margin-top:20px;
    	margin-right:1%;
    }
    .saoneBtn{
    	width:100px;
    	height:30px;
	    border-radius: 5px;
	    background-color: #ffd4006e;
    }
    #address{
    	width:350px;
    }
    .selectJk, .selectBuseo{
    	width:180px;
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
	<div class="sub">
		<div class="headerT"><h1>사원정보 수정</h1></div>
		<div class="formDiv">
			<form action="${path}/admin/modifyAction${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}" method="post">
				<table>
					<colgroup>
						<col width="20%"></col>
						<col width="80%"></col>
					</colgroup>
					<tbody>
						<tr>
							<td rowspan="6">
								<div class="infoImg">
									<img src="<c:url value="/resources/static/img/profile.png"/>">
									<input type="file" value="사진 등록">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<label><h2>사원 번호</h2></label>
							</td>
							<td>
								<input type="text" value="${member.t_id}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>
								<label><h2>이름</h2></label>
							</td>
							<td>
								<input type="text" value="${member.t_name}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>
								<label><h2>생년월일</h2></label>
							</td>
							<td>
								<input type="text" value="${member.t_birth}" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>
								<label><h2>현재 부서</h2></label>
							</td>
							<td>${member.t_department}</td>
						</tr>
						<tr>
							<td>
								<label><h2>부서</h2></label>
							</td>
							<td>
								<select class="selectBuseo" name="t_department">
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
							<td>
								<label><h2>현재 직급</h2></label>
							</td>
							<td>${member.t_position}</td>
						</tr>
						<tr>
							<td>
								<label><h2>직급</h2></label>
							</td>
							<td>
								<select class="selectJk" name="t_position">
									<option value="levelNull">직책</option>
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
							<td><h2>이메일</h2></td>
							<td colspan="2" align="left"><input type="text" value="${member.t_email}"></td>
						</tr>
						<tr>
							<td><h2>연락처</h2></td>
							<td colspan="2" align="left"><input type="text" value="${member.t_phone}"></td>
						</tr>
						<tr>
							<td><h2>우편번호</h2></td>
							<td colspan="2" align="left">
								<input type="text" id="postcode" value="${member.t_addr_zipcode}">
								<input type="button" onclick="execDaumPostcode()" value="주소지 변경">
							</td>
						</tr>
						<tr>
							<td rowspan="2"><h2>주소</h2></td>
							<td colspan="2" align="left">
								<input type="text" value="${member.t_addr_general}" id="address">
							</td>
						</tr>
						<tr>
							<td colspan="2" align="left">
								<input type="text" value="${member.t_addr_detail}" id="detailAddress">
								<input type="hidden" name="tidx" value="${member.tidx}">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="tableBtn">
					<input type="submit" class="saoneBtn" value="정보 수정">
					<input type="button" class="saoneBtn" onclick="location.href='${path}/admin/memberlist${pageMaker.makeSearch(pageMaker.cri.page)}&tidx=${member.tidx}'" value="취소">
				</div>
			</form>
		</div>
	</div>
</body>
</html>