<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<jsp:useBean id="SightService" scope="page" class="_01_Sight.model.SightService" />
<%@page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%
CodeService codeService = new CodeService();
List<CodeVO> codeVO = codeService.select("region");
pageContext.setAttribute("regions", codeVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${showJournalVO.journalName}</title>

<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/Journal.css"/>" />
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
		<h1 style="color: red;">${showJournalVO.journalName}</h1>

			
		<div id="divJournal" class="pull-left">
		<form action="<c:url value="/_02_TripAndJournal/member/ModifyJournal.controller?crud=Update&journalId=${showJournalVO.journalId}"/>" method="post">
			<input type="submit" name="modifyJournal" value="修改遊記">
			<div id="divMember">
				<table id="member" class="table table-bordered">
				<tr>
					<td class="memberPic"><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${showJournalVO.memberId}" />"
						width="100px" height="100px">
					<td>

						<ul style="list-style-type: none;">
							<li><c:forEach var="MemberVO" items="${MemberService.all}">
									<c:if test="${MemberVO.memberId==showJournalVO.memberId}">
										<h3 style="color: green">作者：${MemberVO.nickname}</h3>
									</c:if>
								</c:forEach></li>
							<li>遊玩日期：${showJournalVO.beginTime}~${showJournalVO.endTime}</li>
							<c:forEach var="region" items="${regions}">
								<c:if test="${region.codeId==showJournalVO.regionId}">
									<li>地區:${region.codeName}</li>	
								</c:if>
							</c:forEach>	
							<li>瀏覽人次: ${showJournalVO.visitorNum}</li>
							<li>遊記簡介: ${showJournalVO.journalIntro}</li>
						</ul>
				</tr>
			</table>
        </div><!-- 結束divMember  -->
			<div id="divJournalDetail">
				<c:forEach var="showJournalDetailVO" items="${showJournalDetailVO}">
					<div class="table-responsive">
						<table id="journalTable" class="table table-bordered">
							<tr>
								<c:forEach var="sightVO" items="${SightService.all}">
									<c:if test="${showJournalDetailVO.sightId==sightVO.sightId}">
										<td><h3 style="color: blue" class="fMargin">
												<strong>${sightVO.sightName}</strong>
											</h3></td>
									</c:if>
								</c:forEach>
							</tr>
							<tr>
								<td class="journalPic"><img
									src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${showJournalDetailVO.sightId}" />"
									width="300" height="220"></td>

								<td><h4 class="fMargin">景點遊記：</h4>
									<br> ${showJournalDetailVO.sightJournal}</td>
							</tr>
							<tr hidden="true">
								<c:forEach var="sightVO3" items="${SightService.all}">
									<c:if test="${sightVO3.sightId==showJournalDetailVO.sightId}">
										<td><input type="hidden" name="lat"
											value="${sightVO3.latitude}" /></td>
										<td><input type="hidden" name="lng"
											value="${sightVO3.longitude}" /></td>
									</c:if>
								</c:forEach>
							</tr>
						</table>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- End  DivJournal -->
		<div id="divTripMap">
			<div id="tripMap"></div>
			<script type="text/javascript">
				var directionsService;
				var directionsDisplay;

				//取得所有的lat/lng
				var latArray = [];
				var lngArray = [];
				//取得所有的lat
				var lats = document.getElementsByName("lat");
				for (var j = 0; j < lats.length; j++) {
					var lat = lats[j].value;
					latArray.push(lat);
				};
				console.log(lats[0].value);
				//取得所有的lng
				var lngs = document.getElementsByName("lng");
				for (var k = 0; k < lngs.length; k++) {
					var lng = lngs[k].value;
					lngArray.push(lng);
				};

				var latLngs = [];
				for (var l = 0; l < latArray.length; l++) {
					latLngs.push({
						lat : parseFloat(latArray[l]),
						lng : parseFloat(lngArray[l])
					});
				};

				//第一組當起點
				var start = latLngs[0];
				latLngs.shift();
				//從latLngs取得終點
				var end = latLngs.pop();
				// 				console.log(latLngs);			

				function initMap() {
					directionsService = new google.maps.DirectionsService;
					directionsDisplay = new google.maps.DirectionsRenderer;
					var map = new google.maps.Map(document
							.getElementById('tripMap'), {
						center : {
							lat : 25.100,
							lng : 121.510
						},
						zoom : 11,
						mapTypeId : google.maps.MapTypeId.ROADMAP
					});
					directionsDisplay.setMap(map);
					calculateAndDisplayRoute(directionsService,
							directionsDisplay);
				}

				//規畫路徑
				function calculateAndDisplayRoute(directionsService,
						directionsDisplay) {
					//經過地點
					var waypts = [];
					//從左側畫面依照順序取得景點字串
					for (var i = 0; i < latLngs.length; i++) {
						waypts.push({
							location : latLngs[i],
							stopover : true
						});
					}
					;
					//規畫路徑請求
					directionsService.route({
						origin : start,
						destination : end,
						waypoints : waypts,
						optimizeWaypoints : false,
						travelMode : google.maps.TravelMode.DRIVING
					//只能用DRIVING
					}, function(response, status) {
						//規畫路徑回傳結果
						if (status === google.maps.DirectionsStatus.OK) {
							directionsDisplay.setDirections(response);
						} else {
							window.alert('Directions request failed due to '
									+ status);
						}
					});
				}
			</script>
			<script
				src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA0Mlo6dd_r3AJczvlGoV0a3MjLTuirePg&callback=initMap"
				async defer></script>
		</div>
		<!-- end divTripMap -->
		<div id="backURL">
			<h4 class="h4">
				<a href="<c:url value="/_02_TripAndJournal/JournalIndex.jsp" />">回上一頁</a>
			</h4>
		</div>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
