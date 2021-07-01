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
<title>Insert title here</title>
<style type="text/css">
	table{
		text-align: center;
	}
</style>
<script type="text/javascript" src="/resources/static/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/resources/static/js/commute.js"></script>
<script>
	
	function selectAllCommute(list){
		var c_list = "";
		console.log(list.length);
		if(list.length>0){
			for(var i=0; i<list.length; i++){
				c_list += "<tr>";
				c_list += "<td>"; 
				c_list += list[i].c_type;
				c_list += "</td>";
				c_list += "<td>";
				if(list[i].c_date!=null){
					var a = list[i].c_date;
					var result = a.substring(0,10);
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

	/* //출근기록
	$("#startWork").on("click", function(){
		var today = new Date();
		var tidx = $("#tidx").val();
		
		var year = today.getFullYear(); //년
		var month = today.getMonth()+1; //월
		var date = today.getDate(); //일
		var startDate = year+"/"+month+"/"+date;
		
		var hours = today.getHours(); //시간
		var minutes = today.getMinutes(); //분
		var startTime = hours+":"+minutes;
		
		//var day = today.getDay(); //요일
		var week = new Array("주말", "정상", "정상", "정상", "정상", "정상", "주말");
		var c_type = week[today.getDay()];
		
		console.log(c_type);
		console.log(startDate);
		console.log(startTime);
		
		
		var form = {
				c_type: c_type,
			    c_date: startDate,
			    c_starttime: startTime,
			    tidx: tidx
			}
		
		$.ajax({
			//type: 
			url:"/commute/startCommute",
			data: form,
			dataType:"json",
			success:function(list){
				selectAllCommute(list);
			},
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	//퇴근기록
	$("#endWork").on("click", function(){
		var today = new Date();
		var tidx = $("#tidx").val();
		
		var hours = today.getHours(); //시간
		var minutes = today.getMinutes(); //분
		var endTime = hours+":"+minutes;
		
		var c_time = "";
		var endBtn = $("#c_list").children("tr").children("td").children("#cidx").first().val();
		var startTime = $("#starttime").text();
		alert(startTime);
		var btime = startTime.split(":");
		var endtime = eval((hours*60)+minutes);
		var bbtime = eval(btime[0]*60);
		console.log("출근시간"+bbtime);
		var bctime = parseInt(bbtime);
		var bdtime = parseInt(btime[1]);
		var stTime = bctime+bdtime;
		console.log("출근시간 분으로"+stTime);
		var result = endtime-stTime;
		console.log("근무시간"+result);
	
		console.log(endTime);
		
		var form = {
			    c_endtime: endTime,
			    tidx: tidx,
			    cidx: endBtn,
			    c_worktime: result
			}
		
		alert(endBtn);
		$.ajax({
			//type: 
			url:"/commute/endCommute",
			data: form,
			dataType:"json",
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success:function(list){
				selectAllCommute(list);		
			}
		});
	}); */
	
	//월별
	var date = new Date();
	var viewYear = date.getFullYear();
	var viewMonth = date.getMonth();
	var load = viewYear+"년"+(viewMonth+1)+"월";
	$("#test1").html(load);
	
	$("#prevMonth").on("click", function(){
		viewMonth = viewMonth-1;
		if(viewMonth === -1){
			viewYear = viewYear - 1;
			viewMonth = viewMonth + 12;
		}
		test1 = viewYear+"년"+(viewMonth+1)+"월";
		$("#test1").html(test1);
		
		var str = viewYear+"/"+("0"+(viewMonth+1)).slice(-2);
		var str2 = str.slice(2);
		var tid = $("#t_id").val();
		//alert(tid);
		//alert(str2);

			$.ajax({
				//type: 
				url:"/commute/commute2",
				data: {
					"str":str2,
					"t_id":tid
				},
				dataType:"json",
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(list){
					if(list.length!=0){
						selectAllCommute(list);	
					}else{
						var c_list = "";
						c_list += "<tr><td colspan='5'>없어!</td></tr>";
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
		test1 = viewYear+"년"+(viewMonth+1)+"월";
		$("#test1").html(test1);
		
		//날짜
		var str = viewYear+"/"+("0"+(viewMonth+1)).slice(-2);
		var str2 = str.slice(2);
		var tid = $("#t_id").val();
			$.ajax({
				//type: 
				url:"/commute/commute2",
				data: {
					"str":str2,
					"t_id":tid
				},
				dataType:"json",
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(list){
					if(list.length!=0){
						selectAllCommute(list);	
					}else{
						var c_list = "";
						c_list += "<tr><td colspan='5'>없어!</td></tr>";
						$("#c_list").html(c_list);
					}
				}
			});
		
	});
	
});
</script>
</head>
	<div>
		<span><a href="?tidx=3">근태현황</a></span>
		<span><a href="">연차관리</a></span>
	</div>
	<div style="text-align:center;">
	<button type="button" id="prevMonth">&lt;</button><span id="test1"></span><button type="button" id="nextMonth">&gt;</button>
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
	<form name="frm">
		<button type="button" name="startWork" id="startWork" class="btn btn-primary btn-sm float-right">출근</button>
		<button type="button" name="endWork" id="endWork" class="btn btn-primary btn-sm float-right">퇴근</button>
		<input type="hidden" id="tidx" value="${member.tidx}">
		<input type="hidden" id="t_id" value="${member.t_id}">
	</form>
	
</body>
</html>
