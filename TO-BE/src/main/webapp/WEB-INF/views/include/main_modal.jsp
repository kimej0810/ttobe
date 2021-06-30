<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>메인메인메인메인</title>
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/static/js/bootstrap.js"/>"></script>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/bootstrap.min.css"/>"></script>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/static/css/newMain.css"/>"></script>
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h4 class="modal-title">업로드</h4>
				</div>
				<div class="modal-body">
					<form id="fileForm" action="/data/transport" method="post"
						enctype="multipart/form-data" style="height: 30px;">
						<input type="text" name="d_title" placeholder="제목을 입력해주세요...">

						<div class="upload-btn-wrapper">
							<img src='<c:url value='/resources/static/img/plus.png'/>'
								style="width: 15px;"> <input type="file" name="file">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit"
						onclick="document.getElementById('fileForm').submit();">진짜추가</button>
				</div>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content-wrappper">
				<img id="sideLogo"
					src="<c:url value="/resources/static/img/sideLogo.png"/>">
				<div style="margin-top: 23px; margin-left: 15px;">A few
					persons</div>
				<ul class="sidebar-menu">
					<li class="sidebar-menu-item">일정관리</li>
					<li class="sidebar-menu-item">근태관리</li>
					<li class="sidebar-menu-item">게시판</li>
					<li class="sidebar-menu-item">전자결재</li>
					<li class="sidebar-menu-item">자료실</li>
					<li class="sidebar-menu-item">사원정보</li>
				</ul>
			</div>
		</nav>
		<div class="main">
			<nav class="navbar">
				<div class="navbar-wrapper">
					<img src="/resources/static/img/toggle.png"
						class="navbar-toggle sidebar-collapse">

					<h2 style="text-align: center; font-size: 30px; margin-top: 7spx;">AFPS</h2>

					<div class="dropdown">
						<img src="/resources/static/img/profile2.jpg"
							class="btn btn-secondary dropdown-toggle navbar-profile"
							type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"
							aria-expanded="false" style="padding: 0px;">
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"
							style="width: 150px; left: -120px;">
							<li><a class="dropdown-item" href="#">홍길동님</a></li>
							<li><a class="dropdown-item" href="#">LOGOUT</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<main class="content">
</body>
<script>
	$(document).ready(function() {
		var width = $(window).width();
		var main = $('.main');
		$('.navbar-toggle').off().on('click', function() {
			$('.sidebar').toggleClass('active');
		});
	});
</script>
</html>