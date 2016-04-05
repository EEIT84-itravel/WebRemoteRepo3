<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> list = service.select("region");
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>景點資訊</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			event : "mouseover"
		});
	});
</script>
</head>
<body>
	<h1>景點資訊</h1>

	<table border="1" width="300" height="300">

	</table>
	<select>
		<c:forEach var="region" items="${list}">
			<option value="${region.codeId}">${region.codeName}</option>
		</c:forEach>
	</select>
	<div id="tabs">
	

		<ul>
			<li><a href="#tabs-1">相關行程</a></li>
			<li><a href="#tabs-2">相關遊記</a></li>
			<li><a href="#tabs-3">留言</a></li>
		</ul>
		<div id="tabs-1">
			<p>台北小清新之旅</p>
		</div>
		<div></div>
		<div id="tabs-2">
			<p>我的遊記</p>
		</div>
		<div id="tabs-3">
			<p>門票是不是漲價了</p>
		</div>
	</div>
</body>
</html>