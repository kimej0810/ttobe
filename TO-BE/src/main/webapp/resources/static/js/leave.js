	$(document).ready(function(){
		$(document).on("focusout","#friend_phone",function(){
			var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
			if(!regExp.test($("input[id='friend_phone']").val())){
				$("#friend_phone").attr("title","형식이 맞지 않습니다. [예 : 010-0000-0000]");
				$("#friend_phone").tooltip({
						animation: true,
						container:"#tootip_area2",
						delay:{show:50,hide:10},
						html:false,
						template:"<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>",
						trigger:'manual'
					});
				$("#friend_phone").tooltip('show');
				$("#friend_phone").val("");
				$("#friend_phone").focus();
			}else{
				$("#friend_phone").tooltip('hide');
			}
		});
		var startD;
		var endD;
		$(document).on("click","#startD",function(){
			$("#startD").datetimepicker({
				dateFormat:"yyyy-MM-dd hh:mm",
				minDate:'+1d',
				disabledWeekDays :[0, 6],
				onChangeDateTime:function(){
					startD = $("#startD").val();
					/*$("#a_useddays").val("");*/
					if($("#endD").val()!=null){
						var sTime = new Date(startD);
						var eTime = new Date(endD);
						var resultD = eTime - sTime;
						var resultT = resultD/60/60/1000/24;
						var resultDa = 0.0;
						if(resultT <= 1 && resultT > 0.5){
							resultDa = 1;
						}else if(resultT <= 0.5){
							resultDa = 1/2;
						}else if(resultT > 1){
							resultDa = Math.ceil(resultT);
						}
						$("#a_useddays").val(resultDa);
					}
					if(startD > endD){
						alert("시작일 선택이 잘못되었습니다.");
						$("#startD").val(endD);
					}
				}
			});
			jQuery.datetimepicker.setLocale('kr');
		});
		$(document).on("click","#endD",function(){
			$("#endD").datetimepicker({
				dateFormat:"yyyy-MM-dd hh:mm",
				minDate:'+1d',
				disabledWeekDays :[0, 6],
				onChangeDateTime:function(){
					endD = $("#endD").val();
					var sTime = new Date(startD);
					var eTime = new Date(endD);
					var resultD = eTime - sTime;
					var resultT = resultD/60/60/1000/24;
					var resultDa = 0.0;
					if(resultT <= 1 && resultT > 0.5){
						resultDa = 1;
					}else if(resultT <= 0.5){
						resultDa = 1/2;
					}else if(resultT > 1){
						resultDa = Math.ceil(resultT);
					}
					
					$("#a_useddays").val(resultDa);
					if(endD != null){
						if(startD > endD){
							$("#endD").val(startD);
						}
					}
				}
			});
			jQuery.datetimepicker.setLocale('kr');
		});
		$("#subBtn").on("click",function(){
			if($("#teamleader").val() =="no" || $("#departmenthead").val() =="no" || $("#sectionhead").val() =="no" || $("#leader").val() =="no"){
				alert("결재 담당을 선택해주세요.");
				return;
			}else if($("#startD").val()==null || $("#endD").val()==null){
				alert("원하는 날짜를 선택해주세요.");
				return;
			}else if($("#a_type").val()==null || $("#a_type").val()=="null"){
				alert("휴가 종류를 선택해주세요.");
				return;
			}else if($("#a_useddays").val()==null){
				alert("신청 일수를 작성해주세요.");
				return;
			}else if($("#friend_phone").val()==null || $("#friend_name").val() == null){
				alert("비상연락처와 그 관계를 작성해주세요.");
				return;
			}else if($("#e_textcontent").val()==null || $("#e_texttitle").val()==null){
				alert("제목과 내용은 필수입니다.");
				return;
			}else if($("#t_name").val()!=$("#t_name2").val()){
				$("#t_name2").val("");
				alert("신청자와 이름이 다릅니다.");
				return;
			}else if($("#t_position").val()=="팀장"){
				$("#status").val("0300");
			}else if($("#t_position").val()=="과장"){
				$("#status").val("0030");
			}else if($("#t_position").val()=="부장"){
				$("#status").val("0003");
			}else{
				$("#status").val("3000");
			}
			$("#e_type").val($("#a_type").val());
			$("#a_startdate").val($("#startD").val());
			var result = $("form[name=frm]").serialize();
			$.ajax({
				url: "/leave/writeAction",
				data:result,
				type:"POST",
				dataType: "json",
				success:function(e){
					alert("신청이 완료되었습니다.");
					opener.parent.location.reload();
					window.close();
				}
			});
		});
	});