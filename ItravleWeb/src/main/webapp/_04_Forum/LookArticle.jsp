<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${forumVO.forumTopic}</title>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript">
function confirmDeleteArticle(n) {
	if (confirm("確定刪除這篇文章 ? ") ) {		                           
		document.forms[0].action="<c:url value='/_04_Forum/member/WritingsServlet.controller?crud=Delete&forumId="+n+"'/>" ;
		document.forms[0].method="POST";
		document.forms[0].submit();
	} else {
	
	}
}
function confirmDeleteMessage(n,m) {
	if (confirm("確定刪除這篇留言 ? ") ) {
		document.forms[0].action="<c:url value='/_04_Forum/member/MessageServlet.controller?crud=Delete&messageId="+n+"&referenceNo="+m+"'/>" ;
		document.forms[0].method="POST";
		document.forms[0].submit();
	} else {
	
	}
}
</script>

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
		<div id="forumHead">
			<table border="1">
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				<tr>
					<c:url value="/_04_Forum/member/ModifyArticle.jsp" var="forum"
						scope="request">
						<c:param name="forumId" value="${forumVO.forumId}" />
						<c:param name="visit" value="${forumVO.visitorNum}" />
						<c:param name="reply" value="${forumVO.replyNum}" />
						<c:param name="forumTopic" value="${forumVO.forumTopic}" />
						<c:param name="content" value="${forumVO.forumContent}" />
						<c:param name="forumType" value="${forumVO.forumTypeId}" />
						<c:param name="crud" value="Update" />
					</c:url>

					<td><input type="button" value="回覆文章" name="reply"
						onclick="location.href='<c:url value="/_04_Forum/member/Reply.jsp?referenceNo=${forumVO.forumId}&crud=NewReply"/>'"></td>
					<td><input type="button" value="編輯文章" name="modify"
						onclick="location.href='${forum}'" /></td>


					<td><input	type="button" value="刪除文章" name="delete"
							onclick="confirmDeleteArticle(${forumVO.forumId})"></td>
				</tr>
				<tr>
					<td>作者：${forumVO.memberId}</td>
				</tr>
				<tr>
					<td>文章主題：${forumVO.forumTopic} <span class="error">${error.forumTopic}</span></td>
				</tr>
				<tr>
					<td>文章內容：${forumVO.forumContent}</td>
				</tr>
				<tr>
					<td>最後修改日期：${forumVO.forumTime}</td>
				</tr>
				<tr>
					<td>回應人次：${count}</td>
				</tr>
				<tr>
					<td>文章編號：${forumVO.forumId}</td>
				</tr>
				<tr>
					<td><input type="button" onclick="history.back()" value="上一頁" />
						<a href="/ItravleWeb/_04_Forum/ForumIndex.jsp">回討論區首頁</a></td>
				</tr>
			</table>
			<table border='1'>

				<c:forEach var="messageVO" items="${messageVO1}">
					<tr>
						<c:url value="/_04_Forum/member/Reply.jsp" var="reply"
							scope="request">
							<c:param name="referenceNo" value="${forumVO.forumId}" />
							<c:param name="messageId" value="${messageVO.messageId}" />
							<c:param name="messageContent" value="${messageVO.content}" />
							<c:param name="crud" value="Update" />
						</c:url>
						<td>
						<input type="button" value="編輯留言"	onclick="location.href='${reply}'"> 
							<input	type="button" value="刪除留言"
								onclick="confirmDeleteMessage(${messageVO.messageId},${forumVO.forumId})">
					</tr>
					<tr>
						<td>回文者：${messageVO.memberId}<span class="error">${error.messageTopic}</span></td>
						<td>回文時間：${messageVO.updateTime}</td>
					</tr>
					<tr>
						<td>回覆內容：${messageVO.content}<br></td>
						<td>ID${messageVO.messageId}</td>
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
