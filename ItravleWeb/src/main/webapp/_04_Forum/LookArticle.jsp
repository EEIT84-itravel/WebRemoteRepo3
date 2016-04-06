<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${forumVO.forumTopic}</title>
</head>
<body>
	<form action="<c:url value="/_04_Forum/member/Reply.controller"/>"
		method="post">
		<input type="submit" value="回覆文章" name="reply"> <input
			type="hidden" name="forumId" value="${forumVO.forumId}">
		<table border="1">

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
		<table>


			<c:forEach var="messageVO" items="${messageVO}">
				<tr>
					<td>回文者：${messageVO.memberId}</td>
				</tr>
				<tr>
					<td>回覆內容：${messageVO.content}</td>
				</tr>
			</c:forEach>

		</table>
	</form>

</body>
</html>