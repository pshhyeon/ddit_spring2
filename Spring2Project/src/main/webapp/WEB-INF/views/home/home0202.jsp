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
	<p>3) 비교 연산자를 이용한 방법</p>
	<table border="1">
		<tr>
			<td>\${coin == 1000 }</td>
			<td>${coin == 1000 }</td>
		</tr>
		<tr>
			<td>\${coin eq 1000 }</td>
			<td>${coin eq 1000 }</td>
		</tr>
		<tr>
			<td>\${coin != 500 }</td>
			<td>${coin != 500 }</td>
		</tr>
		<tr>
			<td>\${coin ne 500 }</td>
			<td>${coin ne 500 }</td>
		</tr>
		<tr>
			<td>\${coin &lt; 2000 }</td>
			<td>${coin < 2000 }</td>
		</tr>
		<tr>
			<td>\${coin &lt;(lt) 2000 }</td>
			<td>${coin lt 2000 }</td>
		</tr>
		<tr>
			<td>\${coin &gt; 500 }</td>
			<td>${coin > 500 }</td>
		</tr>
		<tr>
			<td>\${coin &gt;(gt) 500 }</td>
			<td>${coin gt 500 }</td>
		</tr>
		<tr>
			<td>\${coin &lt;= 1000 }</td>
			<td>${coin <= 1000 }</td>
		</tr>
		<tr>
			<td>\${coin &lt;=(le) 1000 }</td>
			<td>${coin le 1000 }</td>
		</tr>
		<tr>
			<td>\${coin &gt;= 1000 }</td>
			<td>${coin >= 1000 }</td>
		</tr>
		<tr>
			<td>\${coin &gt;=(ge) 1000 }</td>
			<td>${coin ge 1000 }</td>
		</tr>
	</table>
	<br/> <hr/>
	<table border="1">
		<tr>
			<td>\${userId == "hongkd" }</td>
			<td>${userId == "hongkd" }</td>
		</tr>
		<tr>
			<td>\${userId eq "hongkd" }</td>
			<td>${userId eq "hongkd" }</td>
		</tr>
	</table>
</body>
</html>