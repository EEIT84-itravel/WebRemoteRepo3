<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 外接程式碼 -->

<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="CodeService" scope="page"	class="_00_Misc.model.CodeService" />
<jsp:useBean id="MessageService" scope="page"	class="_02_TripAndJournal.model.MessageService" />
<jsp:useBean id="MemberService" scope="page"	class="_05_Member.model.MemberService" />
<%
	ForumService forumService = new ForumService();
 	List<ForumVO> forumVO = forumService.select();
 	pageContext.setAttribute("forumVOs", forumVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css"	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css"	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />

<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<script type="text/javascript"	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>

<script type="text/javascript">
	//DataTable設定
	var opt = {
		"iDisplayLength" : 15,
		"sDom" : '<"top"fp><"bottom"><"clear">',
		"oLanguage" : {
			"sProcessing" : "處理中...",
			"sLengthMenu" : "顯示 _MENU_ 項結果",
			"sZeroRecords" : "沒有匹配結果",
			"sInfo" : "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
			"sInfoEmpty" : "顯示第 0 至 0 項結果，共 0 項",
			"sInfoFiltered" : "(從 _MAX_ 項結果過濾)",
			"sSearch" : "關鍵字搜尋:",
			"oPaginate" : {
				"sFirst" : "首頁",
				"sPrevious" : "上一頁",
				"sNext" : "下一頁",
				"sLast" : "最末頁"
			}
		}
	};
	//datatable
	$(document).ready(function() {
		$("#forum").DataTable(opt);		
	})
</script>
<title>ITravel討論區</title>
</head>
<body style="background-image: url('../css/img/go.jpg')">

	<header>
		<!-- import共同的 -->
	</header>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article class="center-block">
			<div id="forumHead">
			<c:import url="/_04_Forum/ForumHead.jsp"></c:import>		
				<table id="forum"  class="table">
					<thead>
						<tr id="forumTitle">
							<th>類型</th>
							<th>討論主題</th>
							<th>作者</th>
							<th>人氣</th>
							<th>回應</th>
							<th>最後發表</th>
						</tr>
					</thead>
					<tbody>
					<!-- 如果一開始沒選任何分類標籤則顯示這個，反之顯示下面的forumVO1 -->
						<c:if test="${empty forumVO1s}">
							<c:forEach var="forumVO" items="${forumVOs}" begin="0" end="14">
								<tr>
									<td><c:forEach var="CodeVO" items="${CodeService.all}">
											<c:if test="${CodeVO.codeId==forumVO.forumTypeId}">
										${CodeVO.codeName}
                             		</c:if>
										</c:forEach></td>
									<td id="topic"><a
										href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO.forumId}" />">${forumVO.forumTopic}</a></td>
									<td>
									    <c:forEach var="MemberVO" items="${MemberService.all}">
											<c:if test="${MemberVO.memberId==forumVO.memberId}">${MemberVO.nickname}</c:if>
										</c:forEach>
									</td>
									<td>${forumVO.visitorNum}</td>
									<!-- 回文人數起始為0 -->
									<%int i = 0;%>
									<!-- 跑回圈，如果留言參考的文章ID跟文章ID相同，就加1個回覆人數 -->														
									<c:forEach var="MessageVO" items="${MessageService.allNum}"
										varStatus="vs">
										<c:if test="${MessageVO.referenceNo==forumVO.forumId}">
											<%i++;%>
										</c:if>
									</c:forEach>
									<td><%=i%></td>
									<td><fmt:formatDate value="${forumVO.forumTime}" timeStyle="short" type="both" /></td>
									
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${not empty forumVO1s}">
						<c:forEach var="forumVO1" items="${forumVO1s}" begin="0" end="14">
							<tr>
								<td><c:forEach var="CodeVO" items="${CodeService.all}">
										<c:if test="${CodeVO.codeId==forumVO1.forumTypeId}">
										${CodeVO.codeName}
                             		</c:if>
									</c:forEach></td>
								<td><a	href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO1.forumId}" />">${forumVO1.forumTopic}</a></td>
								<td>
								    <c:forEach var="MemberVO" items="${MemberService.all}">
											<c:if test="${MemberVO.memberId==forumVO1.memberId}">${MemberVO.nickname}</c:if>
									</c:forEach>
								</td>
								<td>${forumVO1.visitorNum}</td>
								<!-- 回文人數起始為0 -->
								<%int a = 0;%>
								<!-- 跑回圈，如果留言參考的文章ID跟文章ID相同，就加1個回覆人數 -->
								<c:forEach var="MessageVO2" items="${MessageService.allNum}"
									varStatus="vs">
									<c:if test="${MessageVO2.referenceNo==forumVO1.forumId}">
										<%a++;%>
									</c:if>
								</c:forEach>
								<td><%=a%></td>
								<td><fmt:formatDate value="${forumVO1.forumTime}" timeStyle="short" type="both"/></td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
	</article>

	
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
