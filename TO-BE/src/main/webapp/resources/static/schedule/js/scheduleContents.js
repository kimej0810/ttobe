$(document).ready(function(){
	$("#s_startDate, #s_endDate").datetimepicker({
		disabledWeekDays :[0, 6]
	});
	jQuery.datetimepicker.setLocale('kr');
})
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
