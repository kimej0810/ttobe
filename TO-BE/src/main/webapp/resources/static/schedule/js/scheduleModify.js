$(document).ready(function(){
	$("#s_startDate").datetimepicker({
		dateFormat:"yyyy-mm-dd hh:mm",
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			if($("#s_startDate").val() > $("#s_endDate").val()){
				alert("시작일을 올바르게 선택해주세요.");
				$("#s_startDate").val($("#s_endDate").val());
			}
		},
		disabledWeekDays :[0, 6]
	});
	$("#s_endDate").datetimepicker({
		dateFormat:"yyyy-mm-dd hh:mm",
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			if($("#s_startDate").val() > $("#s_endDate").val()){
				alert("시작일을 올바르게 선택해주세요.");
				$("#s_endDate").val($("#s_startDate").val());
			}
		},
		disabledWeekDays :[0, 6]
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
