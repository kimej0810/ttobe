$(document).ready(function(){
	var startD;
	var endD;
	$("#e_draftDate").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h'
	});
	$("#e_startDay").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			startD = $("#e_startDay").val();
			if(startD > endD){
				alert("기안일자를 올바르게 선택해주세요.");
				$("#e_startDay").val(endD);
			}
		} 
	});
	$("#e_endDay").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			endD = $("#e_endDay").val();
			
			if(startD > endD){
				alert("시행일자를 올바르게 선택해주세요.");
				$("#e_endDay").val(startD);
			}
		}
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
