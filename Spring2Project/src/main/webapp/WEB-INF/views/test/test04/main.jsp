<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Board List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
.pc td {
	height: 100px;
	padding-top: 24px;
}
</style>
<body>
	<!-- 
		피시방 사장이 되어, 손님을 받는다.
		1) 손님이 이용할 PC를 선택하고 이름, 이용시간을 설정 후 등록을 진행한다.
			> 이때, 이용 시간으로 설정되어 있는 시간만큼 타이머가 해당 PC자리에 설정된다.
		2) 이용중인 PC를 종료 버튼을 클릭 하면 타이머가 설정되어 있는 PC가 종료되고
			아래 매출현황에 이용시간 만큼의 매출이 기록된다.
		
		*** 손님을 받을 때마다 PC 이용 현황판은 이용 시간만큼 타이머가 동시에 동작해야한다.
	 -->
	<div class="container">
		<h3 class="mt-3">피시방 카운터</h3>
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-header"></div>
					<div class="card-body">
						<table class="table table-bordered">
							<tr>
								<td width="30%">PC번호</td>
								<td id="pcNo">PC-2</td>
							</tr>
							<tr>
								<td>이름</td>
								<td id="pcUser"><input type="text" class="form-control" id="userName"/></td>
							</tr>
							<tr>
								<td>시간</td>
								<td id="pcTime"><input type="number" class="form-control" id="useTime" min="1" max="12"/></td>
							</tr>
						</table>
					</div>
					<div class="card-footer">
						<button type="button" class="btn btn-primary" id="addBtn">등록</button>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<table class="table table-bordered pc">
					<tr align="center">
						<td data-ord="1">PC-1<br /></td>
						<td data-ord="2">PC-2<br /></td>
						<td data-ord="3">PC-3<br /></td>
						<td data-ord="4">PC-4<br /></td>
						<td data-ord="5">PC-5<br /></td>
						<td data-ord="6">PC-6<br /></td>
						<td data-ord="7">PC-7<br /></td>
						<td data-ord="8">PC-8<br /></td>
					</tr>
					<tr align="center">
						<td data-ord="9">PC-9<br /></td>
						<td data-ord="10">PC-10<br /></td>
						<td data-ord="11">PC-11<br /></td>
						<td data-ord="12">PC-12<br /></td>
						<td data-ord="13">PC-13<br /></td>
						<td data-ord="14">PC-14<br /></td>
						<td data-ord="15">PC-15<br /></td>
						<td data-ord="16">PC-16<br /></td>
					</tr>
					<tr align="center">
						<td data-ord="17">PC-17<br /></td>
						<td data-ord="18">PC-18<br /></td>
						<td data-ord="19">PC-19<br /></td>
						<td data-ord="20">PC-20<br /></td>
						<td data-ord="21">PC-21<br /></td>
						<td data-ord="22">PC-22<br /></td>
						<td data-ord="23">PC-23<br /></td>
						<td data-ord="24">PC-24<br /></td>
					</tr>
					<tr align="center">
						<td data-ord="25">PC-25<br /></td>
						<td data-ord="26">PC-26<br /></td>
						<td data-ord="27">PC-27<br /></td>
						<td data-ord="28">PC-28<br /></td>
						<td data-ord="29">PC-29<br /></td>
						<td data-ord="30">PC-30<br /></td>
						<td data-ord="31">PC-31<br /></td>
						<td data-ord="32">PC-32<br /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="card">
					<div class="card-header">이용 안내</div>
					<div class="card-body">
						<ul>
							<li>1시간 이용 시 1,000원 입니다.</li>
							<li>이용 후, 의자를 꼭 넣어주세요.</li>
							<li>화장실은 입구 오른쪽 끝입니다.</li>
							<li>각 흡연실, 비흡연실 구역이 나뉘어져있습니다.</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="card">
					<div class="card-header">매출 현황</div>
					<div class="card-body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>번호</th>
									<th>PC 번호</th>
									<th>이용 시간</th>
									<th>금액</th>
								</tr>
							</thead>
							<tbody class="sales">
								<tr>
									<td colspan="4">매출이 없습니다</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="card-footer">
						<h5 class="total_sales">총 매출 : 0원</h5>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var addBtn = $("#addBtn");
	var usePcArray = [];	// 사용중인 PC 목록
	var ord = 0;			// PC 순서
	var selectEle = null;	// 현재 선택한 PC자리의 Element
	var salesArray = [];	// 매출 목록
	var salesArrayNum = 0;	// 매출 목록 크기
	
	$(".pc").on("click", "td", function(){
		selectEle = $(this);		// 현재 선택한 PC자리 Ele 요소
		ord = $(this).data("ord");	// (count 단위의 숫자)
		var classNames = $(this).prop("class");
		
		// 사용중인 pc라면 class명에 use가 포함된다.
		if(classNames.includes("use")){	// 사용중인 pc	
			$("#pcNo").text("PC-"+ord);
      		$("#userName").val(selectEle.find("p:hidden").text());
			var usePc = usePcArray[ord-1];	// 현재 선택한 PC 객체(array안에 있는)
		}else{		// 비어있는 pc
			$("#pcNo").text("PC-"+ord);
			$("#userName").val("");
		}
	});
	
	addBtn.on("click", function(){
		var userName = $("#userName").val();
		var useTime = $("#useTime").val();
		
		if(userName == null || userName == ""){
			alert("이름을 입력해주세요!");
			return false;
		}
		if(useTime == null || useTime == ""){
			alert("시간을 입력해주세요!");
			return false;
		}
		
		if(useTime > 12){
			useTime = 12;
		}

		var usePrice = parseInt(useTime) * 1000;
		var useTime = parseInt(useTime) * 60 * 60;	// 시 > 초

		var data = usePcArray[ord-1];

		if(selectEle.prop("class").includes("use")){ // 사용중인 pc인지 여부
			data = {
				pcUser : userName,
				pcTime : data.pcTime + useTime,
				pcPrice : data.pcPrice + usePrice
			}
		} else {
			data = {
				pcUser : userName,
				pcTime : useTime,
				pcPrice : usePrice
			}
		}
		
		usePcArray[ord-1] = data;
		selectEle.addClass("use");
		selectEle.css("background-color", "silver");
		$("#userName").val("");
		$("#useTime").val("");
	});

	setInterval(() => {
		for(var i = 0; i < 32; i++){
			if(usePcArray[i] != null){
				var html = "<p>PC-"+(i+1)+"</p>";
				html += "<p hidden>";
				html += usePcArray[i].pcUser + "</p><p>";
				var pTime = usePcArray[i].pcTime;
				html += flowTime(pTime);	// 1:20:14 와 같은 값으로 꺼내준다.
				usePcArray[i].pcTime = pTime - 1;
				html += "</p>";
				html += "<button type='button' class='btn btn-sm btn-danger end_btn'>종료</button>";
				$(".pc td:eq("+i+")").html(html);
			}else{
				console.log("PC" + (i+1) + " : 미사용중");
			}
		}
	}, 1000);
	
	// 종료
	$(document).on('click', '.end_btn', function(){
		for(var i = 0; i < 32; i++){
			if(usePcArray[i] != null){
				var selected_el = $(this).closest('td')
				var text = selected_el.find('p').eq(0).text();
				selected_el.html(text + "<br>");

				// 매출 데이터 등록
				salesData = {
					s_pcNum : text,
					s_useTime : usePcArray[ord - 1].pcTime, 
					s_userPrice : usePcArray[ord - 1].pcPrice
				}
				salesArray[salesArrayNum] = salesData;
				salesArrayNum++;

				usePcArray[ord - 1] = null; // usePcArray에서 제거
				selected_el.removeClass('use'); // pc 클래스 제거
				selected_el.css("background-color", "white");
				
				var total_price = 0;

				var code = "";
				salesArray.forEach(function(el, i){
					console.log("@@el.s_userPrice : "+el.s_userPrice);
					code += "<tr>";
					code += "<td>" + (i+1) + "</td>";
					code += "<td>" + el.s_pcNum + "</td>";
					// code += "<td>" + el.s_useTime + "</td>";
					code += "<td>" + (parseInt(el.s_userPrice) / 1000) + "시간</td>";
					code += "<td>" + el.s_userPrice + "</td>";
					code += "</tr>";
					total_price += el.s_userPrice
				});
				console.log(code);

				$(".sales").html(code);
				var total_sales = $(".total_sales").text("총 매출 : " + formatPrice(total_price) + "원");
				console.log("@@ total_sales: "+total_sales);

			}
		}
	});
	
});

function flowTime(time){
	var timeStr = "";
	// 3500초 58분 20초
	// 1시간은 3600초
	h = Math.floor(time / 3600);
	var ts = time % 3600;
	m = Math.floor(ts / 60);
	s = Math.floor(ts % 60);
	timeStr = h + ":" + m + ":" + s;
	
	return timeStr;
}

// 가격 ',' 찍기
function formatPrice(price){
	var priceStr = "" + price;
    var result = "";
    var cnt = 0;
    for (var i = priceStr.length - 1; i >= 0; i--) {
		cnt++;
		result = priceStr.charAt(i) + result;
		result = cnt % 3 === 0 && i != 0 ? ',' + result : result;
    }
    return result;
}

</script>
</html>




