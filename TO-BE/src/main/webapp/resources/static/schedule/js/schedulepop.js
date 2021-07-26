$(document).ready(function(){
	var startD;
	var endD;
	$("#s_startDate").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			startD = $("#s_startDate").val();
			if(startD > endD){
				alert("시작일을 올바르게 선택해주세요.");
				$("#s_startDate").val(endD);
			}
		}
	}); 
	$("#s_endDate").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			endD = $("#s_endDate").val();
			if(startD > endD){
				alert("종료일을 올바르게 선택해주세요.");
				$("#s_endDate").val(startD);
			}
		}
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

function getContextPath(){
	var hostIndex = location.href.indexOf(location.host)+location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}

function click_ok(){
	var startDate = $("#s_startDate").val().replace("-","/");
	var endDate = $("#s_endDate").val().replace("-","/");
	var start = new Date(startDate);
	var end = new Date(endDate);
	
	if($("#s_title").val() == "" || $("#s_title").val().length < 5 || $("#s_title").val().length > 40){
		alert("제목을 입력해주세요. [5글자 이상 40글자 이하]");
		$("#s_title").focus();
		return false;
	}else if($("#s_startDate").val() == "" || $("#s_endDate").val() == "" || start > end){
		alert("날짜를 올바르게 선택해주세요. [종료날짜보다 시작날짜가 작아야 합니다.]");
		return false;
	}else if($("#s_content").val() == "" || $("#s_content").val().length < 10 || $("#s_content").val().length > 1024){
		alert("내용을 입력해주세요. [10글자 이상 1024글자 이하]");
		$("#s_content").focus();
		return false;
	}
	var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
	var result = confirm("일정 추가하시겠습니까?");
	
	if(result){
		$.ajax({
			data : scheduleData,
			url : $("#projectName").val()+"/schedule/addSchedule",
			type : "POST",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				alert("일정 등록이 완료되었습니다.");
				opener.parent.location.reload();
				window.close();
			},
			error:function(){
					alert("일정 등록에 실패하였습니다.");
					opener.parent.location.reload();
				}
		});
	}
};

