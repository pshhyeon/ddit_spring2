<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>now : ${now }</p> <hr/>
	
	<h4>6) type 속성을 date로 지정하여 날짜 포맷팅을 한다.</h4>
	<p>date default : <fmt:formatDate value="${now }" type="date" dateStyle="default"/> </p>
	<p>date short : <fmt:formatDate value="${now }" type="date" dateStyle="short"/> </p>
	<p>date medium : <fmt:formatDate value="${now }" type="date" dateStyle="medium"/> </p>
	<p>date long : <fmt:formatDate value="${now }" type="date" dateStyle="long"/> </p>
	<p>date full : <fmt:formatDate value="${now }" type="date" dateStyle="full"/> </p>
	<hr/>
	
	<h4>7) type 속성을 time로 지정하여 시간 포맷팅을 한다.</h4>
	<p>time default : <fmt:formatDate value="${now }" type="time" timeStyle="default"/> </p>
	<p>time short : <fmt:formatDate value="${now }" type="time" timeStyle="short"/> </p>
	<p>time medium : <fmt:formatDate value="${now }" type="time" timeStyle="medium"/> </p>
	<p>time long : <fmt:formatDate value="${now }" type="time" timeStyle="long"/> </p>
	<p>time full : <fmt:formatDate value="${now }" type="time" timeStyle="full"/> </p>
	<hr/>
	
	<h4>8) type 속성을 both로 지정하여 날짜, 시간 둘 다 포맷팅을 한다.</h4>
	<p>both default : <fmt:formatDate value="${now }" type="both" timeStyle="default" dateStyle="default"/> </p>
	<p>both short : <fmt:formatDate value="${now }" type="both" timeStyle="short" dateStyle="short"/> </p>
	<p>both medium : <fmt:formatDate value="${now }" type="both" timeStyle="medium" dateStyle="medium"/> </p>
	<p>both long : <fmt:formatDate value="${now }" type="both" timeStyle="long" dateStyle="long"/> </p>
	<p>both full : <fmt:formatDate value="${now }" type="both" timeStyle="full" dateStyle="full"/> </p>
	<hr/>
	
</body>
</html>