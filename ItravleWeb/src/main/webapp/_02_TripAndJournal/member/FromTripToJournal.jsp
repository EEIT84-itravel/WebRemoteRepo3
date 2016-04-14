<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_05_Member.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	TripService tripService = new TripService();
	//memberId由session取出
	//MemberVO memberVO = (MemberVO) session.getAttribute("user");
	//int memberId = memberVO.getMemberId();
	//List<TripVO> tripVO = tripService.selectFromMember(memberId);
	List<TripVO> tripVO = tripService.selectFromMember(1);//測試時榜定memberID
	pageContext.setAttribute("tripVO", tripVO);
%>
<title>ITravel-從我的遊記選取</title>
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
		<form
			action="<c:url value="/_02_TripAndJournal/member/FromTripToJournal.controller"/>"
			method="post">
			<select name="tripId">
				<c:forEach var="tripVO" items="${tripVO}">
					<option value="${tripVO.tripId}">${tripVO.tripName}</option>
				</c:forEach>
			</select> <input type="submit">
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>