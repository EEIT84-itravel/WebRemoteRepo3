<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
TripService tripservice = new TripService();
CollectionService collectionservice = new CollectionService();
//抓使用者ID
MemberVO user = (MemberVO)session.getAttribute("user");
int memberId = user.getMemberId();
//找出收藏且已發布的行程們
ArrayList<TripVO> tripVO = collectionservice.selectTripCollectionByMemberId(memberId);
pageContext.setAttribute("tripVO", tripVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的收藏行程</title>
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
				    <th>行程照片</th>
					<th>行程名字</th>
					<th>起始日期</th>
					<th>最後修改時間</th>
					<th>人氣</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty tripVO}">
			<c:forEach var="tripVO" items="${tripVO}">
			<tr>
			<td><img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?tripId=${tripVO.tripId}" />" width="240" height="180"></td>
			<td>${tripVO.tripName}</td>
			<td>${tripVO.tripStartDate}</td>
			<td>${tripVO.modifyTime}</td>
			<td>${tripVO.watchNum}</td>
			<td><a href="<c:url value="/_05_Member/member/deltrip.controller?memberId=${user.memberId}&referenceType=${tripVO.tripId}&typeId=type_id02"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
			</tr>
			</c:forEach>
			</c:if>
			</tbody>
</table>
</article>
</body>
</html>