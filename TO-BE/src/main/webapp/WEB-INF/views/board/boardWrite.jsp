<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	<style>
		#write{
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
	<form action="writeAction" method="post" enctype="multipart/form-data">
		<input type="hidden" value="G" name="b_type">
		<table id="write" class="table">
			<tr>
				<th style="width:25%;">글제목</th>
				<td>
					<input type="text" name="b_title" id="title">
				</td>
			</tr>
			<tr>
				<th style="width:25%;">내용</th>
				<td>
					<textarea name="b_content" id="content"></textarea>
				</td>
			</tr>
			<tr>
				<th style="width:25%;">첨부파일</th>
				<td style="text-align:left;">
					<div id="fileArea">
						<input type='file' name='file'>
					</div>
				</td>
			</tr>
		</table>
		<div id="btnArea">
			<button type="button" class="btn btn-primary btn-sm float-right" onclick="location.href='/board/list'">취소</button>
			<button type="button" class="btn btn-primary btn-sm" id="fileAdd">파일추가</button>
			<button type="submit" class="btn btn-primary btn-sm float-right">등록</button>
		</div>
	</form>
</body>
<script>
	$(document).ready(function(){
		$("#fileAdd").on("click", function(){
			$("#fileArea").append("<div><input type='file' name='file'>"
					+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		});
	});
</script>
</html>