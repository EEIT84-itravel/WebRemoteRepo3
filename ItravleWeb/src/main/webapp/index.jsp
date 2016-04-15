<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel首頁</title>
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
		<h3>Welcome ${user.firstName}</h3>
		<h3><a href="<c:url value="/_05_Member/Login.jsp" />">Login</a></h3>
		<h3><a href="<c:url value="/_05_Member/Logout.jsp" />">Logout</a></h3>
		<h3><a href="<c:url value="/_05_Member/Registered.jsp" />">註冊</a></h3>
		<h3><a href="<c:url value="/_05_Member/MemberModify.jsp" />">修改會員資料</a></h3>
		<h3><a href="<c:url value="/_05_Member/MemberSight.jsp" />">我的景點</a></h3>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>