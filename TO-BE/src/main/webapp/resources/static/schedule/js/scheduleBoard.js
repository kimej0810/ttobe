function scheduleAddPopup(){
	var url = "schedulePopup";
	var name = "schedulePopup";
	var option = "width = 600, height = 830 left = 100, top=50,location=no";
	window.open(url,name,option)
}
$(function(){
	$(document).on("click","#searchBtn",function() {
		$.ajax({
			url:"/schedule/searchSchedule",
			data: {
				searchType : $("#searchType").val(),
				keyword : $("#keyword").val()
			},
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			success:function(svo){
				var schedule = ""; 
				for(var i=0; i < svo.length; i++){
					schedule += "<tr><td scope='row'>"+svo[i].s_type+"</td>";
					schedule += "<td class='control-label scheduletitle'><input type='hidden' value='"+svo[i].sidx+"'>";
					schedule += "<a id='aBtn' href='#' title='scheduleContents?sidx="+svo[i].sidx+"&tidx="+svo[i].tidx+"'>"; 
					if(svo[i].s_title.length > 10){
						schedule += svo[i].s_title.substring(0,10)+"</a></td>";
					}else{
						schedule += svo[i].s_title+"</a></td>";
					}
					
					if(svo[i].s_startDate == svo[i].s_endDate){
						schedule += "<td class='scheduleDate'>"+svo[i].s_startDate+"</td><td>\</td>";
					}else{
						schedule += "<td class='scheduleDate'>"+svo[i].s_startDate+"</td><td class='scheduleDate'>"+svo[i].s_endDate+"</td>";
					}
					
					schedule += "<td class='scheduleContents'><a id='aBtn' href='#' title='scheduleContents?sidx="+svo[i].sidx+"&tidx="+svo[i].tidx+"'>";
					if(svo[i].s_content.length > 50){
						schedule += svo[i].s_content.substring(0,50)+"</a></td><td>"+svo[i].memberVO.t_name+"</td></tr>";
					}else{
						schedule += svo[i].s_content+"</a></td><td>"+svo[i].memberVO.t_name+"</td></tr>";
					}
				}
				$("#scheduleDataTbody").html(schedule);
			}
		});
	});
	$(document).on("click","#aBtn",function(){
		var url = $(this).attr("title");
		var name = "_blank";
		var option =  "width=600, height=800";
		window.open(url,name,option);
	});
	$('#calendarButton').on("click",function(){
		location.href = "scheduleCalendar";
	});
});