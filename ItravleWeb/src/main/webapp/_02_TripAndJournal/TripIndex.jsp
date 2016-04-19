<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="TripDetailService" scope="page" class="_02_TripAndJournal.model.TripDetailService" />
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<title>ITravel-行程首頁</title>
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
	<article class="center-block">
	<h3>首頁>看行程</h3>
		<c:if test="${not empty tripVOs}">
			<table border="1">
				<thead>
					<tr>
						<th>photo</th>
						<th>tripName</th>
						<th>tripStartDate</th>
						<th>memberId</th>
						<th>watchNum</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="row" items="${tripVOs}">
						<tr>
							<td>
								<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}">
                             		<c:if test="${TripDetailVO.tripId==row.tripId}">
										<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" width="240" height="180">
                             		</c:if>
								</c:forEach>
							</td>
							<td>${row.tripName}</td>
							<td>${row.tripStartDate}</td>
							<td>
								<c:forEach var="MemberVO" items="${MemberService.all}">
                             		<c:if test="${MemberVO.memberId==row.memberId}">
										${MemberVO.nickname}
                             		</c:if>
								</c:forEach>
							</td>
							<td>${row.watchNum}</td>
							<c:url value="/_02_TripAndJournal/ShowTrip.controller" var="path" scope="page">
								<c:param name="tripId" value="${row.tripId}" />									
							</c:url>
							<td><input type="button" value="看更多" onclick="location.href='${path}'"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>