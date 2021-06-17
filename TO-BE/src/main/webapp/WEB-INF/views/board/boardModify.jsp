<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
</head>
<body>
	<form action="modifyAction" method="post" name="modifyForm">
		<input type="hidden" value="${boardVO.bidx}" name="bidx">
		<input type="hidden" value="G" name="b_type">
		<table>
			<tr>
				<th>글제목</th>
				<td>
					<input type="text" name="b_title" value="${boardVO.b_title}">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="b_content">${boardVO.b_content}</textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<button type="button">파일추가</button>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" class="cancel_btn">취소</button>
			<button type="submit">등록</button>
		</div>
	</form>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='modifyForm']");
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/view?bidx=${boardVO.bidx}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
		})
	</script>
</body>
</html>