<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' integrity='sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN' crossorigin='anonymous'>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js'></script>
</head>
<body>
	<!-- 
		아이디찾기, 비밀번호찾기를 진행해주세요.
		
		# 아이디찾기
		1) 이름, 이메일을 입력 후, 아이디 찾기 버튼을 클릭 시 비동기 통신을 활용해 아이디를 출력해주세요.
			> 조회된 아이디 정보는 아이디 찾기 안에 있는 card-body 클래스명을 가진 div안에 출력해주세요.
			> 존재하지 않는 정보라면 "존재하지 않습니다"를 출력해주세요.
			
		# 비밀번호 찾기
		1) 아이디, 이름, 이메일을 입력 후, 비밀번호 찾기 버튼을 클릭 시 비동기 통신을 활용해 비밀번호를 출력해주세요.
			> 조회된 비밀번호 정보는 비밀번호 찾기 안에 있는 card-body 클래스명을 가진 div안에 출력해주세요.
			> 존재하지 않는 정보라면 "존재하지 않습니다"를 출력해주세요.	
	
	 -->
	<div class="row">
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					아이디 찾기
				</div>
				<div class="card-body">
					<form action="" method="post">
						<div class="input-group mb-3">
							<input class="form-control" type="text" name="memName" id="id_memName" placeholder="이름을 입력해주세요."/>
						</div>
						<div class="input-group mb-3">
							<input class="form-control" type="text" name="memEmail" id="id_memEmail" placeholder="이메일을 입력해주세요."/>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button type="button" id="findIdBtn" class="btn btn-primary mb-2">아이디찾기</button>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					비밀번호 찾기
				</div>
				<div class="card-body">
					<form action="" method="post">
						<div class="input-group mb-3">
							<input class="form-control" type="text" name="memId" id="pw_memId" placeholder="아이디를 입력해주세요."/>
						</div>
						<div class="input-group mb-3">
							<input class="form-control" type="text" name="memName" id="pw_memName" placeholder="이름을 입력해주세요."/>
						</div>
						<div class="input-group mb-3">
							<input class="form-control" type="text" name="memEmail" id="pw_memEmail" placeholder="이메일을 입력해주세요."/>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button type="button" id="findPasswordBtn" class="btn btn-primary mb-2">비밀번호찾기</button>
				</div>
			</div>
		</div>
		<div class="col-md-6 mb-2">
			<button type="button" onclick="javascript:history.back()" class="btn btn-primary mb-2">뒤로가기</button>
		</div>
	</div>
</body>
<script type="text/javascript">
// 아이디
$("#findIdBtn").on("click", function(){
	var id_memName = $("#id_memName").val();
	var id_memEmail = $("#id_memEmail").val();
	if (id_memName === "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	if (id_memEmail === "") {
		alert("이메일을 입력해주세요.");
		return;
	}
	$("#idForm").submit();
	
	formData = {
		memName : id_memName,
		memEmail : id_memEmail
	}
	
	$.ajax({
		url : "/test03/findId",
		type : "post",
		data : JSON.stringify(formData),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			if (res === "") {
				alert("존재하지 않습니다.");
			} else {
				$(".card-body").eq(0).html(res);
			}
		}
	});
	
});

// 비밀번호
$("#findPasswordBtn").on("click", function(){
	var pw_memId = $("#pw_memId").val();
	var pw_memName = $("#pw_memName").val();
	var pw_memEmail = $("#pw_memEmail").val();
	if (pw_memId === "") {
		alert("아이디를 입력해주세요.");
		return;
	}
	if (pw_memName === "") {
		alert("이름을 입력해주세요.");
		return;
	}
	if (pw_memEmail === "") {
		alert("이메일을 입력해주세요.");
		return;
	}
	$("#pwForm").submit();

	formData = {
		memId : pw_memId,
		memName : pw_memName,
		memEmail : pw_memEmail
	}
	
	$.ajax({
		url : "/test03/findPassword",
		type : "post",
		data : JSON.stringify(formData),
		contentType : "application/json;charset=utf-8",
		success : function(res){
			console.log(res);
			if (res === "") {
				alert("존재하지 않습니다.");
			} else {
				$(".card-body").eq(1).html(res);
			}
		}
	});
	
});
</script>
</html>