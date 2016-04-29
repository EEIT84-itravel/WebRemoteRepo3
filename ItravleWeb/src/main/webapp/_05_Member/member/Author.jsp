<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="TripDetailService" scope="page" class="_02_TripAndJournal.model.TripDetailService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/Member.css"/>" />
<title>ITravel-作者作品一覽</title>
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
	<h3>會員功能>追蹤作者</h3>
		<h4 style="color:#cc33ff;font-weight:bold">${memberNickname}的行程一覽</h4>
		<table class="table">
			<c:if test="${not empty tripVO}">
				<thead>
					<tr>
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
							<td>
							<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}">
                    			<c:if test="${TripDetailVO.tripId==tripVO.tripId}">
									<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" width="160" height="120" class="img-rounded">
                        		</c:if>
							</c:forEach>
							</td>
							<td><a href="<c:url value="/_02_TripAndJournal/ShowTrip.controller?tripId=${tripVO.tripId}" />" >${tripVO.tripName}</a></td>
							<td>${tripVO.tripStartDate}</td>
							<td><fmt:formatDate value="${tripVO.modifyTime}" timeStyle="short" type="both" /></td>							
							<td>${tripVO.watchNum}</td>
						</tr>
					</c:if>
					</c:forEach>
				</tbody>
			</c:if>			
		</table>
		<h4 style="color:#cc33ff;font-weight:bold">${memberNickname}的遊記一覽</h4>
		<table class="table">
			<c:if test="${not empty journalVO}">
				<thead>
					<tr>
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
							<td>
								<img
								src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />"
								width="160" height="120" class="img-rounded">
							</td>
							<td><a href="<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${journalVO.journalId}" />">${journalVO.journalName}</a></td>
							<td>${journalVO.beginTime}</td>
							<td><fmt:formatDate value="${journalVO.modifyTime}" timeStyle="short" type="both" /></td>							
							<td>${journalVO.visitorNum}</td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</c:if>			
		</table>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
