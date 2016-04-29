<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<c:remove var="LoginOK" />
<%
	session.removeAttribute("user");
	session.removeAttribute("admin");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:登出頁面</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_00_Misc/main.css"/>" />
<script type="text/javascript">
	setTimeout("location.href='<c:url value="/index.jsp"/>'", 1000);
</script>

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
		<div style="text-align: center;">
			<h2>您已經登出</h2>
		</div>
	</article>
	<footer>
		<div>
			<jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>