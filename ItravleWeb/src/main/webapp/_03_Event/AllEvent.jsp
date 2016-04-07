<!-- 外接程式碼 -->
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_03_Event.model.*"%>
<%@ page import="java.util.*"%>
<%
	EventService eventService = new EventService();
	List<EventVO> eventVO = eventService.select();
	pageContext.setAttribute("eventVO", eventVO);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel全部活動</title>
</head>
<body>
	<form action="">
		<table border='1'>
			<tr>
				<th>活動編號</th>
				<th>活動主題</th>
				<th>活動開始時間</th>
				<th>活動結束時間</th>
			</tr>

			<c:forEach var="eventVO" items="${eventVO}">
				<tr>
					<td>${eventVO.eventId}</td>
					<td><a
						href="<c:url value="/_03_Event/ShowEvent.controller?eventId=${eventVO.eventId}" />">${eventVO.eventTopic}</a></td>
					<td>${eventVO.eventStartDate}</td>
					<td>${eventVO.eventEndDate}</td>
				</tr>
			</c:forEach>



		</table>
	</form>



</body>
</html>