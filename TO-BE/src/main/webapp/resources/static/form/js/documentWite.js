$(document).ready(function(){
	var startD;
	var endD;
	$("#e_startDay").datetimepicker({
		disabledWeekDays :[0, 6],
		minDate:'+1d',
		minTime:'+1h',
		onChangeDateTime:function(){
			startD = $("#e_startDay").val();
			if(startD > endD){
				alert("시행일자를 올바르게 선택해주세요.");
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
				alert("종료일자를 올바르게 선택해주세요.");
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

function getContextPath(){
	var hostIndex = location.href.indexOf(location.host)+location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}

function click_ok(){
	var startDay = $("#e_startDay").val().replace("-","/");
	var endDay = $("#e_endDay").val().replace("-","/");
	var start = new Date(startDay);
	var end = new Date(endDay);
	

	if($("#e_draftDate").val() == "" || $("#e_startDay").val() == "" || $("#e_endDay").val() == "" || start>end){
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
	Swal.fire({
		title:"결재 요청",
		text:"결재요청 하시겠습니까?",
		icon:"question",
		showCancelButton:true,
		confirmButtonText:"확인",
		cancelButtonText:"취소"
	}).then(result => {
		var draftLetterData = JSON.stringify($('form#documentWiteData').serializeObject());
		
		if(result.isConfirmed){
			$.ajax({
				data: draftLetterData,
				url: $("#projectName").val()+"/approval/addDocumentWite",
				type:'POST',
				dataType:'JSON',
				contentType : "application/json; charset=UTF-8",
				success: function(data){
					Swal.fire("결재요청 완료","결재요청이 완료되었습니다.","success").then(result => {
						opener.parent.location.reload();
						window.opener.location.href= $("#projectName").val()+"/approval/documentListMain" + "?searchWord=나의 결재문서";
						window.close();	
					});
				},
				error:function(){
					Swal.fire("결재 요청 실패","결재요청이 실패되였습니다","error").then(result => {
						opener.parent.location.reload();
					});
				}
			});
		}
	});
}
