<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("replace", "<br>");
%>
<%@ include file="/WEB-INF/views/include/new_main.jsp"%>
<%@ page import="tobe.project.dto.BoardVO"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<style>
#replyArea{
	display:grid;
	grid-template-columns:5fr 1fr;
	grid-templage-rows:1fr;
}

.category {
	padding-bottom: 15px;
}

#view {
	padding: 0;
}

#board {
	width: 100%;
	margin:0;
}
</style>
</head>
<body>
<!-- 세션 -->
<%
	if(session.getAttribute("userName")!=null){
		String uName = (String)session.getAttribute("userName");
		
		
%>
<input type="hidden" value="<%=uName%>">
<input type="hidden" value="<%=userTidx%>" id="tidx">
<%
	}/* else{
		out.println("<script>alert('로그인이 필요한 서비스입니다.');location.href='/member/login';</script>");
	} */
%>
	<div class="category">
		<input type="hidden" id="boardType" value="${boardVO.b_type}">
		<button id="noticeBtn" class="btn btn-outline-secondary" type="button">공지사항</button>
		<button id="generalBtn" class="btn btn-outline-secondary"
			type="button">일반게시글</button>
	</div>
	<div class="container-fluid" id="view">
		<table class="table" id="board">
			<thead>
				<tr>
					<th scope="col" style="width: 55%;">${boardVO.b_title}</th>
					<th scope="col" style="width: 20%;"><fmt:parseDate
							var="writedate" value="${boardVO.b_writedate}"
							pattern="yyyy-MM-dd" /> <fmt:formatDate value="${writedate}"
							pattern="yyyy-MM-dd" /></th>
					<th scope="col">${boardVO.memberVO.t_name}</th>
					<th scope="col">${boardVO.b_hit}</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="4">${boardVO.b_content}</td>
				</tr>
				<tr>
					<c:forEach var="file" items="${file}">
						<td colspan="4"><c:if
								test="${file.F_TYPE eq 'png'||file.F_TYPE eq 'jpg'||file.F_TYPE eq 'gif'}">
								<img
									src="<c:url value="/resources/static/file/${file.F_STORED_FILE_NAME}"/>"
									style="width: 100px;">
							</c:if> <a href="#" onclick="fn_fileDown('${file.FIDX}'); return false;">${file.F_ORG_FILE_NAME}</a>(${file.F_FILE_SIZE}kb)<br>
						</td>
					</c:forEach>
				</tr>
				<tr>
				<table id="reply" style="width:100%;">
					<c:forEach items="${replyList}" var="replyList">
						<tr>
							<td rowspan="3" valign="top" style="width:7%;">
								<img
								src="<c:url value="/resources/static/profile/${replyList.memberDTO.f_stored_file_name}"/>"
								style="width:50px; display:block; margin:5px auto; border-radius:70%;"></td>
							<td style="font-size:0.8rem;">${replyList.memberDTO.t_name}<fmt:parseDate
									var="writedate" value="${boardVO.b_writedate}"
									pattern="yyyy-MM-dd" /> <fmt:formatDate value="${writedate}"
									pattern="yyyy-MM-dd" />
							</td>
						</tr>
						<tr>
							<td class="contentArea">${replyList.r_content}</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								<c:set var="userTidx" value="<%=userTidx%>"/>
								<c:if test="${replyList.memberDTO.tidx eq userTidx}">
									<img class="inputAreaBtn" src='<c:url value='/resources/static/img/pen.png'/>' style="width:10px; cursor:pointer;">
									<img class="deleteReplyBtn" src='<c:url value='/resources/static/img/cancel.png'/>' style="width:10px; cursor:pointer;">
								</c:if>
								<input type="hidden" value="${replyList.ridx}" id="ridx" name="ridx">
							</td>
						</tr>
					</c:forEach>
				</table>
				<form name="reply" method="post" style="margin:10px 0;">
					<input type="hidden" id="bidx" name="bidx" value="${boardVO.bidx}" />
					<input type="hidden" id="page" name="page" value="${scri.page}">
					<input type="hidden" id="perPageNum" name="perPageNum"
						value="${scri.perPageNum}"> <input type="hidden"
						id="searchType" name="searchType" value="${scri.searchType}">
					<input type="hidden" id="keyword" name="keyword"
						value="${scri.keyword}"> 
					<div id="replyArea" style="width:100%; height:100px; margin:0 auto;">
						<textarea id="r_content" name="r_content" style="width:100%; height:100%; resize: none;"></textarea>
						<button class="btn btn-outline-secondary writeReplyBtn" type="button" style="width:100%; height:100px;">작성</button>
					</div>
				</form>
				</tr>
		</table>
	</div>
	<form name="readForm" role="form" method="post">
		<input type="hidden" id="bidx" name="bidx" value="${boardVO.bidx}" />
		<input type="hidden" id="page" name="page" value="${scri.page}">
		<input type="hidden" id="perPageNum" name="perPageNum"
			value="${scri.perPageNum}"> <input type="hidden"
			id="searchType" name="searchType" value="${scri.searchType}">
		<input type="hidden" id="keyword" name="keyword"
			value="${scri.keyword}"> <input type="hidden" id="FIDX"
			name="FIDX" value="">
	</form>
	<div id="btnArea" style="text-align:right; margin-top:30px;">
	
	<% 
		Integer loginTidx = (Integer)session.getAttribute("userTidx");
		String loginGrade = (String)session.getAttribute("userGrade");
		BoardVO vo = (BoardVO)request.getAttribute("boardVO");
		Integer boardTidx = vo.getTidx();
		if(loginTidx!=boardTidx & !loginGrade.equals("A")){
	%>
		<button type="button" class="btn btn-primary btn-sm float-right list_btn">목록</button>
	<%
				
		}else{
				
	%>
		<button type="button" class="btn btn-primary btn-sm float-right" onclick="location.href='modify?bidx=${boardVO.bidx}'">수정</button>
		<button type="button" class="btn btn-primary btn-sm float-right" onclick="location.href='delete?bidx=${boardVO.bidx}'">삭제</button>
		<button type="button" class="btn btn-primary btn-sm float-right list_btn">목록</button>			
	<%
		}
	%>
	</div>
	<script>
		//댓글 출력
		function selectAllReply(data) {
			var reply = "";

			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {

					reply += "<tr>";
					reply += "<td valign='top' rowspan='3' style='width:7%;'>";
					reply += "<img src='<c:url value='/resources/static/profile/${replyList.memberDTO.f_stored_file_name}'/>' style='width:50px; display:block; margin:5px auto; border-radius:70%;'>";
					reply += "</td>";
					reply += "<td style='font-size:0.8rem;'>";
					reply += data[i].memberDTO.t_name;
					reply += " ";
					reply += data[i].r_writedate.substr(0, 10);
					reply += "</td>";
					reply += "</tr>";
					reply += "<tr>";
					reply += "<td class='contentArea'>";
					reply += data[i].r_content;
					reply += "</td>";
					reply += "</tr>";
					reply += "<tr>";
					reply += "<td style='text-align:right;'>";
					reply += "<img class='inputAreaBtn' src='<c:url value='/resources/static/img/pen.png'/>' style='width:10px; cursor:pointer;'>";
					reply += " ";
					reply += "<img class='deleteReplyBtn' src='<c:url value='/resources/static/img/cancel.png'/>' style='width:10px; cursor:pointer;'>";
					reply += "<input type='hidden' value='";
					reply += data[i].ridx;
					reply += "' id='ridx' name='ridx'>";
					reply += "</td>";
					reply += "</tr>";
				}

				$("#reply").html(reply);
			} else {
				$("#reply").html("");
			}
		}

		//댓글 작성
		$(document).on(
				"click",
				".writeReplyBtn",
				function() {

					var form = {
						tidx : $("#tidx").val(),
						r_content : $("#r_content").val(),
						bidx : $("#bidx").val()
					}

					$.ajax({
						type : "post",
						url : "/reply/write",
						data : form,
						dataType : "json",
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						},
						success : function(data) {
							selectAllReply(data);
							$("#r_content").val("");
						}
					});
				});

		//댓글 삭제
		$(document).on(
				"click",
				".deleteReplyBtn",
				function() {

					$.ajax({
						type : "post",
						url : "/reply/delete",
						data : {
							"ridx" : $(this).next('#ridx').val(),
							"bidx" : $("#bidx").val()
						},
						dataType : "json",
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						},
						success : function(data) {
							selectAllReply(data);
						}
					});
				});

		//댓글 수정창
		$(document).on("click", ".inputAreaBtn", function() {

			var content = $(this).parent().parent().prev().children();
			var value = content.html();
			content.html("<textarea id='modifyContent' style='resize: none;'></textarea>");
			$("#modifyContent").html(value);
			$(this).attr('class', 'modifyReplyBtn');
			$(this).html('확인');
		});

		//댓글 수정
		$(document).on(
				"click",
				".modifyReplyBtn",
				function() {
					var modifyVal = $(this).parent().parent().prev().children()
							.children().val();
					var ridx = $(this).next().next().val();

					$.ajax({
						type : "post",
						url : "/reply/modify",
						data : {
							"r_content" : modifyVal,
							"ridx" : ridx,
							"bidx" : $("#bidx").val()
						},
						dataType : "json",
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						},
						success : function(data) {
							selectAllReply(data);
						}
					});
				});

		$(".list_btn")
				.on(
						"click",
						function() {

							location.href = "/board/list?page=${scri.page}"
									+ "&perPageNum=${scri.perPageNum}"
									+ "&searchType=${scri.searchType}&keyword=${scri.keyword}";
						})

		//첨부파일 다운로드
		function fn_fileDown(fidx) {
			var formObj = $("form[name='readForm']");
			$('#FIDX').attr("value", fidx);
			formObj.attr("action", "/board/fileDown");
			formObj.submit();
		}

		$(document).ready(function() {
			if ($("#boardType").val() == "N") {
				$("#noticeBtn").css("background-color", "rgb(108, 117, 125)");
				$("#noticeBtn").css("color", "white");
			} else {
				$("#generalBtn").css("background-color", "rgb(108, 117, 125)");
				$("#generalBtn").css("color", "white");
			}
		});
	</script>
</body>
</html>