<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/tabs.css"/>" />
<link rel="stylesheet" type="text/css"	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css"	href="../css/_04_Forum/datatable.css" />
<link rel="stylesheet" type="text/css"	href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />

<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript"	src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript"	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
</head>
<body>
	<div id="tabsUI">
		<ul class="tabs">
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type00"/>">全部</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type01" />">其他</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type02" />">景點</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type03" />">行程</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type04" />">遊記</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type05" />">交通</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type06" />">飲食</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type07" />">住宿</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type08" />">購物</a></li>
			<li><a	href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type09" />">金錢</a></li>
<!-- 	有登入就可發表文章  反之導向登入		 -->
		<c:choose>
		<c:when test="${empty user}"><li><a href="<c:url value="/_05_Member/Login.jsp"/>">發表文章</a></li></c:when>
		<c:when test="${not empty user}"><li><a href="<c:url value="/_04_Forum/member/Article.jsp?crud=NewArticle&memberId=${user.memberId}"/>">發表文章</a></li></c:when>
		</c:choose>
		</ul>
		<ul></ul>
	</div>
</body>
</html>
