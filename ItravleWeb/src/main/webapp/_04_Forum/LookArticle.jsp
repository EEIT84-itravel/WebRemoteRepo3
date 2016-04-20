<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="MemberService" scope="page"
	class="_05_Member.model.MemberService" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${forumVO.forumTopic}</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript">
function confirmDeleteArticle(n,m) {
	if (confirm("確定刪除這篇文章 ? ") ) {		                           
		document.forms[0].action="<c:url value='/_04_Forum/member/WritingsServlet.controller?crud=Delete&forumId="+n+"&memberId="+m"'/>" ;
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
		<form action="<c:url value="/_04_Forum/member/Reply.controller"/>"
			method="post">
			<div id="forumHead">
				<table  id="forumBody">
					<c:import url="/_04_Forum/ForumHead.jsp"></c:import>

					<tr>
						<td>文章主題：${forumVO.forumTopic} <span class="error">${error.forumTopic}</span></td>
					</tr>
					<HR color="#00FF00" size="10" width="50%">
					<tr>
						<td>最後修改日期：<fmt:formatDate value="${forumVO.forumTime}" timeStyle="short" type="both"/></td>						
					</tr>				
					<tr>
						<c:url value="/_04_Forum/member/FiltUrlServlet.controller"
							var="forum" scope="request">
							<c:param name="forumId" value="${forumVO.forumId}" />
							<c:param name="memberId" value="${user.memberId}" />
							<c:param name="crud" value="UpdateArticle" />
						</c:url>
						<!-- 用choose判斷，user是否登入，登入才可以進行某些功能，並且自己只能對自己的文章及留言進行刪跟修 -->
							<td><c:choose>		
								<c:when test="${empty user}"><input type="button" value="回覆文章" onclick="location.href='<c:url value="/_05_Member/Login.jsp"/>'"></c:when>
								<c:when test="${not empty user}"><input type="button" value="回覆文章"  onclick="location.href='<c:url value="/_04_Forum/member/Reply.jsp?referenceNo=${forumVO.forumId}&memberId=${user.memberId}&crud=NewReply"/>'"></c:when>
							</c:choose>
							<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==forumVO.memberId}"><a href="${forum}">編輯文章</a></c:when>
							</c:choose>
							<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==forumVO.memberId}"><a href="javascript:if(confirm('確定要删除此文章嗎?'))location='<c:url value='/_04_Forum/member/WritingsServlet.controller?crud=Delete&forumId=${forumVO.forumId}&memberId=${user.memberId}'/>'">删除文章</a>
								</c:when>
							</c:choose></td>
					</tr>
					<tr>
						<td><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${forumVO.memberId}" />" width="100px" height="100px"><br>作者：<c:forEach
								var="MemberVO" items="${MemberService.all}">
								<c:if test="${MemberVO.memberId==forumVO.memberId}">
										${MemberVO.nickname}
                             		</c:if>
							</c:forEach></td>
					</tr>
					<tr>
						<td>文章內容：${forumVO.forumContent}</td>
					</tr>
					<tr>
						<td><input type="button" onclick="history.back()" value="上一頁" />
							<a href="/ItravleWeb/_04_Forum/ForumIndex.jsp">回討論區首頁</a></td>
					</tr>
				</table>

				<table border='1' id="messageBody">

					<c:forEach var="messageVO" items="${messageVO1}">
						<tr>
							<c:url value="/_04_Forum/member/FiltUrlServlet.controller"
								var="reply" scope="request">
								<c:param name="referenceNo" value="${forumVO.forumId}" />
								<c:param name="forumId" value="${forumVO.forumId}" />
								<c:param name="messageId" value="${messageVO.messageId}" />
								<c:param name="memberId" value="${user.memberId}" />
								<c:param name="crud" value="UpdateReply" />
							</c:url>
							<td>
							<!-- 用choose判斷，user是否登入，登入才可以進行某些功能，並且自己只能對自己的文章及留言進行刪跟修 -->
							<c:choose>		
								<c:when test="${empty user}"><input type="button" value="回覆文章" onclick="location.href='<c:url value="/_05_Member/Login.jsp"/>'"></c:when>
								<c:when test="${not empty user}"><input type="button" value="回覆文章"  onclick="location.href='<c:url value="/_04_Forum/member/Reply.jsp?referenceNo=${forumVO.forumId}&memberId=${user.memberId}&crud=NewReply"/>'"></c:when>
							</c:choose>
								<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==messageVO.memberId}"><a href="${reply}">編輯留言</a></c:when>
							</c:choose>
							<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==messageVO.memberId}"><a href="javascript:if(confirm('確定要删除此留言嗎?'))location='<c:url value='/_04_Forum/member/MessageServlet.controller?crud=Delete&messageId=${messageVO.messageId}&referenceNo=${forumVO.forumId}&memberId=${user.memberId}'/>'">删除留言</a></c:when>
							</c:choose></td>
							
						</tr>
						<tr>
							<td><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${messageVO.memberId}" />" width="100px" height="100px"><br>回文者：<c:forEach var="MemberVO"
									items="${MemberService.all}">
									<c:if test="${MemberVO.memberId==messageVO.memberId}">
										${MemberVO.nickname}
                             		</c:if>
								</c:forEach><span class="error">${error.messageTopic}</span></td>
						</tr>
						<tr>
							<td>回文時間：<fmt:formatDate value="${messageVO.updateTime}" timeStyle="short" type="both"/></td>					
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
