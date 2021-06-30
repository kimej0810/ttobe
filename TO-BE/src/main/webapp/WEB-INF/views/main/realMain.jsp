<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp"%>
<html>
<head>
<title>진짜메인</title>
<meta charset="UTF-8">
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<style>
.content {
	width: 100%;
	display: grid;
	grid-template-columns: 5fr 2fr;
	grid-template-rows: repeat(6, max-content);
}

#box1 {
	grid-row: span 3;
}

#box2{
	grid-row: span 3;
}

#box4 {
	grid-row: span 3;
}

#box5 {
	grid-row: span 2;
}

.conTitle {
	font-size: 1.8rem;
	text-align: left;
	grid-column: 2/3;
	grid-row: 2/3;
	text-align: left;
}

.conCon {
	font-size: 1.3rem;
	grid-column: 2/3;
	grid-row: 3/4;
	grid-column: 2/3;
}

@media ( max-width :950px) {
	.content {
		margin: 20px;
		height: calc(100vh - 58px);
		display: grid;
		grid-column-gap: 0px;
		grid-row-gap: 15px;
		grid-template-columns: 1fr;
		grid-template-rows: repeat(5, max-content);
	}
	.conTitle {
		font-size: 1.5rem;
	}
	.conCon {
		font-size: 0.9rem;
	}
	#box1 {
		grid-row: 1/2;
	}
	#box2 {
		grid-row: 2/3;
	}
	#box3 {
		grid-row: 3/4;
	}
	#box4 {
		grid-row: 4/5;
	}
	#box5 {
		grid-row: 5/6;
	}
}

@media ( max-width :520px) {
	.content {
		margin: 20px;
		height: calc(100vh - 58px);
		display: grid;
		grid-column-gap: 0px;
		grid-row-gap: 15px;
		grid-template-columns: 1fr;
		grid-template-rows: repeat(5, max-content);
	}
	.conTitle {
		font-size: 1.2rem;
	}
	.conCon {
		font-size: 0.6rem;
	}
}
</style>
</head>
<body>
	<div id="box1" class="inner_content" style="width: 100%; height: 100%;">
		<div class="conTitle">공지사항</div>
		<div class="conCon">
			<table id="table_notice" class="table w-100">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="15%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<tr>
					<td>1</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>2</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>3</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>4</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>5</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="box2" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">달력</div>
		<div class="conCon">
			<img
				src="<c:url value="/resources/static/img/calendar2.png"/>"
				style="width: 100%;">
		</div>
	</div>
	<div id="box4" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">전자결재</div>
		<div class="conCon">
			<table id="table_notice" class="table w-100">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="15%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<tr>
					<td>1</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>2</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>3</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>4</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
				<tr>
					<td>5</td>
					<td>[공지] 공지사항입니다.</td>
					<td>홍길동</td>
					<td>2021.05.25</td>
					<td>0</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="box3" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">근태관리</div>
		<div class="conCon">
			<button type="button" class="btn btn-primary btn-sm float-right"
				onclick="#">출근</button>
			<button type="button" class="btn btn-primary btn-sm float-right"
				onclick="#">퇴근</button>
		</div>
	</div>
	<div id="box5" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">오늘의명언</div>
		<div class="conCon">집에가고싶다</div>
	</div>
</body>
</html>