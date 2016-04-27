<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 外接程式碼 -->
<%@ page import="java.util.*"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_03_Event.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%
	EventService eventService = new EventService();
	List<EventVO> eventVO = eventService.select();
	pageContext.setAttribute("eventVO", eventVO);

	TripService tripService = new TripService();
	List<TripVO> tripVOs = tripService.selectOrderByWatch();
	pageContext.setAttribute("tripVOs", tripVOs);

	JournalService journalService = new JournalService();
	List<JournalVO> journalVOs = journalService.selectOrderByWatch();
	pageContext.setAttribute("journalVOs", journalVOs);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel首頁</title>

<link rel="stylesheet" href="<c:url value="/css/jquery.skippr.css"/>">
<link rel="stylesheet" href="<c:url value="/css/index.css"/>">
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	//廣告輪播--屬性:按鈕.淡出.自動撥放.切換速度.自動撥放間隔時間
	$(function() {
		$('#skippr').skippr({
			navType : 'bubble',
			transition : 'fade',
			autoPlay : true,
			speed : 1000,
			autoPlayDuration : 5000
		});
	});

	$(function() {
		$("#dowebok").boxSlider({
			orientation: 'horizontal',
			speed: 3
		});
	});

</script>


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
		<!-- 活動輪播 -->
		<div style="text-align: center;">
			<h1 style="color: orange;font-family:sans-serif;">
				<strong>I-Travel首頁</strong>
			</h1>
		
		</div>
		<div id="container">
			<div id="skippr">
				<a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=7" />">
				<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=7"/>" style="height: 400px; width: 900px;"></a>
			    <a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=8" />">
			    <img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=14"/>" style="height: 400px; width: 900px;"></a> 
				<a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=10" />">
				<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=15"/>" style="height: 400px; width: 900px;"></a>
				<a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=11" />">
				<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=8"/>" style="height: 400px; width: 900px;"></a>
				<a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=12" />">
				<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=10"/>" style="height: 400px; width: 900px;"></a>
			</div>
			<div id="hotSight"><span class="glyphicon glyphicon-fire"></span>&nbsp;熱門景點</div>
<!-- 熱門景點 -->
			<div class="wrap">
				<div class="box-slider" id="dowebok">	  
					<a href="javascript:" class="box-slider-seta-left" ></a>
					<div class="box-slider-content">
						<div class="box-slider-move">
							<div class="item first"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=1" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=1" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=5" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=5" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=14" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=14" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=298" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=298" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=15" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=15" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=24" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=24" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=296" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=296" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=433" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=433" />'"></span></div>
							<div class="item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=292" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=292" />'"></span></div>
							<div class="item last-item"><span><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=432" />"  width="160px" height="160px" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=432" />'"></span></div>
						</div>
					</div>
					<a href="javascript:" class="box-slider-seta-right"></a>
				</div>
			</div>
<!-- 熱門景點end -->
			<div style="height: 10px"></div>
			<div id="hotTrip" class="pull-left">
				<h3 class="info"><span class="glyphicon glyphicon-fire"></span>&nbsp;熱門行程<small style="color:red">&nbsp;&nbsp;&nbsp;人氣排行!!</small></h3>
				<h5 class="hrL">﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌</h5>
				<ul>
					<c:forEach var="tripVO" items="${tripVOs}" begin="0" end="8">
					
				          <li><a href="<c:url value="/_02_TripAndJournal/ShowTrip.controller?tripId=${tripVO.tripId}"/>">${tripVO.tripName}</a></li>
					</c:forEach>
				</ul>
				<input type="button" value="看全部"
					onclick="location.href='<c:url value="/_02_TripAndJournal/TripIndex.jsp"/>'"
					class="btn btn-primary pull-right">
			</div>
			
			<!-- end hotTrip -->

			<div id="hotJournal" class="pull-left">
				<h3 class="info"><span class="glyphicon glyphicon-fire"></span>&nbsp;熱門遊記<small style="color:red">&nbsp;&nbsp;&nbsp;人氣排行!!</small></h3>
				<h5 class="hrL">﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌</h5>
				<ul>
					<c:forEach var="journalVO" items="${journalVOs}" begin="0" end="8">
				          <li><a href="<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${journalVO.journalId}"/>">${journalVO.journalName}</a></li>
					</c:forEach>
				</ul>
				<input type="button" value="看全部"
					onclick="location.href='<c:url value="/_02_TripAndJournal/JournalIndex.jsp"/>'"
					class="btn btn-primary pull-right">
			</div>
			
			<!-- end hotJournal -->

			<div id="event" class="pull-left">
				<h3 class="info"><span class="glyphicon glyphicon-bullhorn"></span>&nbsp;近期活動</h3>
				<h5 class="hrL">﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌﹌</h5>
				<ul>
					<c:forEach var="eventVO" items="${eventVO}" begin="0" end="3">
						<li><a
							href="<c:url value="/_03_Event/ShowEvent.controller?eventId=${eventVO.eventId}" />">${eventVO.eventTopic}&nbsp;&nbsp;<small style="color:red">${eventVO.eventStartDate}~${eventVO.eventEndDate}</small></a></li>
					</c:forEach>
				</ul>
				<div style="height: 20px;"></div>
				<input type="button" value="看更多"
					onclick="location.href='<c:url value="/_03_Event/AllEvent.jsp"/>'"
					class="btn btn-primary pull-right">
			</div>
			<!-- end event -->
	        <div style="height: 20px"></div>
		</div>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
