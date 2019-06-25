<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>UPLOAD Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple"/>
	</div>
	
	<button id="uploadBtn">Upload</button>
		
		
	<script>
	
	$(document).ready(function() {
		$("#uploadBtn").on("click", function(e) {
		
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			console.log(files);
			
			for (var i = 0; i < files.length; i++) {
				formData.append("uploadFile", files[i]);
			}			
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				success : function(result) {
					alert("UPLOAD SUCCESS");
				}
			
			});
			
		});
	});
	
	</script>		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
</body>
</html>