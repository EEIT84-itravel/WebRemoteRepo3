<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel討論區回覆文章</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<script type="text/javascript" src="<c:url value="/js/_04_Forum/ckeditor/ckeditor.js" />"></script>
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
		<form action="<c:url value="/_04_Forum/member/ReplyArticle.controller"/>" method="post">
			<input type="hidden" name="messageType" value="type_id05">
			<div id="header">
				<table>
					<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
					<tr>
						<td>回覆內容：</td>
						<td><textarea rows="5" cols="40" name="content"></textarea></td>
						<script>
							CKEDITOR.replace('content', {
								width : 700,
							});
						</script>
						<td><span class="error">${error.content}</span></td>
					</tr>
					<tr>
						<td><input type="submit" value="確定回覆"></td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
			</div>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>