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
