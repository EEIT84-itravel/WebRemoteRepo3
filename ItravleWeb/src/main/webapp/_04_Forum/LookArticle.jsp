<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${forumVO.forumTopic}</title>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
</head>
<body>
	<header> 
	<!-- import共同的 --> 
	</header>
	<nav class="navbar navbar-inverse" role="navigation"> 
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
	<form action="<c:url value="/_04_Forum/member/Reply.controller"/>" method="post">
		<div id="header">
			<table border="1">
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				<input type="submit" value="回覆文章" name="reply">
				<input type="submit" value="修改文章" name="modifydoc">
				<input type="hidden" name="forumId" value="${forumVO.forumId}">
				<tr>
					<td>作者：${forumVO.memberId}</td>
				</tr>
				<tr>
					<td>文章主題：${forumVO.forumTopic}</td>
				</tr>
				<tr>
					<td>文章內容：${forumVO.forumContent}</td>				
				</tr>
				<tr>
					<td>最後修改日期：${forumVO.forumTime}</td>
				</tr>
				<tr>
					<td>瀏覽人次：${forumVO.visitorNum}</td>
				</tr>
				<tr>
					<td>文章編號：${forumVO.forumId}</td>
				</tr>
				<input type="button" onclick="history.back()" value="上一頁" />
				<a href="/ItravleWeb/_04_Forum/ForumIndex.jsp">回討論區首頁</a>
			</table>
			<table border='1' bgcolor="yellow">
				<c:forEach var="messageVO" items="${messageVO}">
					<tr>
						<td>回文者：${messageVO.memberId}</td>
						<td>回文時間：${messageVO.updateTime}</td>
					</tr>
					<tr>
						<td>回覆內容：${messageVO.content}<br></td>
					</tr>					
				</c:forEach>
				</table>
			</div>
		</form>
	</article>
	<footer> 
	<!-- import共同的 --> 
	</footer>
</body>
</html>