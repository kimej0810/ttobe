<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>휴가 신청</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<style>
		body{
			background-color: lightgray;
		}
		table th{
			text-align: center;
			border-left: 1px solid lightgray;
		}
		form{
			outline: 2px solid black;
			font-size: 0.9em;
			background-color: white;
		}
		#tableDiv{
			padding: 2%;
		}
		table td{
			border-left: 1px solid lightgray;
		}
		textarea{
			resize: none;
		}
		.form-control, .form-select{
			height: 30px;
			font-size: 0.8em;
			height: 100%;
		}
		#tableNum{
			font-size: 0.75em;
			margin-left: 1%;
			padding-top: 1%;
		}
	</style>
</head>
<body>
	<div id="tableDiv">
		<form>
			<div id="tableNum">
				<span>문서 번호 :</span>
			</div>
			<table class="table">
				<tr>
					<th colspan="6"><h4>휴가 신청서</h4></th>
				</tr>
				<!-- <tr>
					<th width="20%">문 서 번 호</th>
					<td></td>
					<th>전 결 규 정</th>
					<td colspan="3">
						<input type="text" class="form-control">
					</td>
				</tr> -->
				<tr>
					<th rowspan="2" style="border-left: 1px solid lightgray;" width="20%">결 재</th>
					<th style="border-left: 1px solid lightgray;" width="16%">담 당</th>
					<th style="border-left: 1px solid lightgray;" width="16%">팀 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%">부 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%">과 장</th>
					<th style="border-left: 1px solid lightgray;" width="16%">대 표</th>
				</tr>
				<tr>
					<td>나</td>
					<td>
						<select class="form-select">
							<option value="no">::: 선 택 :::</option>
						</select>
					</td>
					<td>
						<select class="form-select">
							<option value="no">::: 선 택 :::</option>
						</select>
					</td>
					<td>
						<select class="form-select">
							<option value="no">::: 선 택 :::</option>
						</select>
					</td>
					<td>
						<select class="form-select">
							<option value="no">::: 선 택 :::</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="6"></td>
				</tr>
				<tr>
					<th>신 청 일 자</th>
					<td></td>
					<th>시 작 일 자</th>
					<td>
						<input type="text" class="form-control">
					</td>
					<th>종 료 일 자</th>
					<td>
						<input type="text" class="form-control">
					</td>
				</tr>
				<tr>
					<th>휴 가 종 류</th>
					<td>
						<select class="form-select">
							<option value="no">::: 선 택 :::</option>
							<option value="no">연차</option>
							<option value="no">월차</option>
							<option value="no">반차</option>
							<option value="no">병가</option>
							<option value="no">기타</option>
						</select>
					</td>
					<th>신 청 자</th>
					<td>나</td>
					<th>부 서</th>
					<td>부</td>
				</tr>
				<tr>
					<th>신 청 일 수</th>
					<td>1</td>
					<th>비상연락망</th>
					<td>
						<input type="text" class="form-control">
					</td>
					<th>관 계</th>
					<td>
						<input type="text" class="form-control">
					</td>
				</tr>
				<tr>
					<th>제 목</th>
					<td colspan="5">
						<input type="text" class="form-control" name="e_texttitle">
					</td>
				</tr>
				<tr>
					<th>내 용</th>
					<td colspan="5">
						<textarea class="form-control" style="height:200px;" name="e_textcontent"></textarea>
					</td>
				</tr>
				<tr>
					<th>신 청 일 자</th>
					<td colspan="2"></td>
					<th>신 청 인</th>
					<td colspan="2">
						<input type="text" class="form-control">
					</td>
				</tr>
			</table>
			<div style="float:right;">
				<input type="button" class="btn btn-primary btn-sm" value="신청">
				<input type="button" class="btn btn-danger btn-sm" value="취소">
			</div>
		</form>
	</div>
</body>
</html>
