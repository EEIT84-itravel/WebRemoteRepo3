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
		<!-- import�@�P�� -->
	</header>
	<!-- import�@�P�� -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import�@�P�� -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
		<form>
			<table>
				<tr>
					<td>���ʥD�D�G${eventVO.eventTopic}</td>
				</tr>
				<tr>
					<td>���ʤ��e�G${eventVO.eventContent}</td>
				</tr>
				<tr>
					<td>���ʰ_�W�ɶ��G${eventVO.eventStartDate}�_�A��${eventVO.eventEndDate}</td>
				</tr>
				<tr>
					<td>���ʹϤ��G<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="600" height="500"></td>
				</tr>
				<tr>
					<td><a href="/ItravleWeb/_03_Event/AllEvent.jsp">�^���ʭ���</a></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import�@�P�� -->
	</footer>
</body>
</html>