<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
			댓글창
			<input type="text" name="r_content" id="newR_content">
		</div>
		<button id="replyAddBtn">작성</button>
	</div>
	
	<ul id="replies">
	</ul>
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	<script>
		$('#replyAddBtn').on('click', function(){
			var r_content = $('#newR_content').val();
			
			$.ajax({
				type:'post',
				url:'/sample',
				header:{
					"Context-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType:'text',
				data:JSON.stringify({
					r_content:r_content,
					r_writedate:'2021/06/10',
					delyn:'N',
					tidx:1,
					bidx:10
				}),
				success:function(result){
					if(result=='SUCCESS'){
						alert("등록됨");
						getAllList();
					}
				}
			
			})
		});
		
		function getAllList(){
			
			$.getJSON("/sample/all/"+bidx, function(data){
				
				var str="";
				console.log(data.length);
				
				$(data).each(
					function(){
						str +="<li data-rno='"+this.ridx+"' class='replyLi'>"
							+ this.ridx + ":" + this.r_content
							+ "</li>";
					});
				$("#replies").html(str);
			});
		}
	</script>
</body>
</html>