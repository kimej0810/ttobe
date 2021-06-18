<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</head>

<body>
	<form name="readForm" role="form" method="post">
		<input type="hidden" id="bidx" name="bidx" value="${boardVO.bidx}" />
		<input type="hidden" id="page" name="page" value="${scri.page}">
		<input type="hidden" id="perPageNum" name="perPageNum"
			value="${scri.perPageNum}"> <input type="hidden"
			id="searchType" name="searchType" value="${scri.searchType}">
		<input type="hidden" id="keyword" name="keyword"
			value="${scri.keyword}">
		<input type="hidden" id="FIDX" name="FIDX" value="">
	</form>
	<table border="1">
		<tr>
			<td>${boardVO.b_title}</td>
			<td>
				<fmt:parseDate var="writedate" value="${boardVO.b_writedate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate value="${writedate}" pattern="yyyy-MM-dd"/>
			</td>
			<td>${boardVO.memberVO.t_name}</td>
			<td>${boardVO.b_hit}</td>
		</tr>
		<tr>
			<td colspan="4" style="white-space:pre;">${boardVO.b_content}</td>
		</tr>
		<tr>
			<c:forEach var="file" items="${file}">
				<td>
					<c:if test="${file.F_TYPE eq 'png'||file.F_TYPE eq 'jpg'||file.F_TYPE eq 'gif'}">
					<img src="<c:url value="/resources/static/file/${file.F_STORED_FILE_NAME}"/>" style="width:100px;">
					</c:if>
					<a href="#" onclick="fn_fileDown('${file.FIDX}'); return false;">${file.F_ORG_FILE_NAME}</a>(${file.F_FILE_SIZE}kb)<br>
				</td>
			</c:forEach>
		</tr>
	</table>
	<table id="reply" border="1">
		<c:forEach items="${replyList}" var="replyList">
			<tr>
				<td rowspan="3">
					<img src="<c:url value="/resources/static/img/profile.png"/>" style="width: 50px;">
				</td>
				<td>${replyList.memberVO.t_name}
					<fmt:parseDate var="writedate" value="${boardVO.b_writedate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate value="${writedate}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
			<tr>
				<td class="contentArea">${replyList.r_content}</td>
			</tr>
			<tr>
				<td>
					<button type="button" class="inputAreaBtn">수정</button>
					<button type="button" class="deleteReplyBtn">삭제</button>
					<input type="hidden" value="${replyList.ridx}" id="ridx" name="ridx">
				</td>
			</tr>
		</c:forEach>
	</table>
	<form name="reply" method="post">
		<input type="hidden" id="bidx" name="bidx" value="${boardVO.bidx}" />
		<input type="hidden" id="page" name="page" value="${scri.page}">
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}">
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
		<input type="text" id="r_content" name="r_content" />
		<div>
			<button type="button" class="writeReplyBtn">작성</button>
		</div>
	</form>
	<button type="button"
		onclick="location.href='modify?bidx=${boardVO.bidx}'">수정</button>
	<button type="button"
		onclick="location.href='delete?bidx=${boardVO.bidx}'">삭제</button>
	<button type="submit" class="list_btn" >목록</button>
	<script>
		//댓글 출력
		function selectAllReply(data){
			var reply="";
			
			if(data.length>0){
			for(var i=0; i<data.length; i++){
		
			reply += "<tr>";
			reply += "<td rowspan='3'>";
			reply += "<img src='<c:url value='/resources/static/img/profile.png'/>' style='width:50px;'>";
			reply += "</td>";
			reply += "<td>";
			reply += data[i].memberVO.t_name;
			reply += " ";
			reply += data[i].r_writedate.substr(0, 10);
			reply += "</td>";
			reply += "</tr>";
			reply += "<tr>";
			reply += "<td>";
			reply += data[i].r_content;
			reply += "</td>";
			reply += "</tr>";
			reply += "<tr>";
			reply += "<td>";
			reply += "<button type='button' class='inputAreaBtn'>수정</button>";
			reply += " ";
			reply += "<button type='button' class='deleteReplyBtn'>삭제</button>";
			reply += "<input type='hidden' value='";
			reply += data[i].ridx;
			reply += "' id='ridx' name='ridx'>";
			reply += "</td>";
			reply += "</tr>";
			}
					
			$("#reply").html(reply);
			}else{
				$("#reply").html("댓글이 아직 없습니다.");
			}
		}
	
		//댓글 작성
		$(document).on("click", ".writeReplyBtn", function(){
			
			var form = {
			    ridx:1,
			    r_writedate:"2021/06/11",
			    delyn:"N",
			    tidx:1,
				r_content:$("#r_content").val(),
				bidx:$("#bidx").val()
			}
			
			$.ajax({
				type:"post",
				url:"/reply/write",
				data:form,
				dataType:"json",
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(data){
					selectAllReply(data);
				}
			});
		});
		
		//댓글 삭제
		$(document).on("click", ".deleteReplyBtn", function(){
			
			$.ajax({
				type:"post",
				url:"/reply/delete",
				data:{"ridx":$(this).next('#ridx').val(), "bidx":$("#bidx").val()},
				dataType: "json",
				error:function(request,status,error){
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(data){
					selectAllReply(data);
				}
			});
		});
		
		//댓글 수정창
		$(document).on("click", ".inputAreaBtn", function(){

			var content = $(this).parent().parent().prev().children();
			content.html("<input type='text'>");
			$(this).attr('class', 'modifyReplyBtn');
			$(this).html('확인');
		});
		
		//댓글 수정
		$(document).on("click", ".modifyReplyBtn", function(){
			var modifyVal = $(this).parent().parent().prev().children().children().val();
			var ridx = $(this).next().next().val();
			
			$.ajax({
				type:"post",
				url:"/reply/modify",
				data:{"r_content":modifyVal, "ridx":ridx, "bidx":$("#bidx").val()},
				dataType: "json",
				error:function(request,status,error){
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(data){
					selectAllReply(data);
				}
			});
		});
		
		$(".list_btn").on("click", function(){

			location.href = "/board/list?page=${scri.page}"
			+"&perPageNum=${scri.perPageNum}"
			+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
		})
		
		//첨부파일 다운로드
		function fn_fileDown(fidx){
			var formObj = $("form[name='readForm']");
			$('#FIDX').attr("value", fidx);
			formObj.attr("action", "/board/fileDown");
			formObj.submit();
		}
	</script>
</body>
</html>