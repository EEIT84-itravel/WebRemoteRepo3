<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:Login</title>
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
	<article>
		<h3>Login</h3>
		<form action="<c:url value="/_05_Member/login.controller" />"
			method="get">
			<table>
				<tr>
					<td>ID :</td>
					<td><input type="text" name="username" value="${param.username}"></td>
					<td>${error.username}</td>
				</tr>
				<tr>
					<td>PWD :</td>
					<td><input type="password" name="password" value="${param.password}"></td>
					<td>${error.password}</td>
				</tr>
				<tr>
					<td></td>
					<td align="right"><input type="submit" value="Login"></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>