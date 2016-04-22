<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="TripDetailService" scope="page" class="_02_TripAndJournal.model.TripDetailService" />
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
TripService tripservice = new TripService();
MemberVO user = (MemberVO)session.getAttribute("user");
int memberId = user.getMemberId();
List<TripVO> tripVO = tripservice.selectFromMember(memberId);
pageContext.setAttribute("tripVO", tripVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/Member.css"/>" />
<title>ITravel-${user.nickname}的行程</title>
</head>
	<header>
		<!-- import共同的 -->
	</header>	
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article class="center-block">
	<h3>會員功能>我的行程</h3>
	<table class="table">
		<thead>
			<tr id="forumTitle">
				<th>行程照片</th>
				<th>行程名字</th>
				<th>起始日期</th>
				<th>最後修改時間</th>
				<th>人氣</th>
				<th>發佈狀態</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty tripVO}">
			<c:forEach var="tripVO" items="${tripVO}">
			<tr class="info">
				<td>
					<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}">
                    	<c:if test="${TripDetailVO.tripId==tripVO.tripId}">
							<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" width="160" height="120" class="img-rounded">
                        </c:if>
					</c:forEach>
				</td>
				<td>${tripVO.tripName}</td>
				<td>${tripVO.tripStartDate}</td>
				<td>${tripVO.modifyTime}</td>
				<td>${tripVO.watchNum}</td>
				<td>
			        <c:if test="${tripVO.post==false}">
					未發佈
					</c:if>		
					<c:if test="${tripVO.post==true}">
					已發佈
					</c:if>		
				</td>
				<td><a href="<c:url value="/_05_Member/member/changetriplpost.controller?tripId=${tripVO.tripId}"/>">改變發佈狀態</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_05_Member/member/tripfinddetail.controller?tripId=${tripVO.tripId}"/>">修改行程</a>&nbsp;&nbsp;</td>
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	</article>
<body>


</body>
</html>
