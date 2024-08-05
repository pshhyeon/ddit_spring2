<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>마이페이지</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">User Profile</li>
				</ol>
			</div>
		</div>
	</div>
</section>

<section class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">

				<div class="card card-dark card-outline">
					<div class="card-header">
						<div class="card-title">
							<h4>내정보</h4>
						</div>
					</div>
					<div class="card-body">
						<div class="position-relative">
							<img src="${pageContext.request.contextPath }${member.memProfileimg}" alt="Photo 1" class="img-fluid" id="profileImg">
							<div class="ribbon-wrapper ribbon-lg">
								<div class="ribbon bg-success text-lg">Profile</div>
							</div>
						</div>
						<div class="row mt-4">
							<div class="col-md-4 text-bold">아이디</div>
							<div class="col-md-8">${member.memId }</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">비밀번호</div>
							<div class="col-md-8">PROTECTED</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">이름</div>
							<div class="col-md-8">${member.memName }</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">성별</div>
							<c:set var="gender" value="${member.memGender eq 'M' ? '남자' : '여자'}"/>
							<div class="col-md-8">${gender }</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">이메일</div>
							<div class="col-md-8">${member.memEmail }</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">전화번호</div>
							<div class="col-md-8">${member.memPhone }</div>
						</div>
						<div class="row mt-2">
							<div class="col-md-4 text-bold">주소</div>
							<div class="col-md-8">${member.memAddress1 } ${member.memAddress2 }</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-9">
				<div class="card card-dark card-outline">
					<div class="card-header">
						<div class="row">
							<div class="col-md-10">
								<h4>내정보 수정</h4>
							</div>
							<div class="col-md-2" align="right">
								<button type="button" id="updateBtn" class="btn btn-info">수정하기</button>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="tab-content">
							<div class="tab-pane active">
								<form class="form-horizontal" id="updateForm" action="/notice/profileUpdate.do" method="post" enctype="multipart/form-data">
									<input type="hidden" name="memNo" value="${member.memNo }">
									<div class="form-group row">
										<label class="col-sm-2 col-form-label">프로필이미지</label>
										<div class="col-md-10">
											<div class="custom-file">
												<input type="file" class="custom-file-input" id="imgFile" name="imgFile"> 
												<label class="custom-file-label" for="imgFile">프로필 이미지를 선택해주세요</label>
											</div>
										</div>
									</div>
									<div class="form-group row">
										<label for="memId" class="col-sm-2 col-form-label">아이디</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="memId" name="memId" value="${member.memId }" placeholder="아이디를 입력해주세요." readonly="readonly">
											<span id="idCheckResult"></span>
										</div>
									</div>
									<div class="form-group row">
										<label for="memPw" class="col-sm-2 col-form-label">비밀번호</label>
										<div class="col-sm-10">
											<input type="password" class="form-control" id="memPw" name="memPw" placeholder="비밀번호를 입력해주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="memName" class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="memName" name="memName" value="${member.memName }" placeholder="이름을 입력해주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="" class="col-sm-2 col-form-label">성별</label>
										<div class="col-sm-10">
											<div class="icheck-primary d-inline">
												<input type="radio" id="memGenderM" name="memGender" value="M" <c:if test="${member.memGender eq 'M'}">checked="checked"</c:if>> 
												<label for="memGenderM">남자</label>
											</div>
											<div class="icheck-primary d-inline">
												<input type="radio" id="memGenderF" name="memGender" value="F" <c:if test="${member.memGender eq 'F'}">checked="checked"</c:if>> 
												<label for="memGenderF">여자</label>
											</div>
										</div>
									</div>
									<div class="form-group row">
										<label for="memEmail" class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="memEmail" name="memEmail" value="${member.memEmail }" placeholder="이메일을 입력해주세요.">
										</div>
									</div>
									<div class="form-group row">
										<label for="memPhone" class="col-sm-2 col-form-label">전화번호</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="memPhone" name="memPhone" value="${member.memPhone }" placeholder="전화번호를 입력해주세요.">
										</div>
									</div>
									<div class="input-group mb-3">
										<label for="inputSkills" class="col-sm-2 col-form-label">주소</label>
										<div class="col-sm-10">
											<div class="input-group mb-3">
												<input type="text"  id="memPostCode" value="${member.memPostcode }" name="memPostcode" class="form-control" placeholder="우편번호를 입력해주세요"> 
												<span class="input-group-append">
													<button type="button" onclick="DaumPostcode()" class="btn btn-secondary btn-flat">우편번호 찾기</button>
												</span>
											</div>
											<div class="input-group mb-3">
												<input type="text" id="memAddress1" name="memAddress1" class="form-control" value="${member.memAddress1 }" placeholder="주소를 입력해주세요">
											</div>
											<div class="input-group mb-3">
												<input type="text" id="memAddress2" name="memAddress2" class="form-control" value="${member.memAddress2 }" placeholder="상세주소를 입력해주세요">
											</div>
										</div>
									</div>
									<font id="error-info" color="red" style="display:block;"></font>
									<sec:csrfInput/>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	var imgFile = $("#imgFile");			// 프로필 이미지 선택 Element
	var profileImg = $("#profileImg");		// 프로필 이미지 태그
	var id = $("#memId");					// 아이디 입력 Element
	var updateBtn = $("#updateBtn");		// 수정하기 버튼 Element		
	var updateForm = $("#updateForm");		// 수정 Form Element
	var idCheckFlag = true;					// 중복확인 여부 flag
	
	// 프로필 이미지 선택 이벤트 (Open파일을 통해 이미지 파일을 선택하면 이벤트 발생)
	imgFile.on("change", function(){
		var file = event.target.files[0];	// 내가 선택한 파일 (우리는 이미지가 되겠습니다)
		
		if (isImageFile(file)) {	// 이미지 파일이라면
			var reader = new FileReader();
			reader.onload = function(e) {
				// 프로필 이미지 Element에 src 경로로 result를 셋팅한다.
				// 이미지 파일 데이터가 base64인코딩 형태로 변형된 데이터가 src경로에 설정된다.
				profileImg.attr("src", e.target.result);
			}
			reader.readAsDataURL(file);
		} else {	// 이미지 파일이 아니라면
			alert("이미지 파일을 선택해주세요!");
		}
		
	}); // /imgFile-change
	
	// 중복확인 버튼 클릭 이벤트
	id.on("change", function(){
		var memId = $("#memId").val();
		if (memId == "") {
			alert("아이디를 입력해주세요");
			return false;
		}
		if (memId == "${member.memId}") {
			return false;
		}
	 	var data = {
	 		memId : memId
	 	}
	 	
	 	$.ajax({
	 		url : "/notice/idCheck.do",
	 		type : "post",
	 		data : JSON.stringify(data),
	 		contentType : "application/json;charset=utf-8",
	 		success : function(res){
	 			var err = $(".error")[0];
	 			if (res === "NOTEXIST") {	// 아이디 사용 가능
	 				$("#idCheckResult").text("사용 가능한 아이디입니다!").css("color", "green");
	 				idCheckFlag = true;	// 중복확인 완료
				} else {	// 아이디 중복
					$("#idCheckResult").text("이미 사용중인 아이디입니다!").css("color", "red");
	 				idCheckFlag = false;	// 중복확인 완료
				}
	 			
	 		}
	 	}); // /ajax
	}); // /idCheckBtn-click
	
	updateBtn.on("click", function(){
		var memId = $("#memId").val();	
		var memPw = $("#memPw").val();	
		var memName = $("#memName").val();
		
		if (memId == null || memId == "") {
			$("#error-info").text("아이디를 입력해주세요!");
			return false;
		}
		
		if (memPw == null || memPw == "") {
			$("#error-info").text("비밀번호를 입력해주세요!");
			return false;
		}
		
		if (memName == null || memName == "") {
			$("#error-info").text("이름을 입력해주세요!");
			return false;
		}
		
		if (idCheckFlag) {
			updateForm.submit();
		}else{
			$("#memId").focus();
			alert("사용 불가능한 아이디 입니다!");
		}
	}); // updateBtn
	
	
});

//이미지 파일인지 체크
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();	// 파일명에서 확장자를 가져온다.
	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
}

function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('memPostCode').value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
    
}
</script>