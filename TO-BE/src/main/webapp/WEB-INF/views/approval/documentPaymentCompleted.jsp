<%@page import="tobe.project.dto.MemberVO"%>
<%@page import="tobe.project.domain.PageMaker"%>
<%@page import="tobe.project.dto.ApprovalVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	List<ApprovalVO> completed = (List<ApprovalVO>)request.getAttribute("completed");
	PageMaker paging = (PageMaker)request.getAttribute("paging");
	MemberVO mo = (MemberVO)request.getAttribute("info");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>결재진행문서</title>
		<script src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
		<style type="text/css">
			#moveBtnGroup{
				width:995px;
				margin:0px auto;
				text-align: left;
			}
			.moveBtn{
				margin-right: 33px;
			    height: 38px;
			    font-size: 15px;
			    width: 125px;
			    background-color: lightgray;
			    border: none;
			    border-radius: 5px;
			}
			#statusTable{
				margin:30px auto;
				border-bottom: 1px solid #000000;
		    	border-top: 1px solid #000000;
			}
			#waiting, #progress, #complete{
			    height: 35px;
		   		background-color: lightgray;
			}
			#searchBtnGroup{
				width:995px;
				margin:0px auto;
				text-align: right;
			}
			#searchType{
				height: 32px;
		   		width: 60px;
		   		border-radius: 4px;
		   		font-size: 15px;
			}
			#searchBtn{
				width: 70px;
			    height: 31px;
			    border-radius: 4px;
			    background-color: lightgray;
			    border: none;
			    font-size: 15px;
			}
			#keyword{
				height: 26px;
		    	width: 300px;
			}
			#write{
			    width: 998px;
			    margin: 0px auto;
			    text-align: right;
		    }
			#completedList{
				margin:0px auto;
				border-color: 1px solid lightgray;
		   		border: 1px solid lightgray;
		    	text-align: center;
		    	border-collapse:collapse;
			}
		    td{
		    	border: 1px solid lightgray;
		    }	
		    #completedListGroup{
		    	height: 500px;
		    }
		    #completed_th{
		    	border:1px solid gray;
		    	background-color: lightgray;
		    }
		    .col1{
				width: 65px;
			}
			.col2{
				width: 95px;
			}
			.col3{
				width: 130px;
			}
			.col4{
				width: 130px;
			}
			.col5{
				width: 85px;
			}
			.col6{
				width: 255px;
			}
			.col7{
				width: 230px;
			}
			#paging{
				text-align: center;
				font-size: 20px;
			}
		</style>
		<script type="text/javascript">
			function waiting(){
				location.href="documentWaitingList?t_id=<%=mo.getT_id()%>";
			}
			function progress(){	
				location.href="documentInProgress?t_id=<%=mo.getT_id()%>";
			}
			function completed(){ 
				location.href="documentPaymentCompleted?t_id=<%=mo.getT_id()%>";
			}
			
			function documentWite(){ //기안서 팝업창
				var url = "documentWite?t_id=<%=mo.getT_id()%>";
				var name = "documentWite";
				var option = "width = 660, height = 870 left = 100, top=50,location=no";
				window.open(url,name,option)
			}
		</script>
	</head>
	<body>
	<div id="moveBtnGroup">
			<button type="button" class="moveBtn" onclick="waiting()">결재대기문서</button>
			<button type="button" class="moveBtn" onclick="progress()">결재진행문서</button>
			<button type="button" class="moveBtn" onclick="completed()">결재완료문서</button>
			<div style="float: right;">
				${info.t_name}
			</div>
		</div>
		<div id="statusGroup">
			<table id="statusTable">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<tr>
					<th id="waiting">결제대기문서</th>
					<th>0</th>
					<th id="progress">결제진행문서</th>
					<th>0</th>
					<th id="complete">결제완료문서</th>
					<th>0</th>
				</tr>
			</table>
		</div>
		<div id="completedListGroup">
			<form role="form" method="get">
				<div id="searchBtnGroup">
					<select id="searchType" name="searchType">
						<option value="전체" <c:out value = "${scri.searchType == null ? 'selected' : '' }"/>>-----</option>
						<option value="문서번호" <c:out value = "${scri.searchType eq '문서번호' ? 'selected' : '' }"/>>문서번호</option>
						<option value="기안부서" <c:out value = "${scri.searchType eq '기안부서' ? 'selected' : '' }"/>>기안부서</option>
						<option value="기안자" <c:out value = "${scri.searchType eq '기안자' ? 'selected' : '' }"/>>기안자</option>
						<option value="기안제목" <c:out value = "${scri.searchType eq '기안제목' ? 'selected' : '' }"/>>기안제목</option>
					</select>
					<input type="text" id="keyword" name="keyword" value="${scri.keyword }">
					<button type="button" id="searchBtn">검색</button>
				</div>
				<script type="text/javascript">
					$(function(){
						$('#searchBtn').click(function(){
							self.location = "documentPaymentCompleted" + '${paging.makeQuery(1)}' + "&searchType=" + $('select option:selected').val() + "&keyword=" + encodeURIComponent($('#keyword').val());
						});
					});
				</script>
				<p>여기가 완료리스트입니다</p>
				<table id="completedList">
					<colgroup>
						<col class="col1">
						<col class="col2">
						<col class="col3">
						<col class="col4">
						<col class="col5">
						<col class="col6">
						<col class="col7">
					</colgroup>
					<tr>
						<th id="completed_th">순번</th>
						<th id="completed_th">문서번호</th>
						<th id="completed_th">기안 유형</th>
						<th id="completed_th">기안 부서</th>
						<th id="completed_th">기안자</th>
						<th id="completed_th">제목</th>
						<th id="completed_th">기안 일시</th>
					</tr>
					<%
						for(int i=0; i<completed.size(); i++){
							ApprovalVO vo = completed.get(i);
					%>
					<tr>
						<td><%=vo.getEidx() %></td>
						<td><%=vo.getE_documentNum() %></td>
						<td><%=vo.getE_con() %></td>
						<td><%=vo.getE_buseo() %></td>
						<td><%=vo.getE_member() %></td>
						<td><a href="documentContents?e_documentNum=<%=vo.getE_documentNum()%>" onclick="window.open(this.href, '_blank', 'width=660, height=870'); return false;"><%=vo.getE_textTitle() %></a></td>
						<td><%=vo.getE_draftDate() %></td>
					</tr>
					<%
						} 
					%>
				</table>
			</form>
		</div>
		<div id="paging">
			<%
				if(paging.isPrev() == true){
			%>
					<a href="/approval/documentPaymentCompleted<%= paging.makeSearch(paging.getStartPage()-1) %>">&lt;</a>
			<%
				}
				for(int i=paging.getStartPage(); i<=paging.getEndPage(); i++){
			%>
					<a href="/approval/documentPaymentCompleted<%= paging.makeSearch(i) %>"><%=i %></a>
			<%		
				}
				if(paging.isNext() && paging.getEndPage()>0){
			%>
					<a href="/approval/documentPaymentCompleted<%= paging.makeSearch(paging.getEndPage()+1) %>">&gt;</a>
			<%
				}
			%>
		</div>
		<div id="write">
			<button type="button" onclick="documentWite()">기안 작성</button>
		</div>
	</body>
</html>