<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Spring Form</h3>
	<p>1) 모델에 Map타입의 데이터를 생성하여 추가한 후에 화면에 전달한다.</p>
	<form:form action="/formtag/radio/result" method="post" modelAttribute="member">
		<table border="1">
			<tr>
				<td>성별</td>
				<td>
					<form:radiobuttons path="gender" items="${genderCodeMap }"/>
				</td>
			</tr>
		</table>
		<form:button name="register">등록</form:button>
	</form:form>
</body>
</html>


