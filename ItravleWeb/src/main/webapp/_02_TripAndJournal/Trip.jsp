<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-看行程</title>
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
		<div id="divTrip">
			<h3>tripName: ${tripVO.tripName}</h3>
			<p>tripStartDate: ${tripVO.tripStartDate}</p>
			<p>tripEndDate: ${tripVO.tripEndDate}</p>
			<p>startTime: ${tripVO.startTime}</p>
			<p>totalBudget: ${tripVO.totalBudget}</p>
			<p>regionId: ${tripVO.regionId}</p>
			<p>watchNum: ${tripVO.watchNum}</p>
			<p>tripIntro: ${tripVO.tripIntro}</p>
		</div>
		<div id="divTripDetail">
			<c:forEach var="tripDetailVOs" items="${tripDetailVOs}">
				<table>
					<tr>
						<td rowspan="2"><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${tripDetailVO.referenceNo}" />" width="120" height="90"></td>
						<td rowspan="2">${tripDetailVOs.referenceNo}</td>
						<td rowspan="2" class="sightName">
						<c:forEach var="sightVO2" items="${sightSvc.all}">
                            <c:if test="${sightVO2.sightId==tripDetailVOs.referenceNo}">
								${sightVO2.sightName}
                            </c:if>
						</c:forEach>
						</td>
						<td rowspan="2"></td>
						<td><label>行程順序：</label>${tripDetailVOs.tripOrder}<P/></td>
						<td><label>停留時間：</label>${tripDetailVOs.stayTime}</td>
						<td><label>預算：</label>${tripDetailVOs.sightBudget}"</td>
					</tr>
					<tr>
						<td colspan="4"><label>筆記：</label>${tripDetailVOs.notes}</td>
					</tr>							
				</table>						
			</c:forEach>			
		</div>
		
		
		
		
		<h4><a href="<c:url value="/_02_TripAndJournal/TripIndex.jsp" />">回上一頁</a></h4>
	
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>