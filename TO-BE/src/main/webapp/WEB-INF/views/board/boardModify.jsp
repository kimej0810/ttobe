<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	
	<style>
		#modify{
			width:100%;
			text-align:center;
		}
		#title{
			width:100%;
		}
		#content{
			width:100%;
			height:400px;
		}
		#btnArea{
			text-align:right;
		}
	</style>
</head>
<body>
	<form action="modifyAction" method="post" name="modifyForm">
		<input type="hidden" value="${boardVO.bidx}" name="bidx">
		<input type="hidden" value="G" name="b_type">
		<input type="hidden" value="fileNoDel" name="fileNoDel[]" value="">
		<input type="hidden" value="fileNameDel" name="fileNameDel[]" value="">
		<table id="modify" class="table">
			<tr>
				<th style="width:25%;">글제목</th>
				<td>
					<input type="text" name="b_title" value="${boardVO.b_title}" id="title">
				</td>
			</tr>
			<tr>
				<th style="width:25%;">내용</th>
				<td>
					<textarea name="b_content" id="content">${boardVO.b_content}</textarea>
				</td>
			</tr>
			<tr>
				<th style="width:25%;">첨부파일</th>
				<td id="fileIndex" style="text-align:left;">
					<c:forEach var="file" items="${file}" varStatus="var">
					<div id="fileArea">
						<div style="width:100%; height:28.4px;">
							<input type="hidden" id="FIDX" name="FIDX" value="${file.FIDX}">
							<a>${file.F_ORG_FILE_NAME}</a>(${file.F_FILE_SIZE}kb)
							<button id="fileDel" style="float:right;" onclick="fn_del(${file.FIDX});" type="button">삭제</button>
						</div>
					</div>
					</c:forEach>
				</td>
			</tr>
		</table>
		<div id="btnArea">
			<button type="button" class="btn btn-primary btn-sm float-right cancel_btn">취소</button>
			<button type="button" class="btn btn-primary btn-sm" id="fileAdd">파일추가</button>
			<button type="submit" class="btn btn-primary btn-sm float-right">등록</button>
		</div>
	</form>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='modifyForm']");
			
			$("#fileAdd").on("click", function(){
				$("#fileArea").append("<div style='width:100%;'><input type='file' name='file'>"
						+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
				
				$(document).on("click","#fileDelBtn", function(){
					$(this).parent().remove();
					
				});
			});
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/view?bidx=${boardVO.bidx}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			});
		});
		
		var fidxArray = new Array();
		
		function fn_del(fidx){
			fidxArray.push(fidx);
			alert(fidxArray.length);	
		}
	</script>
</body>
</html>