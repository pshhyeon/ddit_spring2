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
	<p>3) c:catch</p>
	<p>EL표현문 안에서 발생한 오류는 어떤 곳에서도 확인할 수 없기 때문에 오류 발생시 전부 자르고 한줄씩 순차적으로 삽입하여 오류가 나는 위치를 확인해야함</p>
	<c:catch var="ex">
		${member.hobbyArray[2] }
	</c:catch>
	<p>
		<c:if test="${ex != null }">
			${ex }
		</c:if>
	</p>
</body>
</html>