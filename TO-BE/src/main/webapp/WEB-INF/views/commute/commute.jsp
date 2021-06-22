<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/static/js/jquery-3.6.0.min.js"></script>
<script>
	
	function selectAllCommute(data){
		var c_list = "";
		
		if(data.length>0){
			for(var i=0; i<data.length; i++){
				c_list += "<tr>";
				c_list += "<td>";
				c_list += data[i].c_type;
				c_list += "</td>";
				c_list += "<td>";
				c_list += data[i].c_date;
				c_list += "</td>";
				c_list += "<td>";
				c_list += data[i].c_starttime;
				c_list += "</td>";
				c_list += "<td>";
				c_list += "data[i].c_endtime";
				c_list += "</td>";
				c_list += "<td>";
				c_list += "data[i].c_time";
				c_list += "</td>";		
				c_list += "</tr>";
			}
			$("#c_list").html(c_list);
		}
	}
	
$(document).ready(function(){
	//출근기록
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
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success:function(data){
				selectAllCommute(data);		
			}
		});
	});
	
	//퇴근기록
	$("#endWork").on("click", function(){
		var today = new Date();
		var tidx = $("#tidx").val();
		var cidx = $("#cidx").val();
		
		var hours = today.getHours(); //시간
		var minutes = today.getMinutes(); //분
		var endTime = hours+":"+minutes;
		
		//var c_time = 
		
			
			
		console.log(endTime);
		
		var form = {
			    c_endtime: endTime,
			    tdix: tidx,
			    cidx: cidx
			}
		
		$.ajax({
			//type: 
			url:"/commute/endCommute",
			data: form,
			dataType:"json",
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success:function(data){
				selectAllCommute(data);		
			}
		});
		
	});
	
	
});
</script>
</head>
<body>
	<div>
		<span><a href="?tidx=3">근태현황</a></span>
		<span><a href="">연차일정</a></span>
		<span><a href="">연차관리</a></span>
	</div>
	<div>기간</div>
	<div>
		<span>총 근무시간</span>
		<span></span>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>근태유형</th>
				<th>출퇴근일자</th>
				<th>출근기록</th>
				<th>퇴근기록</th>
				<th>근무시간</th>
			</tr>
		</thead>
		<tbody id="c_list">
		<!--
			<tr>
				<td>넣어야함</td>
				<td>넣기싫음</td>
				<td>어떻게넣어</td>
				<td>모르겠는데</td>
				<td>이걸왜한다고해서ㅜㅜ</td>
			</tr>
			<tr>
				<td>${member.t_id}</td>
				<td>${member.t_name}</td>
				<td><input type="hidden" id="tidx" value="${member.tidx}"></td>
				<td></td>
				<td></td>
				
			</tr>  -->
		</tbody>		
	</table>
	<form name="frm">
		<button type="button" name="startWork" id="startWork">출근</button>
		<button type="button" name="endWork" id="endWork">퇴근</button>
		<input type="hidden" id="tidx" name="tidx" value="${member.tidx}" />
	</form>
	
</body>
</html>
