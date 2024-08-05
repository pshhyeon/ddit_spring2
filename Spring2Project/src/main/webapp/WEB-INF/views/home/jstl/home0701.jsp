<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>7장. JSP</h3>
	<p>6) c:forEach, c:forTokens</p>
	
	<p>c:forEach > </p>
	<c:forEach items="${member.hobbyArray }" var="hobby">
		${hobby } <br/>
	</c:forEach>
	
	<hr/>
	
	<p>c:forTokens > </p>
	<c:forTokens items="${member.hobby }" delims="," var="hobby">
		${hobby } <br/>
	</c:forTokens>

</body>
</html>