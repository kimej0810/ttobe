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
		},
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
		},
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
function click_ok(){
	var draftDate = $("#e_draftDate").val().replace("-","/");
	var startDay = $("#e_startDay").val().replace("-","/");
	var draft = new Date(draftDate);
	var start = new Date(startDay);
	
	if($("#e_rule").val() == "" || $("#e_rule").val().length < 2 || $("#e_rule").val().length > 10){
		alert("유형을 입력해주세요. [2글자 이상 10글자 이하]"); 
		$("#e_rule").focus();
		return false;
	}else if($("#e_draftDate").val() == "" || $("#e_startDay").val() == "" || draft>start){
		alert("날짜를 올바르게 선택해주세요. [시행일자보다 기안일자가 작아야 합니다.]");
		return false;
	}else if($("#e_con").val() == "" || $("#e_con").val().length < 2 || $("#e_con").val().length > 10){
		alert("합의부서을 입력해주세요. [2글자 이상 10글자 이하]");
		$("#e_con").focus();
		return false;
	}else if($("#e_send").val() == "" || $("#e_send").val().length < 2 || $("#e_send").val().length > 10){
		alert("수신자를 입력해주세요. [2글자 이상 10글자 이하]");
		$("#e_send").focus();
		return false;
	}else if($("#e_textTitle").val() == "" || $("#e_textTitle").val().length < 10 || $("#e_textTitle").val().length > 40){
		alert("제목을 입력해주세요. [10글자 이상 40글자 이하]");
		$("#e_textTitle").focus();
		return false;
	}else if($("#e_textContent").val() == "" || $("#e_textContent").val().length < 30 || $("#e_textContent").val().length > 1024){
		alert("내용을 입력해주세요. [30글자 이상 1024글자 이하]");
		$("#e_textContent").focus();
		return false;
	}
	var documentWiteData = JSON.stringify($("form#documentWiteData").serializeObject());
	var result = confirm("결제요청 하시겠습니까?");
	
	if(result){
		
		$.ajax({
			data: documentWiteData,
			url:"/approval/addDocumentWite",
			type:'POST',
			dataType:'JSON',
			contentType : "application/json; charset=UTF-8",
			success: function(data){
				alert("결제요청이 완료되었습니다.");
				opener.parent.location.reload();
				window.close();
			}
		});
	}
	
};
