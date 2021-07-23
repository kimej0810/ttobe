	$(document).ready(function(){
		$("#t_department").on("change", function(){
			$.ajax({
				url:$("#domain").val()+"/member/buseolist",
				data: $("#t_department").serialize(),
				dataType:"json",
				success:function(searchDepartmentMember){
					var solist = "";
					if(searchDepartmentMember.length>0){
						for(var i=0; i<searchDepartmentMember.length;i++){
							solist += "<div class='info'>";
							solist += "<input type='hidden' id='tidx' name='tidx' value='"+searchDepartmentMember[i].tidx+"'>";
							if(searchDepartmentMember[i].f_stored_file_name!=null){
							solist += "<img class='listProfile' src='<c:url value='/resources/static/profile/"+searchDepartmentMember[i].f_stored_file_name+"'/>'>";
							}else{
								solist += "<img src='<c:url value='/resources/static/profile/notprofile.jpg'/>' class='listProfile'>";
							}
							solist += " <span>";
							solist += searchDepartmentMember[i].t_name;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_department;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_position;
							solist += "</span>";
							solist += " <span>";
							solist += searchDepartmentMember[i].t_email;
							solist += "</span>";
							solist += "</div>";
						}
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}else{
						solist += "<span>";
						solist += "해당부서는 사원이 없습니다.";
						solist += "</span>";
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}
				}
			});
		});
		
		$(document).on("click",".info", function(){
			$.ajax({
				url:$("#domain").val()+"/member/saoneinfo",
				data: $(this).children("#tidx").serialize(),
				dataType:"json",
				success:function(selectOneMember){
					var solist = "";
					solist += "<tr><td rowspan='4' scope='col' width='30%' style='text-align:center;'>";
					if(selectOneMember.f_stored_file_name!=null){
						solist += "<img style='width:150px;height:100px;border:1px solid lightgray;' src='<c:url value='/resources/static/profile/"+selectOneMember.f_stored_file_name+"'/>'></td>";	
					}else{
						solist += "<img src='<c:url value='/resources/static/profile/notprofile.jpg'/>' class='listProfile' style='width:150px;height:100px;border:lightgray;'>";	
					}
					solist += "<th width='20%' style='text-align:center;'>이름</th><td>";
					solist += selectOneMember.t_name;
					solist += "</td></tr><tr><th style='text-align:center;'>부서</th><td>";
					solist += selectOneMember.t_department;
					solist += "</td></tr><tr><th style='text-align:center;'>직급</th><td>";
					solist += selectOneMember.t_position;
					solist += "</td></tr><tr><th style='text-align:center;'>이메일</th><td>";
					solist += selectOneMember.t_email;
					solist += "</td></tr><tr><th style='text-align:center;'>일반주소</th><td colspan='2'>";
					solist += selectOneMember.t_addr_general;
					solist += "</td></tr><tr><th style='text-align:center;'>상세주소</th><td colspan='2'>";
					solist += selectOneMember.t_addr_detail;
					solist += "</td></tr>";
					$("#tbodyx").html(solist);
				}
			});
		});
		$(document).on("click","#nameSearchBtn",function(){
			$.ajax({
				url:$("#domain").val()+"/member/search",
				data:"t_department="+$('#t_department').serialize()+"&t_name="+$('#searchType').serialize(),
				dataType:"json",
				success:function(searchMember){
					var solist = "";
					if(searchMember.length>0){
						for(var i=0; i<searchMember.length;i++){
							solist += "<div class='info'>";
							solist += "<input type='hidden' id='tidx' name='tidx' value='"+searchMember[i].tidx+"'>";
							if(searchMember[i].f_stored_file_name!=null){
								solist += "<img  class='listProfile' src='<c:url value='/resources/static/profile/"+searchMember[i].f_stored_file_name+"'/>'>";	
							}else{
								solist += "<img src='<c:url value='/resources/static/profile/notprofile.jpg'/>' class='listProfile'>";
							}
							solist += " <span>";
							solist += searchMember[i].t_name;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_department;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_position;
							solist += "</span>";
							solist += " <span>";
							solist += searchMember[i].t_email;
							solist += "</span>";
							solist += "</div>";
						}
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}else{
						solist += "<span>";
						solist += "해당부서는 사원이 없습니다.";
						solist += "</span>";
						$("#tbodyx").html("<tr></tr>");
						$(".saone").html(solist);
					}
				}
			});
		});
	});