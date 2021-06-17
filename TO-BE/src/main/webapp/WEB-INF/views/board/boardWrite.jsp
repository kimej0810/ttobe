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
	<form action="writeAction" method="post" enctype="multipart/form-data">
		<input type="hidden" value="G" name="b_type">
		<table>
			<tr>
				<th>글제목</th>
				<td>
					<input type="text" name="b_title">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="b_content"></textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<input type="file" name="file">
				</td>
			</tr>
		</table>
		<div>
			<button type="button" onclick="location.href='/board/list'">취소</button>
			<button type="submit">등록</button>
		</div>
	</form>
</body>
</html>