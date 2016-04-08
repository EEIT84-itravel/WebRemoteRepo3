<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel討論區回覆文章</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<script type="text/javascript"
	src="<c:url value="/js/_04_Forum/ckeditor/ckeditor.js" />"></script>
</head>

<body>
	<form
		action="<c:url value="/_04_Forum/member/ReplyArticle.controller"/>"
		method="post">
		<input type="hidden" name="messageType" value="type_id05">
		<div id="header">
			<table>
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				<tr>
					<td>回覆內容：</td>
					<td><textarea rows="5" cols="40" name="content"></textarea></td>
					<script>
						CKEDITOR.replace('content', {
							width:1000,
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
</body>
</html>