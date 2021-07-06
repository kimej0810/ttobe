$(document).ready(function(){

	/*출근기록*/
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
				alert("출근처리되었습니다.");
			},
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	});
	
	/*퇴근기록*/
	$("#endWork").bind("click", function(){
		var today = new Date();
		var tidx = $("#tidx").val();
		
		var hours = today.getHours(); //시간
		var minutes = today.getMinutes(); //분
		var endTime = hours+":"+minutes;
		
		var c_time = "";
		var endBtn = $("#c_list").children("tr").children("td").children("#cidx").first().val();
		var startTime = $("#starttime").text();
		//alert(startTime);
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
		
		//alert(endBtn);
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
		
		
	});
	
	$("#endWork").trigger("click");
});