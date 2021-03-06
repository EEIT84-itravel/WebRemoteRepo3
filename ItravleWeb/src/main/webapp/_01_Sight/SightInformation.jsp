<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_01_Sight.model.*"%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<jsp:useBean id="TripDetailService" scope="page" class="_02_TripAndJournal.model.TripDetailService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-景點資訊</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- lightbox -->
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_01_Sight/lightbox.min.css" />" />
<%-- <link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/> --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_01_Sight/SightInformation.css"/>"/>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			event : "click"
		});
		$("#collect").bind('click', collect);
	});
	function collect() {
		window.location.href = "../_01_Sight/member/CollectSight.controller?sightId="+ $("#sightId").val();
	};
</script>
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
		<div id="IntroSight">
			<a href="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" rel="lightbox" title="${sightVO.sightName}">
			<img border="0" src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" width="280" height="210"></a>
			<input type="hidden" value="${sightVO.sightId}" name="sightId" id="sightId">
			
			<h2>${sightVO.sightName}	<!-- 判斷收藏景點鈕是否出現 寫在SightServlet -->
				<c:if test="${flag}">
				
				<button type="button" id='collect' class="btn btn-lg btn-default"><span class="glyphicon glyphicon-heart" style="color:red;"></span>收藏景點</button>
				</c:if>
			</h2>
			<p>　　${sightVO.intro}</p>
			<p>
				類型：
				<c:forEach var="codeVO" items="${codeSvc.all}">
					<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								${codeVO.codeName}
                    </c:if>
				</c:forEach>
			</p>
			<p>門票：${sightVO.ticket}</p>
			<p>營業時間：${openTime}-${closeTime}</p>
<%-- 			<p>建議停留時間：${sightVO.spendHour}</p> --%>
			<p>
				建議旅行時段：
				<c:forEach var="codeVO" items="${codeSvc.all}">
					<c:if test="${codeVO.codeId==sightVO.playPeriod}">
						${codeVO.codeName}
                    </c:if>
				</c:forEach>
			</p>
			<p>地址：${sightVO.addr}</p>
			<p>交通方式　-　${trans}</p>
						<div id="tabss">
						<div id="tabs">
							<ul>
								<li><a href="#tabs-1">相關行程</a></li>
								<li><a href="#tabs-2">相關遊記</a></li>
								<li><a href="#tabs-3">相關活動</a></li>
								<li><a href="#tabs-4">留言</a></li>
							</ul>
							<div id="tabs-1"><!-- tab 相關行程 -->
									<c:if test="${empty tripVOs}">
										目前尚無相關行程
									</c:if>
							<table class="table">
								<c:forEach var="tripVO" items="${tripVOs}" end="4"><!-- "4"為顯示5筆  -->
								<c:if test="${tripVO.post==true}"><!-- 狀態是已發布 -->
								<tr>
								<td>
									<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}" >
	                             		<c:if test="${TripDetailVO.tripId==tripVO.tripId}">
											<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" width="88" height="66">
	                             		</c:if>
									</c:forEach>
								</td>
								<td><a href="<c:url value="/_02_TripAndJournal/ShowTrip.controller?tripId=${tripVO.tripId}" />" >${tripVO.tripName}</a></td>
								<td>
									<c:forEach var="MemberVOt" items="${MemberService.all}">
                             			<c:if test="${MemberVOt.memberId==tripVO.memberId}">
											${MemberVOt.nickname}
                             			</c:if>
									</c:forEach>
								</td>
								<td>有${tripVO.watchNum}人瀏覽過</td>
								</tr>
								</c:if>
								</c:forEach>
							</table>
						</div>
						<div id="tabs-2"><!-- tab 相關遊記 -->
							<c:if test="${empty journalVOs}">
							目前尚無相關遊記
							</c:if>
							<table class="table">
							<c:forEach var="journalVO" items="${journalVOs}" end="4"><!-- "4"為顯示5筆  -->
							<c:if test="${journalVO.post==true}"><!-- 狀態是已發布 -->
							<tr>
								<td><img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />" width="88" height="66"></td>
								<td><a href="<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${journalVO.journalId}" />">${journalVO.journalName}</a></td>
									<c:forEach var="MemberVOj" items="${MemberService.all}">
	                             		<c:if test="${MemberVOj.memberId==journalVO.memberId}">
											<td>${MemberVOj.nickname}</td>
	                             		</c:if>
									</c:forEach>
								<td>有${journalVO.visitorNum}人瀏覽過</td>
							</tr>
							</c:if>
							</c:forEach>
							</table>
							</div>
							<div id="tabs-3"><!-- tab 相關活動 -->
								<c:if test="${empty eventVOs}">
									目前尚無相關活動
								</c:if>
							<table class="table">
							<c:forEach var="eventVO" items="${eventVOs}">
								<c:if test="${eventVO.eventRemoved==false}"><!-- 狀態是未下架 -->
								<tr>
									<td><a href="<c:url value='/_03_Event/ShowEvent.controller?eventId=${eventVO.eventId}' />">${eventVO.eventTopic}</a></td>
									<td>由${eventVO.eventStartDate}至${eventVO.eventEndDate}</td>
								</tr>
								</c:if>
							</c:forEach>
							</table>
							</div>
							<div id="tabs-4"><!-- tab 留言 -->
								<c:if test="${empty messageVOs}">
									目前尚無相關留言
								</c:if>
							<table class="table">
							<c:forEach var="messageVO" items="${messageVOs}">
								<tr>
									<td>${messageVO.content}</td>
										<c:forEach var="MemberVOm" items="${MemberService.all}">
	                             			<c:if test="${MemberVOm.memberId==messageVO.memberId}">
												<td>${MemberVOm.nickname}</td>
	                             			</c:if>
										</c:forEach>
										
									<td><fmt:formatDate value="${messageVO.updateTime}" timeStyle="short" type="both" /></td>
								</tr>
							</c:forEach>
						</table>
						<form action="<c:url value="/_01_Sight/member/SightReplyServlet.controller" />" method="post">
						<table>
							<tr>
								<td>
									<input type="hidden" name="referenceNo" value="${sightVO.sightId}">
									<input type="hidden" name="type" value="type_id01">
								</td>
							</tr>
							<tr>
								<td>
									<textarea id="replyTextarea" name="reply" placeholder="請留言">${param.reply}</textarea>
								</td>
							</tr>
							<tr>
								<td>
									<span>${error.reply}</span>
								</td>
							</tr>
							<tr>
								<td>
									<input type="submit" value="確定送出" style="color:black">
								</td>
							</tr>
						</table>
						</form>	
					</div><!-- tab 留言 end-->
				</div><!-- tabs 留言 end-->
			</div><!-- tabss 留言 end-->
		</div><!-- rightside end -->
		<!-- 	 	google map -->
		<div id="map"></div>
		<script>
			function initMap() {
				var myLatLng = new google.maps.LatLng('${sightVO.latitude}','${sightVO.longitude}');
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom : 16,
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
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDU9JCqlrRPTLXt7fvy9ERvO2EU1QPcO_0&signed_in=true&callback=initMap"></script>
		<!-- 		google map end -->
		<div id="pageBottom">
			<input type="button" onclick="history.back()" value="上一頁" class="bottomInner" /> 
			<a href="<c:url value="/_01_Sight/SightIndex.jsp" />" class="bottomInner">回景點首頁</a>
		</div>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
	<script src="../js/lightbox.min.js"></script>
</body>
</html>
