<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_01_Sight.model.*"%>

<jsp:useBean id="codeSvc" scope="page"
	class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>景點資訊</title>
<!-- lightbox -->
<link rel="stylesheet" type="text/css"
	href="../css/_01_Sight/lightbox.min.css" />
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>

<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			event : "mouseover"
		});
		$("#collect").bind('click', collect);
	});
	function collect() {
		window.location.href = "../_01_Sight/member/CollectSight.controller?sightId="
				+ $("#sightId").val();
	};
</script>

<style>
html, body {
	height: 100%;
	margin: 0 auto;
	padding: 0;
}

#map {
	height: 400px;
	width: 600px;
	border: solid black;
}

.IntroSight {
	width: 600px;
	padding: 10px;
	margin: 10px;
	border: solid black;
	float: left;
}
</style>

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
		<div class="IntroSight">
			<a
				href="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
				rel="lightbox" title="${sightVO.sightName}"><img border="0"
				src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
				width="280" height="210"></a> <input type="hidden"
				value="${sightVO.sightId}" name="sightId" id="sightId">
			<p>地名:${sightVO.sightName}</p>
			<p>簡介:${sightVO.intro}</p>
			<p>
				類型:
				<c:forEach var="codeVO" items="${codeSvc.all}">
					<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								${codeVO.codeName}
                             </c:if>
				</c:forEach>
			</p>
			<p>門票:${sightVO.ticket}</p>
			<p>營業時間:${openTime}-${closeTime}</p>
			<p>建議停留時間:${sightVO.spendHour}</p>
			<p>
				建議旅行時段:
				<c:forEach var="codeVO" items="${codeSvc.all}">
					<c:if test="${codeVO.codeId==sightVO.playPeriod}">
								${codeVO.codeName}
                             </c:if>
				</c:forEach>
			</p>
			<p>地址:${sightVO.addr}</p>
			<p>交通方式</p>
			<p>${trans1}</p>
			<p>${trans2}</p>
		</div>

		<!-- 	 	google map -->
		<div id="map"></div>
		<script>
			function initMap() {

				var myLatLng = new google.maps.LatLng('${sightVO.latitude}',
						'${sightVO.longitude}');

				var map = new google.maps.Map(document.getElementById('map'), {
					zoom : 15,
					center : myLatLng
				});
				var marker = new google.maps.Marker({
					position : myLatLng,
					map : map,
				});
				var marker = new google.maps.Marker({
					position : myLatLng,
					map : map,
					title : '${sightVO.sightName}'
				});
			}
		</script>
		<script async defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDU9JCqlrRPTLXt7fvy9ERvO2EU1QPcO_0&signed_in=true&callback=initMap"></script>
		<!-- 		google map end -->
		<br>
		<!-- 		判斷收藏景點鈕是否出現 寫在SightServlet -->
		<c:if test="${flag}">
			<input type="button" value="收藏景點" id='collect'>
		</c:if>
		<input type="button" onclick="history.back()" value="上一頁" /> <a
			href="/ItravleWeb/_01_Sight/SightIndex.controller">回景點首頁</a>
		<!-- 		留言 -->
		<!-- 				<div id="tabs"> -->
		<!-- 					<ul> -->
		<!-- 						<li><a href="#tabs-1">相關行程</a></li> -->
		<!-- 						<li><a href="#tabs-2">相關遊記</a></li> -->
		<!-- 						<li><a href="#tabs-3">留言</a></li> -->
		<!-- 					</ul> -->
		<!-- 					<div id="tabs-1"> -->
		<!-- 						<p>台北小清新之旅</p> -->
		<!-- 					</div> -->
		<!-- 					<div id="tabs-2"> -->
		<!-- 						<p>我的遊記</p> -->
		<!-- 					</div> -->
		<!-- 					<div id="tabs-3"> -->
		<!-- 						<p>門票是不是漲價了</p> -->
		<!-- 					</div> -->
		<!-- 				</div> -->

	</article>

	<footer>
		<!-- import共同的 -->
	</footer>
	<script src="../js/lightbox.min.js"></script>
</body>
</html>
