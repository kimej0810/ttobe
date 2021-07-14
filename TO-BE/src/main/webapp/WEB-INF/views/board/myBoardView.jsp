<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("replace", "<br>");
%>
<%@ page import="tobe.project.dto.BoardVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
#replyArea {
	display: grid;
	grid-template-columns: 5fr 1fr;
	grid-templage-rows: 1fr;
}

.category {
	padding-bottom: 15px;
}

#view {
	padding: 0;
}

#board {
	width: 100%;
	margin: 0;
}

.thumbNail {
	text-align: center;
	display: inline-block;
	width: 100px;
	height: 150px;
	border-raius: 50px;
}

.thumbNail:hover {
	background-color: #e6e6e6;
}

.thumbNailContent {
	display: grid;
	grid-template-columns: 1fr;
	grid-template-rows: 2fr 1fr;
}

.album {
	height: 400px;
	width: 640px;
	overflow: hidden;
}

.images {
	position: relative;
	display: flex;
	height: 400px;
}

.examImages {
	width: 640px;
	height: 400px;
}

button, button:active, button:focus {
	width: 100px;
	height: 30px;
	border: none;
	color: white;
	background-color: teal;
	outline: none;
}

button:hover {
	background-color: turquoise;
}

button:disabled {
	background-color: gray;
}

.prev {
	float: left;
}

.next {
	float: right;
}
</style>
</head>
<body>
	<!-- 세션 -->
	<%
		Integer userTidx = (Integer)session.getAttribute("userTidx");
		String uName = (String) session.getAttribute("userName");
		String userGrade = (String) session.getAttribute("userGrade");
	%>
	<input type="hidden" value="<%=uName%>">
	<input type="hidden" value="<%=userTidx%>" id="tidx">
	<input type="hidden" value="<%=userGrade%>" id="grade">
	<input type="hidden" value="${boardVO.bidx}" id="bidx">
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
					<td colspan="4">
						<div style="margin:10px 0;">
							${boardVO.b_content}
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4"><c:forEach var="file" items="${file}">
							<div class="thumbNail">
								<div class="thumbNailContent">
									<img
										src="<c:url value="/resources/static/file/${file.F_STORED_FILE_NAME}"/>"
										style="width: 100px;"> <a href="#"
										onclick="fn_fileDown('${file.FIDX}'); return false;"
										style="font-size: 0.8rem; text-decoration: none;">${file.F_ORG_FILE_NAME}</a>
								</div>
							</div>
						</c:forEach></td>
				</tr>
				<tr>
					<table id="reply" style="width: 100%;">
						<c:forEach items="${replyList}" var="replyList">
							<tr>
								<td rowspan="3" valign="top" style="width: 7%;"><img
									src="<c:url value="/resources/static/profile/${replyList.memberDTO.f_stored_file_name}"/>"
									style="width: 50px; height: 50px; display: block; margin: 5px auto; border-radius: 70%;"></td>
								<td style="font-size: 0.8rem;">${replyList.memberDTO.t_name}<fmt:parseDate
										var="writedate" value="${boardVO.b_writedate}"
										pattern="yyyy-MM-dd" /> <fmt:formatDate value="${writedate}"
										pattern="yyyy-MM-dd" />
								</td>
							</tr>
							<tr>
								<td class="contentArea">${replyList.r_content}</td>
							</tr>
							<tr>
								<td style="text-align: right;"><c:set var="userTidx"
										value="<%=userTidx%>" /> <c:set var="userGrade"
										value="<%=userGrade%>" /> <c:if
										test="${replyList.memberDTO.tidx eq userTidx || userGrade=='A'}">
										<img class="inputAreaBtn"
											src='<c:url value='/resources/static/img/pen.png'/>'
											style="width: 10px; cursor: pointer;">
										<img class="deleteReplyBtn"
											src='<c:url value='/resources/static/img/cancel.png'/>'
											style="width: 10px; cursor: pointer;">
									</c:if> <input type="hidden" value="${replyList.ridx}" id="ridx"
									name="ridx"></td>
							</tr>
						</c:forEach>
					</table>
					<form name="reply" method="post" style="margin: 10px 0;">
						<input type="hidden" id="bidx" name="bidx" value="${boardVO.bidx}" />
						<input type="hidden" id="page" name="page" value="${scri.page}">
						<input type="hidden" id="perPageNum" name="perPageNum"
							value="${scri.perPageNum}"> <input type="hidden"
							id="searchType" name="searchType" value="${scri.searchType}">
						<input type="hidden" id="keyword" name="keyword"
							value="${scri.keyword}">
						<div id="replyArea"
							style="width: 100%; height: 100px; margin: 0 auto;">
							<textarea id="r_content" name="r_content"
								style="width: 100%; height: 100%; resize: none;"></textarea>
							<button class="btn btn-outline-secondary writeReplyBtn"
								type="button" style="width: 100%; height: 100px;">작성</button>
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
	<div id="btnArea" style="text-align: right; margin-top: 30px;">

		<%
		Integer loginTidx = (Integer) session.getAttribute("userTidx");
		String loginGrade = (String) session.getAttribute("userGrade");
		BoardVO vo = (BoardVO) request.getAttribute("boardVO");
		Integer boardTidx = vo.getTidx();
		if (loginTidx != boardTidx & !loginGrade.equals("A")) {
		%>
		<button type="button" class="btn btn-primary btn-sm float-right"
			onclick="history.back();">목록</button>
		<%
		} else {
		%>
		<button type="button" class="btn btn-primary btn-sm float-right"
			onclick="modifyBtn()">수정</button>
		<button type="button" class="btn btn-primary btn-sm float-right"
			onclick="deleteBtn()">삭제</button>
			<c:if test="${pagePort eq 'board' }">
				<button type="button" class="btn btn-primary btn-sm float-right asas">목록</button>
			</c:if>
			<c:if test="${pagePort eq 'myhome' }">
		<button type="button" class="btn btn-primary btn-sm float-right"
			onclick="window.close();">닫기</button>
			</c:if>
		<%
		}
		%>
	</div>
	<script>
		function modifyBtn(){
			alert("수정하기 페이지로 이동합니다.");
			var bidx = $("#bidx").val();
			opener.parent.location.href="/board/modify?bidx="+bidx;
			window.close();
		}
		function deleteBtn(){
			if(confirm("해당 글을 삭제하시겠습니까?")){
				var bidx = $("#bidx").val();
				self.location.href="/board/delete?bidx="+bidx;
				opener.parent.location.reload();
				alert("삭제되었습니다.");
				window.close();
			}
						
		}
		function removeHtml(text)
		{
		 text = text.replace(/<br>/ig, "\n"); // <br>을 엔터로 변경
		 text = text.replace(/&nbsp;/ig, " "); // 공백      
		 // HTML 태그제거
		 text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
	
		 // shkim.add.
		 text = text.replace(/<(no)?script[^>]*>.*?<\/(no)?script>/ig, "");
		 text = text.replace(/<style[^>]*>.*<\/style>/ig, "");
		 text = text.replace(/<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>/ig, "");
		 text = text.replace(/<\\w+\\s+[^<]*\\s*>/ig, "");
		 text = text.replace(/&[^;]+;/ig, "");
		 text = text.replace(/\\s\\s+/ig, "");
	
		 return text;
		}
	
		//댓글 출력
		function selectAllReply(data) {
			var reply = "";
			var content = "";
			var userTidx = $("#tidx").val();
			var grade = $("#grade").val();
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					replyTidx = data[i].memberDTO.tidx;
					content = removeHtml(data[i].r_content);

					reply += "<tr>";
					reply += "<td valign='top' rowspan='3' style='width:7%;'>";
					reply += "<img src='<c:url value='/resources/static/profile/";
					reply += data[i].memberDTO.f_stored_file_name;
					reply += "'/>' style='width:50px; height:50px; display:block; margin:5px auto; border-radius:70%;'>";
					reply += "</td>";
					reply += "<td style='font-size:0.8rem;'>";
					reply += data[i].memberDTO.t_name;
					reply += " ";
					reply += data[i].r_writedate.substr(0, 10);
					reply += "</td>";
					reply += "</tr>";
					reply += "<tr>";
					reply += "<td class='contentArea'>";
					reply += content;
					reply += "</td>";
					reply += "</tr>";
					reply += "<tr>";
					reply += "<td style='text-align:right;'>";
					
					if(userTidx==replyTidx||grade=='A'){
						reply += "<img class='inputAreaBtn' src='<c:url value='/resources/static/img/pen.png'/>' style='width:10px; cursor:pointer;'>";
						reply += " ";
						reply += "<img class='deleteReplyBtn' src='<c:url value='/resources/static/img/cancel.png'/>' style='width:10px; cursor:pointer;'>";
					}
					
					reply += "<input type='hidden' value='";
					reply += data[i].ridx;
					reply += "' id='ridx' name='ridx'>";
					reply += "</td>";
					reply += "</tr>";
					
					
					
				}

				console.log(reply);
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