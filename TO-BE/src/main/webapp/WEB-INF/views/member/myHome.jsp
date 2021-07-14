<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Home</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<script>
function scheduleAddPopup(){
	var url = "/schedule/schedulePopup";
	var name = "schedulePopup";
	var option = "width = 600, height = 730 left = 100, top=50,location=no";
	window.open(url,name,option)
}
function leaveBtn(){
	var t_id = $("#t_id").val();
	var url = "/member/leave?t_id="+t_id;
	var name = "leave";
	var option = "width = 800, height = 730 left = 100, top=50,location=no";
	window.open(url,name,option)
}
</script>
<style>
	#container1,#container2,#container3,#container4{
		display:inline-block;
		border-radius: 10px;
		box-shadow: 0 0 5px 2px lightgray;
		margin:10px 0;
	}
	#mainContainer{
		margin-top:45px;
		border:0px solid black;
	}
	#mainContainer a{
		border-color:#6c757d40;
	}
	.card{
		border:0px solid black;
	}
	#mainContainer a[aria-expanded="true"]{
		border-bottom: 0px;
		border-radius: 0.25em 0.25em 0 0;
		margin-bottom: -1px;
		background-color:#6c757d;
		color:#fff;
	}
	#writeBtn{
			width:50px;
		}
	#mainContainer a:root{
		background-image: black;
	}
	table{
		text-align:center;
	}
	#leaveTitle{
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="btnGroup">
		<button type="button" class="btn btn-outline-secondary">나의 정보</button>
		<input type="hidden" id="t_id" value="<%=userId%>">
		<div id="mainContainer" class="form-control">
			<div id="container1" class="form-control">
				<div style="text-align:right;">
					<a class="btn btn-outline-secondary" data-bs-toggle="collapse" href="#collapseExample" role="button"
						aria-expanded="false" aria-controls="collapseExample">게시판</a>
				</div>
				<div class="collapse" id="collapseExample">
					<div class="card card-body">
						<table class="table">
							<thead>
								<tr>
									<th>제목</th>
									<th>내용</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${myBoard}" var="board">
									<tr>
										<td>
											<a href="/board/view?bidx=${board.bidx}" style="text-decoration : none; color:black;">${board.b_title}</a>
										</td>
										<td>
											<c:set var="boardContent" value="${board.b_content}"/>
											${fn:substring(boardContent,0,5)}. . .
										</td>
										<td>
											<c:set var="sendDate" value="${board.b_writedate}"/>
											${fn:substring(sendDate,0,16)}
											<input type="hidden" value="${board.bidx}">
										</td>
										<td>${board.b_hit}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div style="text-align:right;">
							<button type="button" class="btn btn-primary btn-sm" id="writeBtn" onclick="location.href='/board/write'">등록</button>
						</div>
					</div>
				</div>
			</div>
			<div id="container2" class="form-control">
				<div style="text-align:right;">
					<a class="btn btn-outline-secondary" data-bs-toggle="collapse" href="#collapseExample2" role="button"
						aria-expanded="false" aria-controls="collapseExample">일정</a>
				</div>
				<div class="collapse" id="collapseExample2">
					<div class="card card-body">
						<table class="table">
							<thead>
								<tr>
									<th>유형</th>
									<th>제목</th>
									<th>내용</th>
									<th>시작일</th>
									<th>종료일</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
							<c:when test="${fn:length(mySchedule) == 0}">
								<tr>
									<td colspan="5">등록된 내용이 없습니다.</td>
								</tr>
							</c:when>
								<c:otherwise>
								<c:forEach items="${mySchedule}" var="schedule">
									<tr>
										<td>${schedule.s_type}</td>
										<td>
											<a href="/schedule/scheduleContents?sidx=${schedule.sidx}&tidx=${schedule.tidx}" onclick="window.open(this.href, '_blank', 'width=600, height=730'); return false;" style="text-decoration : none; color:black;">
												${schedule.s_title }
											</a>
											
										</td>
										<td>
											<c:set var="scheduleContent" value="${schedule.s_content}"/>
											${fn:substring(scheduleContent,0,6)}. . .
										</td>
										<td>
											<c:set var="startdate" value="${schedule.s_startDate}"/>
											${fn:substring(startdate,0,16)}
										</td>
										<td>
											<c:set var="enddate" value="${schedule.s_endDate}"/>
											${fn:substring(enddate,0,16)}
										</td>
									</tr>
								</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div style="text-align:right;">
							<button type="button" class="btn btn-primary btn-sm" onclick="scheduleAddPopup()">일정 추가</button>
						</div>
					</div>
				</div>
			</div>
			<div id="container3" class="form-control">
				<div style="text-align:right;">
					<a class="btn btn-outline-secondary" data-bs-toggle="collapse" href="#collapseExample3" role="button"
						aria-expanded="false" aria-controls="collapseExample">연차</a>
				</div>
				<div class="collapse" id="collapseExample3">
					<div class="card card-body">
						<table class="table">
							<thead>
								<tr>
									<th scope="col" width="5%">유형</th>
									<th scope="col" width="45%">제목</th>
									<th scope="col" width="15%">시작일</th>
									<th scope="col" width="15%">종료일</th>
									<th scope="col" width="10%">사용일수</th>
									<th scope="col" width="10%">결재상태</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
							<c:when test="${fn:length(myLeave) == 0}">
								<tr>
									<td colspan="5">등록된 내용이 없습니다.</td>
								</tr>
							</c:when>
								<c:otherwise>
									<c:forEach items="${myLeave}" var="leave">
										<tr>
											<td>${leave.a_type}
											</td>
											<td>
												<a href="/member/leaveView?eidx=${leave.eidx}" onclick="window.open(this.href, '_blank', 'width=800, height=640'); return false;" style="text-decoration : none; color:black;">
													${leave.e_texttitle}
												</a>
											</td>
											<td>
												<c:set var="startdate" value="${leave.a_startdate}"/>
												${fn:substring(startdate,0,10)}
											</td>
											<td>
												<c:set var="enddate" value="${leave.a_enddate}"/>
												${fn:substring(enddate,0,10)}
											</td>
											<td>${leave.a_useddays}</td>
											<td>${leave.e_status }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div style="text-align:right;">
							<button type="button" class="btn btn-primary btn-sm" onclick="leaveBtn()">연차 신청</button>
						</div>
					</div>
				</div>
			</div>
			<div id="container4" class="form-control">
				<div style="text-align:right;">
					<a class="btn btn-outline-secondary" data-bs-toggle="collapse" href="#collapseExample4" role="button"
						aria-expanded="false" aria-controls="collapseExample">이메일</a>
				</div>
				<div class="collapse" id="collapseExample4">
					<div class="card card-body">
						<table class="table">
							<thead>
								<tr>
									<th>제목</th>
									<th>수신일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${myEmail}" var="email">
									<tr>
										<td>${email.m_title}</td>
										<td>
											<c:set var="sendDate" value="${email.m_senddate}"/>
											${fn:substring(sendDate,0,16)}
											<input type="hidden" value="${email.midx}">
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>