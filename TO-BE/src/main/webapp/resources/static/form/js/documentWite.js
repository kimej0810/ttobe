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
	$("#e_send").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			endD = $("#e_send").val();
			
			if(startD > endD){
				alert("시행일자를 올바르게 선택해주세요.");
				$("#e_send").val(startD);
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
function click_ok(){
	var startDay = $("#e_startDay").val().replace("-","/");
	var endDay = $("#e_send").val().replace("-","/");
	var start = new Date(startDay);
	var end = new Date(endDay);
	

	if($("#e_draftDate").val() == "" || $("#e_startDay").val() == "" || $("#e_send").val() == "" || start>end){
		alert("날짜를 올바르게 선택해주세요. [시행일자보다 기안일자가 작아야 합니다.]");
		return false;
	}else if($("#e_con").val() == "" || $("#e_con").val().length < 2 || $("#e_con").val().length > 10){
		alert("합의부서을 입력해주세요. [2글자 이상 10글자 이하]");
		$("#e_con").focus();
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
