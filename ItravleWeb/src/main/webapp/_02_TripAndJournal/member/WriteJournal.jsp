<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-建立新遊記</title>
</head>
<body>
	<c:if test="${not empty journalVO}">
		<table>
			<thead>
				<tr>
					<th>journalId</th>
					<th>memberId</th>
					<th>journalName</th>
					<th>beginTime</th>
					<th>endTime</th>
					<th>regionId</th>
					<th>journalIntro</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${journalVO.journalId}</td>
					<td>${journalVO.memberId}</td>
					<td>${journalVO.journalName}</td>
					<td>${journalVO.beginTime}</td>
					<td>${journalVO.endTime}</td>
					<td>${journalVO.regionId}</td>
					<td>${journalVO.journalIntro}</td>
				</tr>
			</tbody>
		</table>
	</c:if>
</body>
</html>