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
/*공지*/
#box1 {
	grid-row: span 3;
}
/*달력*/
#box2 {
	grid-row: span 2;
}
/*근태*/
#box3 {
	grid-row: span 2;
}
/*전자*/
#box4 {
	grid-row: span 3;
}
/*명언*/
#box5 {
	grid-row: span 2;
}

#box5{
	background: linear-gradient(315deg, #F4BDFF, #BDC2FF, #A3FFD9);
  animation: bg-hue 10s linear infinite;
}

#box6{
	display:none;
}

@keyframes bg-hue {
  100% {
    filter: hue-rotate(360deg);
  }
}

p{
margin:0;
}

#speaker{
	font-size:0.9rem;
	text-align:right;
}

.conTitle {
	font-size: 1.8rem;
	font-weight:bold;
	text-align: left;
	grid-column: 2/3;
	grid-row: 2/3;
	text-align: left;
}

.conCon {
	font-size: 1.1rem;
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
		grid-template-rows: repeat(5, max-content) 1fr;
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
	#box6{
		display:block;
		visibility:hidden;
	}
}

@media ( max-width :520px) {
	.content {
		margin:0;
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
	#box5 {
		padding-bottom:20px;
	}
}
</style>
</head>
<body>
	<div id="box1" class="inner_content" style="width: 100%; height: 100%;">
		<div class="conTitle">통합게시판</div>
		<div class="conCon">
			<table id="table_notice" class="table w-100 table-hover">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="15%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<c:forEach items="${boardList}" var="board">
					<c:if test="${board.b_type eq 'N'}">
						<tr class="table-primary">
					</c:if>
					<c:if test="${board.b_type eq 'G'}">
						<tr>
					</c:if>
					<th scope="row">${board.bidx}
					</td>
					<td><a
						href="/board/view?bidx=${board.bidx}&page=1&perPageNum=10&searchType=&keyword="
						style="text-decoration: none; color: black;">${board.b_title}</a></td>
					<td><fmt:parseDate var="writedate"
							value="${board.b_writedate}" pattern="yyyy-MM-dd" /> <fmt:formatDate
							value="${writedate}" pattern="yyyy-MM-dd" /></td>
					<td>${board.memberVO.t_name}</td>
					<td>${board.b_hit}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div id="box2" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">달력</div>
		<div class="conCon">
			<img src="<c:url value="/resources/static/img/calendar2.png"/>"
				style="width: 100%;">
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
	<div id="box4" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">전자결재</div>
		<div class="conCon">
			<div class="button_elec"
				style="text-align: right; margin-bottom: 10px;">
				<div class="btn-group" role="group" aria-label="Basic example">
					<button type="button" class="btn btn-secondary">결재대기</button>
					<button type="button" class="btn btn-secondary">결재진행</button>
					<button type="button" class="btn btn-secondary">결재완료</button>
				</div>
			</div>
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
	<div id="box5" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">오늘의명언</div>
		<div class="conCon">
			<p id="say">
				올바로 작동하지 않는다고 걱정하지 마라.
				만일 모든 게 잘 된다면, 굳이 당신이 일할 이유가 없다.
			<p>
			<p id="speaker">
				Mosher’s Law of Software Engineering
			<p>
		</div>
	</div>
	<div id="box6" class="inner_content space">
	&nbsp;
	</div>
</body>
</html>