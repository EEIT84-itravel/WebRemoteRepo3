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

<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- 最新編譯和最佳化的 JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
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
function doAlertBtn() {
	alertify.alert('此功能僅限會員使用，請先登入!!')
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
	<article class="center-block">	
		<form action="<c:url value="/_04_Forum/member/Reply.controller"/>"
			method="post">
			<div id="forumHead">
			<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				  <h3 style="color:darkblue">●${forumVO.forumTopic}</h3> <span class="error">${error.forumTopic}</span>
						<c:url value="/_04_Forum/member/FiltUrlServlet.controller"
							var="forum" scope="request">
							<c:param name="forumId" value="${forumVO.forumId}" />
							<c:param name="memberId" value="${user.memberId}" />
							<c:param name="crud" value="UpdateArticle" />
						</c:url>
						<!-- 用choose判斷，user是否登入，登入才可以進行某些功能，並且自己只能對自己的文章及留言進行刪跟修 -->
						<div style="margin-bottom: 8px">
							<c:choose>		
								<c:when test="${empty user}"><button type="button" class="btn btn-default" >回覆文章</button></c:when>
								<c:when test="${not empty user}"><input type="button" class="btn btn-default" value="回覆文章"  onclick="location.href='<c:url value="/_04_Forum/member/Reply.jsp?referenceNo=${forumVO.forumId}&memberId=${user.memberId}&crud=NewReply"/>'"></c:when>
							</c:choose>
							<c:if test="${flag}"> 
			                    <input type="button" class="btn btn-default" value="收藏文章" onclick="location.href='<c:url value="/_04_Forum/member/CollectionForum.controller?referenceType=${forumVO.forumId}&typeId=type_id05"/>'">
 		                    </c:if>
							<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==forumVO.memberId}"><a href="${forum}" class="btn btn-default">編輯文章</a></c:when>
							</c:choose>
							<c:choose>		
								<c:when test="${empty user}"></c:when>
								<c:when test="${user.memberId==forumVO.memberId}"><a href="javascript:if(confirm('確定要删除此文章嗎?'))location='<c:url value='/_04_Forum/member/WritingsServlet.controller?crud=Delete&forumId=${forumVO.forumId}&memberId=${user.memberId}'/>'" class="btn btn-default">删除文章</a>
								</c:when>
							</c:choose>					
					    </div>
				<table  id="forumBody">
					<tr>
						<td style="width: 120px;padding:8px;"><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${forumVO.memberId}" />" width="100px" height="100px"></td>
						<td><h4 style="color:green">作者：
						    <c:forEach var="MemberVO" items="${MemberService.all}">
								<c:if test="${MemberVO.memberId==forumVO.memberId}">
										${MemberVO.nickname}<br>
                             	</c:if>
							</c:forEach>
							最後修改日期：<fmt:formatDate value="${forumVO.forumTime}" timeStyle="short" type="both"/>
						</h4></td>
					</tr>
					
					<tr>
						<td colspan="2" style="padding:8px;"><h4>${forumVO.forumContent}</h4></td>
					</tr>
				</table>
				<table  id="messageBody" class="table">
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
						
							
						</tr>
						<tr>
							<td style="width: 100px;"><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${messageVO.memberId}" />" width="100px" height="100px"></td>
							<td>回文者：<c:forEach var="MemberVO"	items="${MemberService.all}">
								<c:if test="${MemberVO.memberId==messageVO.memberId}">
										${MemberVO.nickname}<br>
                             	</c:if>
								</c:forEach>回文時間：<fmt:formatDate value="${messageVO.updateTime}" timeStyle="short" type="both"/><br>
								<!-- 用choose判斷，user是否登入，登入才可以進行某些功能，並且自己只能對自己的文章及留言進行刪跟修 -->
								<c:choose>		
									<c:when test="${empty user}"><input type="button" value="回覆文章" class="btn btn-default" onclick="location.href='<c:url value="/_05_Member/Login.jsp"/>'"></c:when>
									<c:when test="${not empty user}"><input type="button" value="回覆文章" class="btn btn-default" onclick="location.href='<c:url value="/_04_Forum/member/Reply.jsp?referenceNo=${forumVO.forumId}&memberId=${user.memberId}&crud=NewReply"/>'"></c:when>
								</c:choose>
									<c:choose>		
									<c:when test="${empty user}"></c:when>
									<c:when test="${user.memberId==messageVO.memberId}"><a href="${reply}" class="btn btn-default">編輯留言</a></c:when>
								</c:choose>
								<c:choose>		
									<c:when test="${empty user}"></c:when>
									<c:when test="${user.memberId==messageVO.memberId}"><a class="btn btn-default" href="javascript:if(confirm('確定要删除此留言嗎?'))location='<c:url value='/_04_Forum/member/MessageServlet.controller?crud=Delete&messageId=${messageVO.messageId}&referenceNo=${forumVO.forumId}&memberId=${user.memberId}' />'">删除留言</a></c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding:8px;">${messageVO.content}<br></td>
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
