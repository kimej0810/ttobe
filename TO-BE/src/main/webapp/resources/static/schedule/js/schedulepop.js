
//add schedule
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

function click_ok(){

	var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
	var result = confirm("일정 추가하시겠습니까?");
	
	if(result){
		$.ajax({
			data : scheduleData,
			url : "/schedule/addSchedule",
			type : "POST",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				var result
				opener.parent.location.reload();
				window.close();
			}
		});
	}
};

