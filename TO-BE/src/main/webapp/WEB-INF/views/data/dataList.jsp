<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/static/css/bootstrap.min.css"/>"
	rel='stylesheet' />
	<script type="text/javascript" src="<c:url value="/resources/static/js/jquery-3.6.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
</head>
<body>
	<button type="button" data-toggle="modal" data-target="#myModal">Open Modal</button>
	<button type="button" id="downBtn">다운로드</button>
	<select>
		<option>작성자</option>
		<option>파일명</option>
	</select>
	<input type="text">
	<button type="button">검색</button>
	<table border="1">
		<c:forEach items="${dataList}" var="data">
			<tr>
				<td><input type="checkbox" value="${data.didx}"></td>
				<td>${data.d_title}</td>
				<td>${data.tidx}</td>
				<td>${data.d_writedate}</td>
				<td>${data.d_download}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">업로드</h4>
        </div>
        <div class="modal-body">
        	<form action="/data/transport" method="post" enctype="multipart/form-data">
        		<input type="text" name="didx" value="1">
        		<input type="text" name="d_title" value="safsdf">
        		<input type="text" name="d_writedate" value="2021-06-16">
        		<input type="text" name="d_download" value="0">
        		<input type="text" name="delyn" value="N">
        		<input type="text" name="tidx" value="22">
        		<input type="file" name="file">
        		<input type="submit" value="전송" style='display:none;' id="fileFormBtn">
        	</form>
        </div>
        <div class="modal-footer">
           <label for="fileFormBtn" class="btn btn-default">추가</label>
        </div>
      </div>
    </div>
  </div>
  <script>
	  $(document).on("click", "#downBtn", function(){
		 var valArray = [];
		 $("input[type=checkbox]:checked").each(function(){
		 	var val = $(this).val(); 
		 	valArray.push(val);
		 });
		 
		 for(var i=0; i<valArray.length; i++){
			 alert(valArray[i]);
		 }
		 
		 $.ajax({
				type:"post",
				url:"/data/download",
				data:{valArray:valArray},
				dataType: "json",
				error:function(request,status,error){
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				},
				success:function(data){
					console.log("됐음");
				}
			});
	  });
  </script>
</body>
</html>