<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>${eventVO.eventTopic}</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<style type="text/css">
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
	<article>
		<form>
			<table>
				<tr>
					<td>活動主題：${eventVO.eventTopic}</td>
				</tr>
				<tr>
					<td>活動內容：${eventVO.eventContent}</td>
				</tr>
				<tr>
					<td>活動起訖時間：${eventVO.eventStartDate}起，至${eventVO.eventEndDate}</td>
				</tr>
				<tr>
					<td>活動圖片：<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="600" height="500"></td>
				</tr>
				<tr>
					<td><a href="/ItravleWeb/_03_Event/AllEvent.jsp">回活動首頁</a></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>