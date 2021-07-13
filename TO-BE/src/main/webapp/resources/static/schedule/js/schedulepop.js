$(document).ready(function(){
	$("#s_startDate, #s_endDate").datetimepicker({
		disabledWeekDays :[0, 6]
	});
	jQuery.datetimepicker.setLocale('kr');
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
	
	if($("#s_title").val() == "" || $("#s_title").val().length < 5 || $("#s_title").val().length > 80){
		alert("제목을 입력해주세요. [5글자 이상 80글자 이하]");
		$("#s_title").focus();
		return false;
	}else if($("#s_startDate").val() == "" || $("#s_endDate").val() == "" || start > end){
		alert("날짜를 올바르게 선택해주세요. [종료날짜보다 시작날짜가 작아야 합니다.]");
		return false;
	}else if($("#s_content").val() == "" || $("#s_content").length < 10 || $("#s_content").length > 2048){
		alert("내용을 입력해주세요. [10글자 이상 2048글자 이하]");
		$("#s_content").focus();
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

