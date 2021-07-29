<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>Afps</title> 
<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<script>
	$(document).ready(function(){
		$(document).on("click","#btn1",function(){
			$("#creator2").removeClass("show");
			$("#creator3").removeClass("show");
			$("#creator4").removeClass("show");
			$("#tester").removeClass("show");
			$("a").not(this).attr("aria-expanded","false");
		});
		$(document).on("click","#btn2",function(){
			$("#creator1").removeClass("show");
			$("#creator3").removeClass("show");
			$("#creator4").removeClass("show");
			$("#tester").removeClass("show");
			$("a").not(this).attr("aria-expanded","false");
		});
		$(document).on("click","#btn3",function(){
			$("#creator1").removeClass("show");
			$("#creator2").removeClass("show");
			$("#creator4").removeClass("show");
			$("#tester").removeClass("show");
			$("a").not(this).attr("aria-expanded","false");
		});
		$(document).on("click","#btn4",function(){
			$("#creator1").removeClass("show");
			$("#creator2").removeClass("show");
			$("#creator3").removeClass("show");
			$("#tester").removeClass("show");
			$("a").not(this).attr("aria-expanded","false");
		});
		$(document).on("click","#btn5",function(){
			$("#creator1").removeClass("show");
			$("#creator2").removeClass("show");
			$("#creator3").removeClass("show");
			$("#creator4").removeClass("show");
			$("a").not(this).attr("aria-expanded","false");
		});
	});
</script>
<style>
	body{
		background-color: lightgray;
	}
	.content{
		padding:2%;
		width:90%;
		height:94vh;
		background-color: white;
	    margin: auto;
	    margin-top: 3vh;
	    border-radius: 5px;
	    box-shadow: 0 0 5px 5px #afafaf;
	}
	.btnGroup{
		margin-top:3vh;
	}
	.card{
		height:70vh;
	}
	.card-body{
		padding:0;
	}
	.kio{
	    padding: 2%;
	    font-family: 'Jua', cursive;
	    font-size:1rem;
	}
	a[aria-expanded="true"]{
		background-color: #6c757d;
		color:white;
	}
</style>
</head>
<body>
	<div class="content">
		<div class="mainLogo" >
			<img src="<c:url value="/resources/static/img/sideImg.png"/>" style="width:225px;margin:8px 0 0 15px;" alt='로고이미지'>
		</div>
		<div class="btnGroup input-group">
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator1"
				href="#creator1" role="button" aria-expanded="false" id="btn1">Creator_1</a>
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator2"
				href="#creator2" role="button" aria-expanded="false" id="btn2">Creator_2</a>
				<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator3"
				href="#creator3" role="button" aria-expanded="false" id="btn3">Creator_3</a>
				<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="creator4"
				href="#creator4" role="button" aria-expanded="false" id="btn4">Creator_4</a>
			<a type="button" class="btn btn-outline-secondary btn-sm" data-bs-toggle="collapse" aria-controls="tester"
				href="#tester" role="button" aria-expanded="false" id="btn5">Tester</a>
		</div>
		<div class="collapse" id="creator1">
			<div class="card card-body kio">
				<div class="kio">
					<table class="table" style="margin-bottom: 0;">
						<tr>
							<th>이름</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">김륜광</td>
						</tr>
						<tr>
							<th>Email
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
									<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
								</svg>
							</th>
							</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">homasimsn2@naver.com</td>	
						</tr>
						<tr>
							<th>
								<div>Github
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
										<path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
									</svg>
								</div>
							</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">https://github.com/K-RG</td>
						</tr>
						<tr>
							<th>My work</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">전자결재,일정관리,연차관리</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="collapse" id="creator2">
			<div class="card card-body kio">
				<div class="kio">
					<table class="table" style="margin-bottom: 0;">
						<tr>
							<th>이름</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">윤수진</td>
						</tr>
						<tr>
							<th>Email
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
									<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
								</svg>
							</th>
							</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">062oren@naver.com</td>	
						</tr>
						<tr>
							<th>
								<div>Github
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
										<path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
									</svg>
								</div>
							</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">https://github.com/sujin-backend</td>
						</tr>
						<tr>
							<th>My work</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">메인,게시판,자료실,Include</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="collapse" id="creator3">
			<div class="card card-body kio">
				<div class="kio">
					<table class="table" style="margin-bottom: 0;">
						<tr>
							<th>이름</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">LGR</td>
						</tr>
						<tr>
							<th>Email
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
									<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
								</svg>
							</th>
							</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">hicokecake@gmail.com</td>	
						</tr>
						<tr>
							<th>
								<div>Github
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
										<path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
									</svg>
								</div>
							</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">https://github.com/user3527</td>
						</tr>
						<tr>
							<th>My work</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">로그인,비번찾기,마이페이지,근태관리</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="collapse" id="creator4">
			<div class="card card-body kio">
				<div class="kio">
					<table class="table" style="margin-bottom: 0;">
						<tr>
							<th>이름</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">김은중</td>
						</tr>
						<tr>
							<th>Email
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
									<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2zm13 2.383-4.758 2.855L15 11.114v-5.73zm-.034 6.878L9.271 8.82 8 9.583 6.728 8.82l-5.694 3.44A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.739zM1 11.114l4.758-2.876L1 5.383v5.73z"/>
								</svg>
							</th>
							</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">gearpoint12@naver.com</td>	
						</tr>
						<tr>
							<th>
								<div>Github
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-github" viewBox="0 0 16 16">
										<path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.012 8.012 0 0 0 16 8c0-4.42-3.58-8-8-8z"/>
									</svg>
								</div>
							</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">https://github.com/kimej0810</td>
						</tr>
						<tr>
							<th>My work</th>
						</tr>
						<tr>
							<td style="text-align:right;font-size:1rem;vertical-align : center;">사원정보,내정보,연차관리,관리자,이메일</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="collapse" id="tester">
			<div class="card  card-body">
				<table class="table" style="text-align:center;">
					<tr style="background-color: #6495ed9e;">
						<th scope="col" width="35%">아이디</th>
						<th scope="col" width="45%">비밀번호</th>
						<th scope="col" width="20%">비고</th>
					</tr>
					<tr>
						<td>admin</td>
						<td>210524</td>
						<td>관리자</td>
					</tr>
					<tr>
						<td>21-0000</td>
						<td>21-0000</td>
						<td>대표</td>
					</tr>
					<tr>
						<td>21-0001</td>
						<td>21-0001</td>
						<td>부장</td>
					</tr>
					<tr>
						<td>21-0002</td>
						<td>21-0002</td>
						<td>과장</td>
					</tr>
					<tr>
						<td>21-0003</td>
						<td>21-0003</td>
						<td>대리</td>
					</tr>
					<tr>
						<td>21-0004</td>
						<td>21-0004</td>
						<td>사원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>