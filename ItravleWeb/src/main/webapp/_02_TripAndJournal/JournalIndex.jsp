<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-遊記首頁</title>
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
		<h3>首頁>看遊記</h3>
		<c:if test="${not empty journalVOs}">
			<table border="1">
				<thead>
					<tr>
						<th>photo</th>
						<th>journalName</th>
						<th>beginTime</th>
						<th>memberId</th>
						<th>visitorNum</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="row" items="${journalVOs}">
						<tr>
							<td><img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${row.journalId}" />" width="240" height="180"></td>
							<td>${row.journalName}</td>
							<td>${row.beginTime}</td>
							<td>
								<c:forEach var="MemberVO" items="${MemberService.all}">
                             		<c:if test="${MemberVO.memberId==row.memberId}">
										${MemberVO.nickname}
                             		</c:if>
								</c:forEach>
							</td>
							<td>${row.visitorNum}</td>
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