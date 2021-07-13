$(document).on("focusout","#s_title",function(){
	if($("#s_title").val() == "" ||  $("#s_title").val().length < 5 || $("#s_title").val().length > 80){
		$("#s_title").attr("title","5글자이상 80글자이하로 입력해주세요.");
		$("#s_title").tooltip({
			animation: true,
			container:"#tootip_area",
			delay:{show:50,hide:10},
			html:false,
			template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
			trigger:'manual'
		});
		$("#s_title").tooltip('show');
		$("#s_title").focus();
	}else{
		$("#s_title").tooltip('hide');
	}
});
$(document).on("focusout","#s_startDate",function(){
	var startDate = $("#s_startDate").val().replace("-","/");
	var endDate = $("#s_endDate").val().replace("-","/");
	var start = new Date(startDate);
	var end = new Date(endDate);
	
	if($("#s_startDate").val() == "" || start > end ){
		$("#s_startDate").attr("title","날짜를 올바르게 선택해주세요.");
		$("#s_startDate").tooltip({
			animation: true,
			container:"#tootip_area2",
			delay:{show:50,hide:10},
			html:false,
			template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
			trigger:'manual'
		});
		$("#s_startDate").tooltip('show');
		$("#s_startDate").focus();
	}else{
		$("#s_startDate").tooltip('hide');
	}
})
$(document).on("focusout","#s_endDate",function(){
	var startDate = $("#s_startDate").val().replace("-","/");
	var endDate = $("#s_endDate").val().replace("-","/");
	var start = new Date(startDate);
	var end = new Date(endDate);
	
	if($("#s_endDate").val() == "" || start > end ){
		$("#s_endDate").attr("title","날짜를 올바르게 선택해주세요.");
		$("#s_endDate").tooltip({
			animation: true,
			container:"#tootip_area3",
			delay:{show:50,hide:10},
			html:false,
			template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
			trigger:'manual'
		});
		$("#s_endDate").tooltip('show');
		$("#s_endDate").focus();
	}else{
		$("#s_endDate").tooltip('hide');
	}
});
$(document).on("focusout","#s_content",function(){
	if($("#s_content").val() == "" ||  $("#s_content").val().length < 5 || $("#s_content").val().length > 2048 ){
		$("#s_content").attr("title","5글자이상 2048글자이하로 입력해주세요.");
		$("#s_content").tooltip({
			animation: true,
			container:"#tootip_area4",
			delay:{show:50,hide:10},
			html:false,
			template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
			trigger:'manual'
		});
		$("#s_content").tooltip('show');
		$("#s_content").focus();
	}else{
		$("#s_content").tooltip('hide');
	}
});

//add schedule
$.fn.serializeObject = function(){
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
    	var name = $.trim(this.name),
    		value = $.trim(this.value);
    	
        if (o[name]) {
            if (!o[name].push) {
                o[name] = [o[name]];
            }
            o[name].push(value || '');
        } else {
            o[name] = value || '';
        }
    });
    return o;
};

function click_ok(){
	var startDate = $("#s_startDate").val().replace("-","/");
	var endDate = $("#s_endDate").val().replace("-","/");
	var start = new Date(startDate);
	var end = new Date(endDate);
	
	if($("#s_title").val() == ""){
		return false;
	}else if($("#s_title").length < 5 || $("#s_title").length > 80 ){
		return false;
	}else if($("#s_startDate").val() == ""){
		return false;		
	}else if($("#s_endDate").val() == ""){
		return false;
	}else if(start > end){
		alert("종료날짜보다 시작날짜가 작아야합니다.");
		return false;
	}else if($("#s_content").val() == "" || $("#s_content").length > 2048){
		return false;
	}
	var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
	var result = confirm("일정 추가하시겠습니까?");
	
	if(result){
		$.ajax({
			data : scheduleData,
			url : "/schedule/addSchedule",
			type : "POST",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				var result
				opener.parent.location.reload();
				window.close();
			}
		});
	}
};

