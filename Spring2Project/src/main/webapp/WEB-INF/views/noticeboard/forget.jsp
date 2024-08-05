<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="">
	<div class="card card-outline card-primary">
		<div class="card-header text-center">
			<p class="h4">
				<b>아이디찾기</b>
			</p>
		</div>
		<div class="card-body">
			<p class="login-box-msg">아이디 찾기는 이메일, 이름을 입력하여 찾을 수 있습니다.</p>
			<form action="" method="post">
				<div class="input-group mb-3">
					<input type="text" id="memEmail1" name="memEmail" class="form-control" placeholder="이메일을 입력해주세요.">
				</div>
				<div class="input-group mb-3">
					<input type="text" id="memName1" name="memName" class="form-control" placeholder="이름을 입력해주세요.">
				</div>
				<div class="input-group mb-3">
					<p>
						회원님의 아이디는 <font id="resultId" style="font: bold;" color="blue">-</font> 입니다.
					</p>
				</div>
				<div class="row">
					<div class="col-12">
						<button type="button" id="idFindBtn" class="btn btn-primary btn-block">아이디찾기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<br />
	<div class="card card-outline card-primary">
		<div class="card-header text-center">
			<p href="" class="h4">
				<b>비밀번호찾기</b>
			</p>
		</div>
		<div class="card-body">
			<p class="login-box-msg">비밀번호 찾기는 아이디, 이메일, 이름을 입력하여 찾을 수 있습니다.</p>
			<form action="/notice/pwForget.do" id="pwForm" method="post">
				<div class="input-group mb-3">
					<input type="text" id="memId" name="memId" class="form-control" placeholder="아이디를 입력해주세요.">
				</div>
				<div class="input-group mb-3">
					<input type="text" id="memEmail2" name="memEmail" class="form-control" placeholder="이메일을 입력해주세요.">
				</div>
				<div class="input-group mb-3">
					<input type="text" id="memName2" name="memName" class="form-control" placeholder="이름을 입력해주세요.">
				</div>
				<div class="input-group mb-3">
					<p>
						회원님의 비밀번호는 <font id="resultPw" style="font: bold;" color="blue">-</font> 입니다.
					</p>
				</div>
				<div class="row">
					<div class="col-12">
						<button type="button" id="pwFindBtn" class="btn btn-primary btn-block">비밀번호찾기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<br/>
	<div class="card card-outline card-secondary">
		<div class="card-header text-center">
			<h4>MAIN MENU</h4>
			<button type="button" class="btn btn-secondary btn-block">로그인</button>
		</div>
	</div>
</div>
<script>
$(function() {
	var idForm = $("#idForm");
	var pwForm = $("#pwForm");
	var idFindBtn = $("#idFindBtn");
	var pwFindBtn = $("#pwFindBtn");
	
	idFindBtn.on("click", function(){
		var memEmail = $("#memEmail1").val();
		var memName = $("#memName1").val();
		
		if (memEmail == null || memEmail == "") {
			alert("이메일을 입력해주세요");
			return false;
		}
		if (memName == null || memName == "") {
			alert("이름을 입력해주세요");
			return false;
		}
		
		var data = {
			memEmail : memEmail,
			memName : memName
	 	}
		
		$.ajax({
	 		url : "/notice/idForget.do",
	 		type : "post",
	 		data : JSON.stringify(data),
	 		contentType : "application/json;charset=utf-8",
	 		success : function(res){
	 			if (res == null || res == "") {	
					alert("회원 없음");
				} else {	
					$("#resultId").text(res);
				}
	 			
	 		}
	 	}); // /ajax
	 	
	});
	
	pwFindBtn.on("click", function(){
		var memId = $("#memId").val();
		var memEmail = $("#memEmail2").val();
		var memName = $("#memName2").val();
		
		if (memId == null || memId == "") {
			alert("아이디를 입력해주세요");
			return false;
		}
		if (memEmail == null || memEmail == "") {
			alert("이메일을 입력해주세요");
			return false;
		}
		if (memName == null || memName == "") {
			alert("이름을 입력해주세요");
			return false;
		}

		var data = {
			memId : memId,
			memEmail : memEmail,
			memName : memName
	 	}
		
		$.ajax({
	 		url : "/notice/pwForget.do",
	 		type : "post",
	 		data : JSON.stringify(data),
// 	 		dataType : "text", // produce = "text/plain;charset=utf-8" 과 일치한다.
	 		contentType : "application/json;charset=utf-8",
	 		success : function(res){
	 			if (res == null || res == "") {	
					alert("회원 없음");
				} else {	
					$("#resultPw").text(res);
				}
	 			
	 		}
	 	}); // /ajax
	});
	
	
});

</script>