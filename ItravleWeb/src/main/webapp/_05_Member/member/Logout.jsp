<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<c:remove var="LoginOK" />
<%
	session.invalidate();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:登出頁面</title>
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
		您已經登出
		<P />
		<a href="/ItravleWeb/index.jsp">回首頁</a>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>