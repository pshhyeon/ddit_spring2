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
	<p>10) c:redirect</p>
	<hr/>
	<p>지정한 페이지로 리다이렉트한다.</p>
	<c:redirect url="http://localhost/board/list"/>
	<h4>redirect 이후의 코드가 보일까요?</h4>
</body>
</html>