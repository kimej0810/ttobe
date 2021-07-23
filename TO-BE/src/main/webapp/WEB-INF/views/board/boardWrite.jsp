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
	<form id="writeAction" action="${pageContext.request.contextPath}/board/writeAction" method="post" enctype="multipart/form-data">
		<%
			Integer tidx = (Integer)session.getAttribute("userTidx");
			String grade = (String)session.getAttribute("userGrade"); 
		%>
		<input type="hidden" name="grade" value="<%=grade%>">
		<input type="hidden" name="tidx" value="<%=tidx%>">
		<table id="write" class="table">
			<tr>
				<th style="width:25%;">글제목</th>
				<td>
					<input type="text" class="form-control" name="b_title" id="title">
				</td>
			</tr>
			<tr>
				<th style="width:25%;">내용</th>
				<td>
					<textarea name="b_content" id="content" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<th style="width:25%;">첨부파일</th>
				<td style="text-align:left;">
					<div id="fileArea">
						<input type='file' name='file_0'>
					</div>
				</td>
			</tr>
		</table>
		<div id="btnArea">
			<button type="button" class="btn btn-primary btn-sm float-right" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
			<button type="button" class="btn btn-primary btn-sm" id="fileAdd">파일추가</button>
			<button type="button" class="btn btn-primary btn-sm float-right" id="submitBtn">등록</button>
		</div>
	</form>
</body>
<script>
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
	$(document).ready(function(){
		fileCount = 1;
		$("#fileAdd").on("click", function(){
			$("#fileArea").append("<div><input type='file' name='file_"+(fileCount++)+"'/>"
					+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		});
		
		$("#submitBtn").on("click", function(){
			var content = "";
			
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
			}else if($("#content").val()==""){
				alert("내용을 입력해주세요.");
			}else if($("#content").val().length>=2000){
				alert("최대 2000자까지 입력 가능합니다.");
			}else{
				content = removeHtml($("#content").val());
				$("#content").val(content);
				$("#writeAction").submit();
			}
		});
	});
	
</script>
</html>