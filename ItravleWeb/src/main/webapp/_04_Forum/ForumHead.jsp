<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css"	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />


<script type="text/javascript"	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
</head>
<body>
	<div>
		<div class="btn-group btn-group-lg">
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type00"/>'">&nbsp;全&nbsp;部&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type01"/>'">&nbsp;其&nbsp;他&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type02"/>'">&nbsp;景&nbsp;點&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type03"/>'">&nbsp;行&nbsp;程&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type04"/>'">&nbsp;遊&nbsp;記&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type05"/>'">&nbsp;交&nbsp;通&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type06"/>'">&nbsp;飲&nbsp;食&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type07"/>'">&nbsp;住&nbsp;宿&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type08"/>'">&nbsp;購&nbsp;物&nbsp;</button>
		  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type09"/>'">&nbsp;金&nbsp;錢&nbsp;</button>		  
		</div>
		
		<c:choose>
			<c:when test="${empty user}"><button type="button" class="btn btn-warning btn-lg" onclick="doArticleMessage()" style="float: right">發表文章</button></c:when>
			<c:when test="${not empty user}"><button type="button" class="btn btn-warning btn-lg" onclick="location.href='<c:url value="/_04_Forum/member/Article.jsp?crud=NewArticle&memberId=${user.memberId}"/>'">發表文章</button>
			</c:when>
		</c:choose>
		
		
	</div>
</body>
</html>
