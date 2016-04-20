<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 外接程式碼 -->

<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="CodeService" scope="page"
	class="_00_Misc.model.CodeService" />
<jsp:useBean id="MessageService" scope="page"
	class="_02_TripAndJournal.model.MessageService" />
<jsp:useBean id="MemberService" scope="page"
	class="_05_Member.model.MemberService" />
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
<link rel="stylesheet" type="text/css"	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css"	href="../css/_04_Forum/datatable.css" />
<link rel="stylesheet" type="text/css"	href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />

<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript"	src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript"	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
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
<script type="text/javascript">

	var str = document.getElementById("topic");


</script>
<title>ITravel討論區</title>
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
		<form method="post">
			<div id="forumHead">
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				
				<table id="forum" border="1">
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
						<c:if test="${empty forumVO1}">
							<c:forEach var="forumVO" items="${forumVO}">
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
									<%int i = 0;%>
									<c:forEach var="MessageVO" items="${MessageService.allNum}"
										varStatus="vs">
										<c:if test="${MessageVO.referenceNo==forumVO.forumId}">
											<%i++;%>
										</c:if>
									</c:forEach>
									<td><%=i%></td>
									<td><fmt:formatDate value="${forumVO.forumTime}" timeStyle="full" type="time" pattern="yyyy-MM-dd hh:mm"/></td>
									
								</tr>
							</c:forEach>
						</c:if>
						<c:forEach var="forumVO1" items="${forumVO1}">
							<tr>
								<td><c:forEach var="CodeVO" items="${CodeService.all}">
										<c:if test="${CodeVO.codeId==forumVO1.forumTypeId}">
										${CodeVO.codeName}
                             		</c:if>
									</c:forEach></td>
								<td><a
									href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO1.forumId}" />">${forumVO1.forumTopic}</a></td>
								<td>
								    <c:forEach var="MemberVO" items="${MemberService.all}">
											<c:if test="${MemberVO.memberId==forumVO1.memberId}">${MemberVO.nickname}</c:if>
									</c:forEach>
								</td>
								<td>${forumVO1.visitorNum}</td>
								<%int a = 0;%>
								<c:forEach var="MessageVO2" items="${MessageService.allNum}"
									varStatus="vs">
									<c:if test="${MessageVO2.referenceNo==forumVO1.forumId}">
										<%a++;%>
									</c:if>
								</c:forEach>
								<td><%=a%></td>
								<td><fmt:formatDate value="${forumVO1.forumTime}" pattern="yyyy-MM-dd hh:mm"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
