<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RegisterALLForm</title>
</head>
<body>
	<h1>RegisterALLForm</h1>
	<table border="1px">
		<tr>
			<td>유저 ID</td>
			<td>${member.userId }</td>
		</tr>
		<tr>
			<td>패스워드</td>
			<td>${member.password}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${member.userName}</td>
		</tr>
		<tr>
			<td>E-Mail</td>
			<td>${member.email}</td>
		</tr>
		<c:set var="birth" value="${member.birth}"/>
		<tr>
			<td>생년월일</td>
			<td> <fmt:formatDate value="${birth }" pattern="yyyy년 MM월 dd일"/> </td>
		</tr>
		<tr>
			<td>성별</td>
			<c:if test="${member.gender eq 'male'}">
				<td>남자</td>
			</c:if>
			<c:if test="${member.gender eq 'female'}">
				<td>여자</td>
			</c:if>
			<c:if test="${member.gender eq 'other'}">
				<td>기타</td>
			</c:if>
		</tr>
		<tr>
			<td>개발자여부</td>
			<c:if test="${member.developer eq 'Y'}">
				<td>개발자</td>
			</c:if>
			<c:if test="${member.developer == null}">
				<td>일반인</td>
			</c:if>
		</tr>
		<tr>
			<td>외국인여부</td>
				<c:choose>
					<c:when test="${member.foreigner}">
						<td>외국인</td>
					</c:when>
					<c:otherwise>
						<td>내국인</td>
					</c:otherwise>
				</c:choose>
		</tr>
		<tr>
			<td>국적</td>
			<c:if test="${member.nationality eq 'korea'}">
				<td>한국</td>
			</c:if>
			<c:if test="${member.nationality eq 'germany'}">
				<td>독일</td>
			</c:if>
			<c:if test="${member.nationality eq 'austrailia'}">
				<td>호주</td>
			</c:if>
			<c:if test="${member.nationality eq 'canada'}">
				<td>캐나다</td>
			</c:if>
			<c:if test="${member.nationality eq 'usa'}">
				<td>미국</td>
			</c:if>
		</tr>
		<tr>
			<td>소유차량</td>
			<c:choose>
				<c:when test="${member.cars == null or member.cars == ''}">
					<td>소유차량 없음</td>
				</c:when>
				<c:otherwise>
					<c:set var="cars" value="${fn:replace(member.cars, ',' , ' ')}" />
					<td>${fn:toUpperCase(cars)}</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<td>취미</td>
			<td>
				<c:forEach items="${member.hobbyArray}" var="hobby">
					<c:if test="${hobby  eq 'sports'}">
						운동
					</c:if>
					<c:if test="${hobby eq 'music'}">
						음악
					</c:if>
					<c:if test="${hobby eq 'movie'}">
						영화
					</c:if>
					 
				</c:forEach>
			</td> 
		</tr>
		<tr>
			<td>우편번호</td>
			<td>${member.address.postCode}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${member.address.location}</td>
		</tr>
		<c:forEach items="${member.cardList}" var="card" varStatus="i">
			<tr>
				<td>카드${i.count }(번호)</td>
				<td>${card.no}</td>
			</tr>
			<c:set var="validDate" value="${card.validMonth}"/>
			<tr>
				<td>카드${i.count }(유효년월)</td>
				<td> <fmt:formatDate value="${validDate }" pattern="yyyy년 MM월 dd일"/> </td>
			</tr>
		</c:forEach>
		<tr>
			<td>소개</td>
			<td>${member.introduction}</td>
		</tr>
	</table>
</body>
</html>