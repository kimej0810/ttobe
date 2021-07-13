$(document).ready(function(){
	$("#e_draftDate, #e_startDay").datetimepicker({
		disabledWeekDays :[0, 6],
		i18n:{
			de:{
				months:[
					'Januar','Februar','März','April',
					'Mai','Juni','Juli','August',
					'September','Oktober','November','Dezember',
				],
				dayOfWeek:[
					"So.", "Mo", "Di", "Mi", 
					"Do", "Fr", "Sa.",
				]
			}
		},
		timepicker:false,
		format:'Y-m-d'
	});
	jQuery.datetimepicker.setLocale('kr');
});

jQuery.fn.serializeObject = function(){
	var o = {};
	var a = this.serializeArray();
	$.each(a, function(){
		var name = $.trim(this.name),
			value = $.trim(this.value);
		
		if(o[name]){
			if(!o[name].push){
				o[name] = [o[name]];
			}
			o[name].push(value||'');
		}else{
			o[name] = value || '';
		}
	});
	return o;
};