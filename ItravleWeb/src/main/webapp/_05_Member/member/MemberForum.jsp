<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="codeSvc" scope="page"
	class="_00_Misc.model.CodeService" />
<jsp:useBean id="MessageService" scope="page"
	class="_02_TripAndJournal.model.MessageService" />
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
	ForumService forumservice = new ForumService();
	//抓使用者ID
	MemberVO user = (MemberVO) session.getAttribute("user");
	int memberId = user.getMemberId();
	//尋找自己的討論區
	List<ForumVO> forumVO = forumservice.selectMemberForum(memberId);
	pageContext.setAttribute("forumVO", forumVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的討論區</title>
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
		<table id="forum" border="1">
			<thead>
				<tr id="forumTitle">
					<th>類型</th>
					<th>主題</th>
					<th>發表時間</th>
					<th>瀏覽人次</th>
					<th>回覆數</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty forumVO}">
					<c:forEach var="forumVO" items="${forumVO}">
						<tr>
							<c:forEach var="CodeVO" items="${codeSvc.all}">
											<c:if test="${CodeVO.codeId==forumVO.forumTypeId}">
										<td>${CodeVO.codeName}</td>
                             		</c:if>
										</c:forEach>
							<td><a href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO.forumId}"/>">${forumVO.forumTopic}</a>&nbsp;&nbsp;</td>
							<td>${forumVO.forumTime}</td>
							<td>${forumVO.visitorNum}</td>
							<%int i = 0;%>
									<c:forEach var="MessageVO" items="${MessageService.allNum}"
										varStatus="vs">
										<c:if test="${MessageVO.referenceNo==forumVO.forumId}">
											<%i++;%>
										</c:if>
									</c:forEach>
									<td><%=i%></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</article>
</body>
</html>