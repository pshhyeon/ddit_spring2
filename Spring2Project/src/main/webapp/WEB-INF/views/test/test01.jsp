<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Insert title here</title>
<script
	src='https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js'></script>
<link rel='stylesheet'
	href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css'
	integrity='sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN'
	crossorigin='anonymous'>
</head>
<body>
	<select class='form-control' id='selectImgType'>
		<option value='all'>전체</option>
		<option value='jpg'>JPG</option>
		<option value='png'>PNG</option>
		<option value='gif'>GIF</option>
	</select>

	<hr />
	<div class="row" id="imgList" style="margin: 10px;">
		<c:choose>
			<c:when test="${list.size() == 0}">
				<p>조회된 이미지가 없습니다</p>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list}" var="item">
					<div class="col-sm-3" style="margin-bottom: 5px;">
						<div class="card" style="text-align: center;">
							<div class="card-header">
								${item.fileName }
							</div>
							<div class="card-body">
								<a href="/test/show_img/${item.fileName }">
									<img style="width: 200px;" 
									src="../resources/image/${item.fileName }"
									data-filename="${item.fileName }">
								</a>
							</div>
							<div class="card-footer">
								<a href="/test/download_img/${item.fileName }" class="btn btn-primary btn-sm">다운로드</a>
							</div>
						</div>
					</div>
					
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</body>
<script type="text/javascript">
$("#selectImgType").on("change", function() {
	var type = $(this).val();
	
	$.ajax({
		url : "/test_/test01/" + type,
		method : 'get',
		success : function (res) {
			console.log(type);
			var list = res;
			var code = "";
			if (list.length == 0) {
				code += `<p>조회된 이미지가 없습니다</p>`;	
			} else {
				list.forEach (function (file, index) {
					code += `
						<div class="col-sm-3" style="margin-bottom: 5px;">
							<div class="card" style="text-align: center;">
								<div class="card-header">
									\${file.fileName}
								</div>
								<div class="card-body">
									<a href="/test/show_img/\${file.fileName}">
										<img style="width: 200px;" 
										src="../resources/image/\${file.fileName}"
										data-filename="\${file.fileName}">
									</a>
								</div>
								<div class="card-footer">
									<a href='/test/download_img/\${file.fileName}' class="btn btn-primary btn-sm">다운로드</a>
								</div>
							</div>
						</div>
					  `;
				});
			}
			
			
			$('#imgList').html(code);
	    }
	});
	
});
</script>
</html>

