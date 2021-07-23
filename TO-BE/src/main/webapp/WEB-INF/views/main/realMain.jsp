<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
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

#calendar {
	width: 100%;
}

#calendar th {
	background-color: #cfe2ff;
	font-size: 0.9rem;
	padding: 5px;
	width: 100px;
}

#calendar td {
	border-bottom: 1px solid rgb(222, 226, 230);
	height: 60px;
	font-size: 0.8rem;
	vertical-align: top;
	text-align: right;
	padding: 10px;
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

p {
	margin: 0;
}

#speaker {
	font-size: 1.0rem;
	text-align: right;
	margin-right: 20px;
}

.quote {
	max-width: 4%;
	min-width: 3%;
}

#sayingWrap {
	margin: auto 0;
}

#box6 {
	display: none;
}

@
keyframes bg-hue { 100% {
	filter: hue-rotate(360deg);
}

}
p {
	margin: 0;
}

#speaker {
	font-size: 0.9rem;
	text-align: right;
}

.conTitle {
	font-size: 1.8rem;
	font-weight: bold;
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

@media only screen and ( max-width :950px) {
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
	#box6 {
		display: block;
		visibility: hidden;
	}
}

</style>
</head>
<body>
	<%
	String t_id = (String) session.getAttribute("userId");
	%>
	<input type="hidden" value="${pageContext.request.contextPath}" id="domain">
	<div id="box1" class="inner_content" style="width: 100%; height: 100%;">
		<div class="conTitle">통합게시판</div>
		<div class="conCon">
			<table id="table_notice" class="table w-100 table-hover">
				<colgroup>
					<col width="15%">
					<col width="40%">
					<col width="15%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>작성자</th>
					<th>조회수</th>
				</tr>
				<c:choose>
					<c:when test="${empty boardList}">
						<tr>
							<td colspan="5">해당하는 게시글이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${boardList}" var="board">
							<tr>
								<c:if test="${board.b_type eq 'N'}">
									<tr class="table-primary">
								</c:if>
								<c:if test="${board.b_type eq 'G'}">
									<tr>
								</c:if>
								<td scope="row">${board.bidx}</td>
								<td><a
									href="${pageContext.request.contextPath}/board/view?bidx=${board.bidx}&page=1&perPageNum=10&searchType=&keyword=&pagePort=board"
									style="text-decoration: none; color: black;">${board.b_title}</a></td>
								<td><fmt:parseDate var="writedate"
										value="${board.b_writedate}" pattern="yyyy-MM-dd" /> <fmt:formatDate
										value="${writedate}" pattern="yyyy-MM-dd" /></td>
								<td>${board.memberVO.t_name}</td>
								<td>${board.b_hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
	<div id="box2" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">달력</div>
		<div class="conCon">
			<table id="calendar" class="table w-100">
				<%
				Calendar cal = Calendar.getInstance();
				int toDate = cal.get(Calendar.DATE);
				int toYear = cal.get(Calendar.YEAR);
				int toMonth = cal.get(Calendar.MONTH) + 1;

				int year, month = 0;
				//request로 year, month 값을 받아옴
				try {
					year = Integer.parseInt(request.getParameter("year"));
				} catch (Exception e) {
					year = cal.get(Calendar.YEAR);
				}
				try {
					month = Integer.parseInt(request.getParameter("month"));
				} catch (Exception e) {
					month = cal.get(Calendar.MONTH) + 1;
				}

				//12월->1월, 1월->12월
				if (month == 13) {
					year++;
					month = 1;
				}
				if (month == 0) {
					year--;
					month = 12;
				}

				//유효성검사, 현재년월로 초기화
				if (year <= 0 || month < 1 || month > 12) {
					year = cal.get(Calendar.YEAR);
					month = cal.get(Calendar.MONTH) + 1;
				}

				//현재 날짜를 1일로 설정
				cal.set(year, month - 1, 1);
				//요일 값
				int week = cal.get(Calendar.DAY_OF_WEEK);
				//달의 말일 
				int lastDay = cal.getActualMaximum(Calendar.DATE);

				System.out.println("~~~~~~~~~~~구분선~~~~~~~~~~~~`");
				%>
				<tr>
					<td colspan="7" style="text-align: center;"><img 
						style="width: 10px; float: left; cursor: pointer;"
						src="<c:url value="/resources/static/img/prev.png"/>"
						onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'">
						<span style="font-size: 0.7rem;"><%=year%></span> <span
						style="font-size: 1.5rem;"><%=month%></span> <img
						style="width: 10px; float: right; cursor: pointer;"
						src="<c:url value="/resources/static/img/next.png"/>"
						onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">
					</td>
				</tr>
				<tr>
					<th>SUN</th>
					<th>MON</th>
					<th>TUE</th>
					<th>WED</th>
					<th>THU</th>
					<th>FRI</th>
					<th>SAT</th>
				</tr>
				<tr>
					<%
					for (int i = 1; i < week; i++) {
						out.println("<td>&nbsp;</td>");
					}

					//날짜출력
					for (int i = 1; i <= lastDay; i++) {
						cal.set(year, month - 1, i);
						week = cal.get(Calendar.DAY_OF_WEEK);

						//일요일, 토요일은 붉은색으로 처리

						if (week == 1) {
							if (year == toYear && month == toMonth && i == toDate) {
						out.println("<td style='background-color:rgb(222, 226, 230);'>" + i + "</td>");
							} else {
						out.println("<td style='color:red;'>" + i + "</td>");
							}
						} else if (week == 7) {
							if (year == toYear && month == toMonth && i == toDate) {
						out.println("<td style='background-color:rgb(222, 226, 230);'>" + i + "</td>");
							} else {
						out.println("<td style='color:red;'>" + i + "</td>");
							}

						} else {
							if (year == toYear && month == toMonth && i == toDate) {
						out.println("<td style='background-color:rgb(222, 226, 230);'>" + i + "</td>");
							} else {
						out.println("<td>" + i + "</td>");
							}
						}
						//토요일이면 다음줄로 넘어감
						if (week == 7) {
							out.println("</tr>");
							//말일이 아니면 다음줄을 출력함
							if (i < lastDay)
						out.println("<tr>");
						}
					}
					%>
				</tr>
			</table>
		</div>
	</div>
	<div id="box3" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">근태관리</div>
		<div class="conCon"
			style="display: grid; grid-template-columns: 1fr 1fr;">

			<input type="hidden" id="tidx" value="<%=userTidx%>">
			<button style="grid-columns: 1/2; margin: 0 5px; height:70%;" id="startWork"
				type="button" class="btn btn-outline-primary btn-lg float-right"
				onclick="location.href='${pageContext.request.contextPath}/commute/startCommute?tidx=<%=userTidx%>'">출근</button>
			<button style="grid-columns: 2/3; margin: 0 5px; height:70%;" id="endWork"
				type="button" class="btn btn-outline-danger btn-lg float-right"
				onclick="location.href='${pageContext.request.contextPath}/commute/endCommute?tidx=<%=userTidx%>'">퇴근</button>
		</div>
	</div>
	<div id="box4" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">전자결재</div>
		<div class="conCon">
			<div class="button_elec"
				style="text-align: right; margin-bottom: 10px;">
				<div class="btn-group" role="group" aria-label="Basic example">
					<button type="button" class="btn btn-secondary" id="wating">결재대기</button>
					<button type="button" class="btn btn-secondary" id="progress">결재진행</button>
					<button type="button" class="btn btn-secondary" id="completed">결재완료</button>
					<button type="button" class="btn btn-secondary" id="rejected">결재반려</button>
				</div>
			</div>
			<table id="table_notice" class="table w-100 table-hover">
				<colgroup>
					<col width="10%">
					<col width="45%">
					<col width="15%">
					<col width="20%">
					<col width="10%">
				</colgroup>
				<tr> 
					<th>문서번호</th>
					<th>제목</th>
					<th>기안자</th>
					<th>기안일시</th>
					<th>상태</th>
				</tr>
				<tbody id="approval">
					<c:forEach items="${approvalList}" var="approval">
						<tr>
							<td>${approval.eidx}</td>
							<td><c:choose>
									<c:when test="${approval.e_type == '중요일정' || approval.e_type == '회사일정' || approval.e_type == '외근' || approval.e_type == '출장'}">
										<a
											href="${pageContext.request.contextPath}/approval/documentContents?eidx=${approval.eidx}&tidx=${approval.tidx}"
											onclick="window.open(this.href, '_blank', 'width=770, height=915'); return false;"
											style="text-decoration: none; color: black;">${approval.e_textTitle }</a>
									</c:when>
									<c:otherwise>
										<a href="${pageContext.request.contextPath}/leave/view?eidx=${approval.eidx}"
											onclick="window.open(this.href, '_blank', 'width=770, height=630'); return false;"
											style="text-decoration: none; color: black;">${approval.e_textTitle }</a>
									</c:otherwise>
								</c:choose></td>
							<td>${approval.t_name}</td>
							<td>${approval.e_draftDate}</td>
							<td>${approval.e_status}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<%
	String author = (String) request.getAttribute("author");
	String message = (String) request.getAttribute("message");
	%>
	<div id="box5" class="inner_content"
		style="width: 100%; height: 100%; font-size: 50px;">
		<div class="conTitle">오늘의명언</div>
		<div class="conCon" style="display: flex; align-items: center;">
			<div id="sayingWrap">
				<img class="quote" style="margin-right: 7px;"
				src="<c:url value="/resources/static/img/left-quote.png"/>">
				<%=message%>
				<img class="quote" style="margin-left: 7px;"
				src="<c:url value="/resources/static/img/right-quote.png"/>">
				<p id="speaker" style="text-align: right; margin-top: 15px;">
					<%=author%>
				</p>
			</div>
		</div>
	</div>
	<div id="box6" class="inner_content space">&nbsp;</div>
	<script>
		function selectApproval(data) {
			var approval = "";
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					approval += "<tr>";
					approval += "<td>";
					approval += data[i].eidx;
					approval += "</td>";
					approval += "<td>";
					if((data[i].e_type)!="개인일정"){
						approval+="<a href='";
						approval+= $("#domain").val();
						approval+= "/approval/documentContents?eidx=";
						approval+=data[i].eidx;
						approval+="&tidx=";
						approval+=data[i].tidx;
						approval+="' onclick='#'";
						approval+="style='text-decoration: none; color: black;'>";
						approval+=data[i].e_textTitle;
						approval+="</a>";	
					}else{
						approval+="<a href='";
						approval+= $("#domain").val();
						approval+="/member/leaveView?eidx=";
						approval+=data[i].eidx;
						approval+="' onclick='#'";
						approval+="style='text-decoration: none; color: black;'>";
						approval+=data[i].e_textTitle;
						approval+="</a>";	
					}
					approval += "</td>";
					approval += "<td>";
					approval += data[i].t_name;
					approval += "</td>";
					approval += "<td>";
					approval += data[i].e_draftDate;
					approval += "</td>";
					approval += "<td>";
					approval += data[i].e_status;
					approval += "</td>";
					approval += "</tr>";
				}

				$("#approval").html(approval);
				$("#approval").find("a").attr("onclick","window.open(this.href, '_blank', 'width=770, height=915'); return false;");
			} else {
				$("#approval").html(
						"<tr><td colspan='6'>해당하는 문서가 존재하지 않습니다.</td></tr>");
			}
		}

		$(document).ready(
				function() {
					$("#wating, #progress, #completed, #rejected").on(
							"click",
							function() {

								$.ajax({
									type : "post",
									url : $("#domain").val()+"/main/approval",
									data : {
										"state" : $(this).attr("id")
									},
									dataType : "json",
									error : function(request, status, error) {
										console.log("code:" + request.status
												+ "\n" + "message:"
												+ request.responseText + "\n"
												+ "error:" + error);
									},
									success : function(data) {
										selectApproval(data);
									}
								});

							});
				});
	</script>
</body>
</html>