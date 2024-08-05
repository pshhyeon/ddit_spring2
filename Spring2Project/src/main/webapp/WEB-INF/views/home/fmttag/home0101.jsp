<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>1) type 속성을 지정하고나 pattern 속성을 지정하여 숫자를 형식화한다.</h4>
	<p>number : ${coin }</p>
	
	<p>currency : <fmt:formatNumber value="${coin }" type="currency"/></p> <!-- 한국이기 때문에 ￦이 나옴 -->
	<p>percent : <fmt:formatNumber value="${coin }" type="percent"/></p> <!-- %기호 붙여서 출력 -->
	<p>pattern : <fmt:formatNumber value="${coin }" pattern="00000.00"/></p> <!-- 정수와 소수점 패턴 지정 -->
</body>
</html>