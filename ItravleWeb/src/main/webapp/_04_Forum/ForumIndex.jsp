<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 外接程式碼 -->
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<%
	ForumService forumService = new ForumService();
 	List<ForumVO> forumVO = forumService.select();
 	pageContext.setAttribute("forumVO", forumVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript" src="">
	
</script>
<title>ITravel討論區</title>
</head>
<body>
	<form action="<c:url value="/_04_Forum/Forum.controller"/>"
		method="post">
		<div id="header">
			<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
			<table id="forum" border="1">
				<thead>
					<tr id="forumTitle">
						<th>討論類型</th>
						<th>討論主題</th>
						<th>作者</th>
						<th>瀏覽人次</th>
						<th>回覆數</th>
						<th>最後發表</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="forumVO" items="${forumVO}">
						<tr>
							
							<td>${forumVO.forumTypeId}</td>
							<td><a
								href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO.forumId}" />">${forumVO.forumTopic}</a></td>
							<td>${forumVO.memberId}</td>
							<td>${forumVO.visitorNum}</td>
							<td>${forumVO.replyNum}</td>
							<td>${forumVO.forumTime}</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>