<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>4. 표현언어(EL)</h3>
	<p>4) 논리 연산자를 이용한 방법</p>
	<table border="1">
		<tr>
			<td>\${coin == 1000 && userId == "hongkd" }</td>
			<td>${coin == 1000 && userId == "hongkd" }</td>
		</tr>
		<tr>
			<td>\${coin eq 1000 && userId eq "hongkd" }</td>
			<td>${coin eq 1000 and userId eq "hongkd" }</td>
		</tr>
		<tr>
			<td>\${not empty member && userId == "hongkd" }</td>
			<td>${not empty member && userId == "hongkd" }</td>
		</tr>
		<tr>
			<td>\${! empty member and userId eq "hongkd" }</td>
			<td>${! empty member and userId eq "hongkd" }</td>
		</tr>
	</table>
	<br/> <hr/>
</body>
</html>