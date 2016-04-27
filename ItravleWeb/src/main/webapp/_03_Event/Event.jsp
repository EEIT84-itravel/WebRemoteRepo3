<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<jsp:useBean id="sightSvc" scope="page" class="_01_Sight.model.SightService" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${eventVO.eventTopic}</title>
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<style type="text/css">
.table.eventTable{
width: 700px;
margin: 0 auto;
}
.event{
text-align: center;
font-size: 20px;
}
</style>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<!-- import共同的 -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article class="center-block">
		<div class="event">
			<table class="table eventTable">
				<tr>
					<td><h1>${eventVO.eventTopic}</h1></td>
				</tr>
				<tr>
					<td><span style="color:red">${eventVO.eventStartDate}</span>起，至<span style="color:red">${eventVO.eventEndDate}</span></td>
				</tr>
				<tr>
				<tr class="sightId">
					<td hidden="true">${eventVO.sightId}</td>
					<td>相關景點: 
					<c:forEach var="sightVO" items="${sightSvc.all}">
                          <c:if test="${sightVO.sightId==eventVO.sightId}">
								<a href="<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />">${sightVO.sightName}</a>
                          </c:if>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<td><img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="400" height="300"></td>
				</tr>
				<tr>
					<td>${eventVO.eventContent}</td>
				</tr>
				<tr>
					<td><a href="<c:url value="/_03_Event/AllEvent.jsp" />">回活動首頁</a></td>
				</tr>
			</table>
		</div>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>