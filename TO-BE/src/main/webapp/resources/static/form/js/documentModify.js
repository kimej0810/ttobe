$(document).ready(function(){
	$("#e_draftDate").datetimepicker({
		disabledWeekDays :[0, 6],
		/*dateFormat:"yyyy-mm-dd hh:mm",*/
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			if($("#e_draftDate").val() > $("#e_startDay").val()){
				alert("기안일자를 올바르게 선택해주세요.");
				$("#e_draftDate").val($("#e_startDay").val());
			}
		}
		/*i18n:{
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
		}
		timepicker:false,
		format:'Y-m-d hh:mm'*/
	});
	$("#e_startDay").datetimepicker({
		disabledWeekDays :[0, 6],
		/*dateFormat:"yyyy-mm-dd hh:mm",*/
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			if($("#e_draftDate").val() > $("#e_startDay").val()){
				alert("시행일자를 올바르게 선택해주세요.");
				$("#e_startDay").val($("#e_draftDate").val());
			}
		}
		/*i18n:{
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
		}
		timepicker:false,
		format:'Y-m-d hh:mm'*/
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
