<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
	
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>作者作品一覽</title>
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
		<h3>行程一覽</h3>
		<table id="forum" border="1">
			<c:if test="${not empty tripVO}">
				<thead>
					<tr id="forumTitle">
						<th>行程照片</th>
						<th>行程名字</th>
						<th>起始日期</th>
						<th>最後修改時間</th>
						<th>人氣</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="tripVO" items="${tripVO}">
					<c:if test="${tripVO.post==true}">
						<tr>
							<td><img
								src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?tripId=${tripVO.tripId}" />"
								width="240" height="180"></td>
							<td><a href="<c:url value="/_02_TripAndJournal/ShowTrip.controller?tripId=${tripVO.tripId}" />">${tripVO.tripName}</a>&nbsp;&nbsp;</td>
							<td>${tripVO.tripStartDate}</td>
							<td>${tripVO.modifyTime}</td>
							<td>${tripVO.watchNum}</td>
						</tr>
						</c:if>
					</c:forEach>
			</c:if>
			</tbody>
		</table>
		<h3>遊記一覽</h3>
		<table id="forum" border="1">
			<c:if test="${not empty journalVO}">
				<thead>
					<tr id="forumTitle">
						<th>遊記照片</th>
						<th>遊記名字</th>
						<th>起始日期</th>
						<th>最後修改時間</th>
						<th>人氣</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="journalVO" items="${journalVO}">
					<c:if test="${journalVO.post==true}">
						<tr>
							<td><img
								src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />"
								width="240" height="180"></td>
							<td>${journalVO.journalName}</td>
							<td>${journalVO.beginTime}</td>
							<td>${journalVO.modifyTime}</td>
							<td>${journalVO.visitorNum}</td>
						</tr>
						</c:if>
					</c:forEach>
			</c:if>
			</tbody>
		</table>
	</article>
</body>
</html>