<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>10. 파일업로드 Ajax 방식 요청 처리</h1>
	<hr>
	
	<p>Ajax 방식으로 전달할 파일 요소값을 스프링 MVC가 지원하는 MultipartFile 매개변수로 처리한다.</p>
	<div>
		<input type="file" id="inputFile"/> <br/>
		<hr/>
		<img id="preview" />
	</div>
	
	
</body>
<script type="text/javascript">
$(function(){
	var inputFile = $("#inputFile");
	
	inputFile.on("change", function(event){
		console.log("Change Event...!");
		var files = event.target.files; // change 동작시 files를 통해 모든 파일을 배열로 가져온다
		var file = files[0];	// 선택한 파일을 꺼낸다.
		
		console.log(file);
		
		// formData는 key/value 형식으로 데이터가 저장된다.
		// dataType : 응답(response)데이터를 내보낼 때 보내줄 데이터 타입
		// proccessData : 데이터 파라미터를 data라는 속성으로 넣는데, 제이쿼리 내부적으로 쿼리스트링을구성합니다.
		//				  파일 전송의 경우 쿼리스트링을 사용하지 않으므놀 해당 설정을 false로 비활성화 한다.
		// contentType : Content-Type을 설정 시, 사용하는데 해당 설정의 기본값은
		// 				 'application/x-www-form-urlencoded; charset=utf-8'입니다.
		//				  하여 기본값으로 나가지않고 'multipart/form-data'로 나갈 수 있도록 설정을 false로 비활성화합니다.
		//				 request 요청에서 Content-Type을 확인해보면 'multipart/form-data;
		//				 boundary====WebKitFormBoundary[HashKey]'와 같은 값으로 전송된 것을 확인할 수 있습니다.
		if (isImageFile(file)) {	// 이미지 파일 일때
			// 비동기 처리시, 파일 데이터를 전송할 때에는 formData()를 이용하여 데이터를 전송한다.
			var formData = new FormData();
			formData.append("file", file); // formData에 file의 키와 데이터를 저장
			
			$.ajax({
				url : "/ajax/uploadAjax",
				type : "post",
				data : formData, // 파일이 포함된 데이터를 보낼때는 formData를 사용(모든 데이터는 formData에 설정해서 전달)
				dataType : "text", // 서버에서 produce 속성과 일치한다
				processData : false, // 쿼리스트링으로 구성하지 않은 바디에 정보를 태워 보내기 때문에 설정을 false로 꺼버린다.
				contentType : false, // 보내는 정보가 json이 아니기 때문에 설정을 false로 꺼버린다.
				success : function(data){
					alert(data);
					if (data === "UPLOAD SUCCESS") {
						var file = event.target.files[0];	// file은 비동기요청시 위에 초기화한 file이 이미 지나가고 없기 때문에 초기화를 다시한다
						var reader = new FileReader();
						reader.onload = function(e){ // 걍 이미지 파일 base64로 인코딩해서 넣는 방법임 외우셈
							$("#preview").attr("src", e.target.result); // 발생한 데이터는 e.target.result가 가지고 있다.
						}
						reader.readAsDataURL(file); // base64형태로 만들고 onload메서드를 발생시킴
					} // /if
				}
			});	// /$.ajax({});
		} else {	// 이미지 파일이 아닐 때
			alert("이미지 파일을 선택해주세요!");
			inputFile.val(null);
		} // /if-else
		
	}); // /inputFile.on("change", function(){});
	
	
	
}); // /$(function(){});

// Change 이벤트가 발생할 때 선택된 파일이 이미지 인지 검증
function isImageFile(file){
	// .pop() : 배열의 마지막 요소 꺼내기
	var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 꺼내온다.
	// 확장자 중 이미지에 해당하는 확장자가 아닌경우 포함되어 있는 문자가 없으니까 -1(false)가 리턴
	// 확장자중 이미지 확장자가 포함되어 있다면 0보다 큰 수 일테니 true가 리턴
	return ($.inArray(ext, ["jpg", "jpeg", "png", "gif"]) === -1) ? false : true;
}

</script>
</html>