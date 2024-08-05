<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' integrity='sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN' crossorigin='anonymous'>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js'></script>

<script type="text/javascript">
alert("<c:out value='${msg}'/>");
</script>

</head>
<body>
	<!-- 
		1) 로그인에 성공한 학생 정보를 아래에 출력해주세요!
		2) 로그인페이지로 버튼을 클릭 시 로그인 페이지로 이동해주세요.
		3) 파일 선택을 통해서 이미지 파일을 선택 후, 프로필 이미지를 설정할 수 있게 해주세요.
		  > 프로필 이미지가 바뀌면 됩니다. (서버 업로드 할 필요 없음)
	 -->
	<div class="row">
		<c:forEach items="${list }" var="member">
<!-- 			<div class="col-md-4"> -->
			<div class="col-sm-3" style="margin: 30px;">
				<c:if test="${member.memId ne vo.memId }">
					<div class="card">
				</c:if>
				<c:if test="${member.memId eq vo.memId }">
					<div class="card" style="background-color: red;">
				</c:if>
					<div class="card-header">
						${member.memName }님! 환영합니다!
					</div>
					<div class="card-body">
						<table class="table table-bordered">
							<tr>
								<td colspan="2">
									<img id="prev" src="https://lh4.googleusercontent.com/proxy/yuhEMCPI6rFy7LulnQK68A-hRwZytbhAkvzkACazt24gH8gGfqEFsOS2bBCDIXe9WgF0d51SlNcSyi8vqxBwA0cUW6P6DUSv28JovHIbosJuj2C3JYlYBILWrh0MInjHj8wgYET8H6hynOI8aJ7B-0MQae3ALnCmTSQuLGZqwdiEujP-WkPcHvR_MRnlFhy5XUVnhO9fRdg" style="width:100%;"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="file" id="imageFile" class="change_file"/>
								</td>
							</tr>
							<tr>
								<td>아이디</td>
								<td>${member.memId }</td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td>${member.memPw }</td>
							</tr>
							<tr>
								<td>이름</td>
								<td>${member.memName }</td>
							</tr>
							<tr>
								<td>이메일</td>
								<td>${member.memEmail }</td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td>${member.memPhone }</td>
							</tr>
						</table>
					</div>
					<div class="card-footer">
						<button type="button" onclick="javascript:location.href='/test03/login.do'" class="btn btn-primary mb-2">로그인페이지로></button>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
<script type="text/javascript">

$(function(){
	var change_files = $(".change_file");
	
	change_files.on("change", function(event){
		console.log("Change Event...!");
// 		var image = $(this).closest("img");
		var image = $(this).closest(".card-body").find('img');
		console.log("@@" + image.attr("src"));
		var files = event.target.files; 
		var file = files[0];	
		
		console.log(file);
		
		if (isImageFile(file)) {	
			var formData = new FormData();
			formData.append("file", file); 
			
			$.ajax({
				url : "/test03/uploadImg",
				type : "post",
				data : formData,
				dataType : "text", 
				processData : false,
				contentType : false, 
				success : function(data){
					alert(data);
					if (data === "UPLOAD SUCCESS") {
						var file = event.target.files[0];
						var reader = new FileReader();
						reader.onload = function(e){ 
							image.attr("src", e.target.result); 
						}
						reader.readAsDataURL(file); 
					}
				}
			});	
		} else {
			alert("이미지 파일을 선택해주세요!");
			$(this).val(null);
		}
	});
		
		
});
	
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();	
	return ($.inArray(ext, ["jpg", "jpeg", "png", "gif"]) === -1) ? false : true;
}
</script>
</html>