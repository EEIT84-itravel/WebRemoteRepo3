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
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
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
	<article  class="center-block">
		<h1>您已經登出</h1>
		<P />
		<a href="../index.jsp">回首頁</a>
	</article>
	<script type="text/javascript"> setTimeout("location.href='http://www.vedfolnir.com'",1000); </script>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>