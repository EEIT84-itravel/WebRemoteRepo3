<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty tripVO}">
		<table>
			<thead>
				<tr>
					<th>tripId</th>
					<th>memberId</th>
					<th>tripName</th>
					<th>tripStartDate</th>
					<th>tripEndDate</th>
					<th>startTime</th>
					<th>regionId</th>
					<th>transFormId</th>
					<th>tripIntro</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>${tripVO.tripId}</td>
						<td>${tripVO.memberId}</td>
						<td>${tripVO.tripName}</td>
						<td>${tripVO.tripStartDate}</td>
						<td>${tripVO.tripEndDate}</td>
						<td>${tripVO.startTime}</td>
						<td>${tripVO.regionId}</td>
						<td>${tripVO.transFormId}</td>
						<td>${tripVO.tripIntro}</td>
					</tr>
			</tbody>
		</table>
	</c:if>
</body>
</html>