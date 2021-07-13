
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="tobe.project.dto.*"%>
<%@page import="java.util.*"%>
<%@ include file="/WEB-INF/views/include/new_main.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>commute page</title>
<style type="text/css">
	table{
		text-align: center;
	}
	main.content {
    	display: block;
    }
    #test1{
    	margin: 5px 0px;
    }
    #btnWrap1{
    	margin: 50px;
    }
</style>
<script type="text/javascript" src="/resources/static/js/jquery-3.6.0.min.js"></script>
<script>

	function selectAllCommute(list){
		
		var c_list = "";
		if(list.length > 0){
			for(var i=0; i<list.length; i++){
				c_list += "<tr>";
				c_list += "<td>"; 
				c_list += list[i].c_type;
				c_list += "</td>";
				c_list += "<td>";
				if(list[i].c_date != null){
					var cdate = list[i].c_date;
					var result = cdate.substring(0,10);
					c_list += result;
				}
				c_list += "<input type='hidden' value='"+list[i].cidx+"' id='cidx' name='cidx'>";
				c_list += "</td>";
				c_list += "<td id='starttime'>";
				c_list += list[i].c_starttime;
				c_list += "</td>";
				c_list += "<td>";
				c_list += list[i].c_endtime;
				c_list += "</td>";
				c_list += "<td>";
				c_list += list[i].c_worktime;
				c_list += "</td>";		
				c_list += "</tr>";
			}
			$("#c_list").html(c_list);
		}
	}
	
	$(document).ready(function(){
		//월별
		var date = new Date();
		var viewYear = date.getFullYear();
		var viewMonth = date.getMonth();
		var load = viewYear+"년&nbsp;"+(viewMonth+1)+"월";
		$("#test1").html(load);
		
		$("#prevMonth").on("click", function(){
			viewMonth = viewMonth-1;
			if(viewMonth === -1){
				viewYear = viewYear - 1;
				viewMonth = viewMonth + 12;
			}
			test1 = viewYear+"년&nbsp;"+(viewMonth+1)+"월";
			$("#test1").html(test1);
			
			var str = viewYear+"/"+("0"+(viewMonth+1)).slice(-2);
			var str2 = str.slice(2);
			var tid = $("#t_id").val();
			
			$.ajax({
				type: 'POST',
				url: "/commute/commute2",
				data: {
					"str":str2,
					"t_id":tid
				},
				dataType: "json",
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(list){
					if(list.length!=0){
						selectAllCommute(list);	
					}else{
						var c_list = "";
						c_list += "<tr><td colspan='5'>근무 기록이 없습니다.</td></tr>";
						$("#c_list").html(c_list);
					}
				}
			});
		});
		
		$("#nextMonth").on("click", function(){
			viewMonth = viewMonth+1;
			if(viewMonth === 12){
				viewYear = viewYear + 1;
				viewMonth = viewMonth - 12;
			}
			test1 = viewYear+"년&nbsp;"+(viewMonth+1)+"월";
			$("#test1").html(test1);
			//날짜
			var str = viewYear+"/"+("0"+(viewMonth+1)).slice(-2);
			var str2 = str.slice(2);
			var tid = $("#t_id").val();
			$.ajax({
				type: 'POST',
				url: "/commute/commute2",
				data: {
					"str":str2,
					"t_id":tid
				},
				dataType: "json",
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(list){
					if(list.length!=0){
						selectAllCommute(list);	
					}else{
						var c_list = "";
						c_list += "<tr><td colspan='5'>근무 기록이 없습니다.</td></tr>";
						$("#c_list").html(c_list);
					}
				}
			});
		});
	});
</script>
</head>
<body> 
	<div>
		<button type="button" class="btn btn-outline-secondary" onclick="location.href='/commute/commute?t_id=${member.t_id}'">근태현황</button>
	</div>
	<div style="text-align:center;" id="btnWrap1">
		<button type="button" id="prevMonth" class="btn btn-outline-primary btn-sm">&lt;</button>
			<span id="test1"></span>
		<button type="button" id="nextMonth" class="btn btn-outline-primary btn-sm">&gt;</button>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th>근태유형</th>
				<th>출퇴근일자</th>
				<th>출근기록</th>
				<th>퇴근기록</th>
				<th>근무시간(분)</th>
			</tr>
		</thead>
		<tbody id="c_list">
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.c_type}</td>
					<td><c:set var="cdate" value="${list.c_date}"/>
							${fn:substring(cdate,0,10)}
						<input type="hidden" value="${list.cidx}" id="cidx" name="cidx">	
					</td>
					<td id="starttime">${list.c_starttime}</td>
					<td>${list.c_endtime}</td>
					<td>${list.c_worktime}</td>
				</tr>
			</c:forEach>
		</tbody>		
	</table>	
	<input type="hidden" id="tidx" value="${member.tidx}">
	<input type="hidden" id="t_id" value="${member.t_id}">
</body>
</html>
