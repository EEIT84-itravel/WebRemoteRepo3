<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="sightSvc" scope="page" class="_01_Sight.model.SightService" />
<!DOCTYPE html>
<html>
<head>
<title>ITravel-看行程</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">

<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/Trip.css"/>"/>
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
		<h1 class="h1">${tripVO.tripName}</h1>
		<div id="divTrip" class="pull-left">
			<div id="divTripTop">				
				<h5 class="h5">起始日期: ${tripVO.tripStartDate}</h5>
				<h5 class="h5">結束日期: ${tripVO.tripEndDate}</h5>
				<h5 class="h5">startTime: ${tripVO.startTime}</h5>
				<h5 class="h5">總預算: ${tripVO.totalBudget}</h5>
				<h5 class="h5">regionId: ${tripVO.regionId}</h5>
				<h5 class="h5">watchNum: ${tripVO.watchNum}</h5>
				<h5 class="h5">tripIntro: ${tripVO.tripIntro}</h5>
			</div>	<!-- end divTripTop -->
			<div id="divTripDetail">
				<c:forEach var="tripDetailVOs" items="${tripDetailVOs}" varStatus="vs">
					<div class="table-responsive">
					<table id="tableTrip" class="table table-bordered">
						<tr>
							<td hidden="true" rowspan="2" width="20">${tripDetailVOs.tripOrder}</td>						
							<td rowspan="2" width="120"><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${tripDetailVOs.referenceNo}" />" width="160" height="120"></td>
							<td hidden="true" rowspan="2" width="20">${tripDetailVOs.referenceNo}</td>
							<td>
							<c:forEach var="sightVO2" items="${sightSvc.all}">
	                            <c:if test="${sightVO2.sightId==tripDetailVOs.referenceNo}">
									<h4 class="text-left h4"><strong>${sightVO2.sightName}</strong></h4>
	                            </c:if>
							</c:forEach>
							停留時間：${tripDetailVOs.stayTime}<br>
							預算：${tripDetailVOs.sightBudget}元<br>
							</td>							
						</tr>
						<tr>
							<td>筆記：${tripDetailVOs.notes}</td>
						</tr>
						<tr hidden="true">						
							<c:forEach var="sightVO3" items="${sightSvc.all}">
                            	<c:if test="${sightVO3.sightId==tripDetailVOs.referenceNo}">
									<td><input type="hidden" name="lat" value="${sightVO3.latitude}"/></td>
									<td><input type="hidden" name="lng" value="${sightVO3.longitude}"/></td>
                             	</c:if>
							</c:forEach>
						</tr>						
					</table>
					</div>
					<c:if test="${not vs.last}">
						<div id="arrow">
						<span class="glyphicon glyphicon-chevron-down"></span>  <!-- 圖片來源：http://glyphicons.com/ -->
						</div>
					</c:if>				
				</c:forEach>			
			</div>	<!-- end divTripDetail -->
		</div>	<!-- end divTrip -->
		<div id="divTripMap" class="pull-right">
			<div id="tripMap"></div>
			<script type="text/javascript">
			var directionsService;
			var directionsDisplay;
			
			//取得所有的lat/lng
				var latArray=[];
				var lngArray=[];
				//取得所有的lat
				var lats = document.getElementsByName("lat");
				for (var j = 0; j < lats.length; j++) {
					var lat=lats[j].value;					
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
						lat: parseFloat(latArray[l]),
						lng: parseFloat(lngArray[l])
					});
				};		
					
				//第一組當起點
				var start= latLngs[0];				
				latLngs.shift();
				//從latLngs取得終點
				var end = latLngs.pop();				
// 				console.log(latLngs);			
			
				function initMap() {
					directionsService = new google.maps.DirectionsService;
					directionsDisplay = new google.maps.DirectionsRenderer;
					var map = new google.maps.Map(document.getElementById('tripMap'), {
						center : {
							lat : 25.100,
							lng : 121.510
						},
						zoom : 11,
						mapTypeId : google.maps.MapTypeId.ROADMAP
					});
					directionsDisplay.setMap(map);
					calculateAndDisplayRoute(directionsService, directionsDisplay);			
				}
			
				//規畫路徑
				function calculateAndDisplayRoute(directionsService, directionsDisplay) {			
					//經過地點
					var waypts = [];	
					//從左側畫面依照順序取得景點字串
					for (var i = 0; i < latLngs.length; i++) {
						waypts.push({
							location: latLngs[i],
							stopover: true
						});
					};		
			
					//規畫路徑請求
					directionsService.route({
						origin: start,
					    destination: end,
					    waypoints: waypts,
					    optimizeWaypoints: false,
					    travelMode: google.maps.TravelMode.DRIVING	//只能用DRIVING
					}, function(response, status) {
						//規畫路徑回傳結果
						if (status === google.maps.DirectionsStatus.OK) {
							directionsDisplay.setDirections(response);
					    } else {
							window.alert('Directions request failed due to ' + status);
					    }
					});
				}
			</script>
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA0Mlo6dd_r3AJczvlGoV0a3MjLTuirePg&callback=initMap"
       				async defer></script>
		</div>	<!-- end divTripMap -->		
		
		<div id="backURL"><h4 class="h4"><a href="<c:url value="/_02_TripAndJournal/TripIndex.jsp" />">回上一頁</a></h4></div>
	
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>