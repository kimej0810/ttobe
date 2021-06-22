<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link href="<c:url value="/resources/static/css/main.css"/>" rel='stylesheet' />
</head>
<body>
   <div class="wrap">
        <div class="nav">
            <div class="logo">
                <img src="<c:url value="/resources/static/img/logo3.png"/>">
            </div>
            <div class="toggle">
                <img src="<c:url value="/resources/static/img/toggle.png"/>">
            </div>
            <div class="profile">
                <img src="<c:url value="/resources/static/img/profile.png"/>">
             	<a href="/member/mypage?t_id=${member.t_id}"><span class="name">${member.t_name}</span></a>
                <div class="saown_num">201668451</div>
                <div class="dept_rank"><a href="/commute/commute?t_id=${member.t_id}">출근</a></div>
                <div class="logout">로그아웃</div>
            </div>
        </div>
        <div class="header">
            <div class="now">메인 페이지</div>
            <div class="menu">
                <a href="/member/solist"><div>사원관리</div></a>
                <div>일정관리</div>
                <div>근태관리</div>
                <div>전자결재</div>
                <div>게시판</div>
                <div>자료실</div>
                <div>관리자</div>
            </div>
        </div>
        <div class="content">
            <div class="inner_content" id="inner_content1">
                 <div class="inner_title">
                    공지사항
                </div>
                <div class="inner_inner_content">
                    <table id="table_notice">
                        <colgroup>
                            <col width="10%">
                            <col width="45%">
                            <col width="15%">
                            <col width="20%">
                            <col width="10%">
                        </colgroup>
                        <tr>
                            <td>1</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="inner_content" id="inner_content2">
                 <div class="inner_title">
                    달력
                </div>
            </div>
            <div class="inner_content" id="inner_content3">
                <div class="inner_title">
                    근태관리
                </div>
            </div>
            <div class="inner_content" id="inner_content4">
                <div class="inner_title">
                    전자결재
                </div>
                <div class="inner_inner_content">
                    <div class="btn_area">
                        <button type="button">결재대기</button>
                        <button type="button">결재진행</button>
                        <button type="button">결재완료</button>
                    </div>
                    <table id="table_elec">
                        <colgroup>
                            <col width="10%">
                            <col width="45%">
                            <col width="15%">
                            <col width="20%">
                            <col width="10%">
                        </colgroup>
                        <tr>
                            <td>1</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>[공지] 공지사항입니다.</td>
                            <td>홍길동</td>
                            <td>2021.05.25</td>
                            <td>0</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="inner_content" id="inner_content5">
                <div class="inner_title">
                    오늘의 명언
                </div>
            </div>
        </div>
    </div>
</body>
</html>