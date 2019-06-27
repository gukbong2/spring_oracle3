<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">

<style>
	.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>



<title>Insert title here</title>
</head>
<body>
	<h1>UPLOAD Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple"/>
	</div>
	
	
	<button id="uploadBtn">Upload</button>
		
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>	
		
		
<script>
	
	$(document).ready(function() {
		
		
		/* $("#uploadBtn").on("click", function(e) {
		
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
			
		}); */
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize) {
			
			if(fileSize >= maxSize) {
				alert("파일 사이즈가 초과되었습니다.");
				return false;
			}
			
			if(regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("#uploadBtn").on("click", function(e) {
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			console.log(files);
			
			for (var i = 0; i < files.length; i++) {
				
				if(!checkExtension(files[i].name, files[i].size) ) {
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "post",
				dataType : "json",
				success : function(result) {
					console.log(result);
					
					showUploadedFile(result);
					
					$(".uploadDiv").html(cloneObj.html());
					
				}
			});
		});
		
		
		var cloneObj = $(".uploadDiv").clone();
		
		$("#uploadBtn").on("click", function(e) {
			var formData = new FormData();
		});
		
		
		
		var uploadResult = $(".uploadResult ul");
		
		
		
		
		function showUploadedFile(uploadResultArr) {
				
				var str = "";
				
				$(uploadResultArr).each(function(i, obj) {
				
					console.log("name : " + obj.fileName);
					console.log("uuid : " + obj.uuid);
					console.log("uploadPath : " + obj.uploadPath);
					console.log("image : "  + obj.image);
					
					if(!obj.fileName) {
						str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
					} else {
						//str += "<li>" + obj.fileName + "</li>";
						
						
						var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
						
						console.log("fileCallPath : " + fileCallPath);
						
						str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
						
					}
					
					
				});
				
				uploadResult.append(str);
		} 
		 
		
		
		
		
		
		
		
		
		
		
	});
	
</script>		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
		
</body>
</html>