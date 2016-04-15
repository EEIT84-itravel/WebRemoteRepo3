<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<title>ITravel-SightDetail</title>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
#dialog-form{
color: white;
}
#map {
	height: 250px;
	width: 480px;
	margin: 0 auto; } 
</style>
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<script>
var sightLat;
var sightLng;
var sightName;
	$(document).ready(function() {
		sightLat = $("#myLat").text()-0;
		sightLng = $("#myLng").text()-0;
		sightName=$("#mySight").text();
	});
	var map;
	function initMap() {
		var myLatLng={lat: sightLat, lng: sightLng};
		map = new google.maps.Map(document.getElementById('map'), {
			center : myLatLng,
			zoom : 16
		});
		var marker=new google.maps.Marker({position:myLatLng,map:map,title:sightName})
	}
</script>
	<script src="https://maps.googleapis.com/maps/api/js?callback=initMap" async defer></script>
</head>
<body>
	<h3>${error.sightDetail}</h3>	<!--錯誤處理  -->
	<c:if test="${not empty sightVO}">
    <div id="map"></div>
	<div id="dialog-form" title="SightDetail">
 			<form class="sightDetailForm">
				<fieldset>						
							<label>名稱；</label><span id="mySight">${sightVO.sightName}</span><br>
							<label>地區；</label> 
							<c:forEach var="codeVO" items="${codeSvc.all}">
									<c:if test="${codeVO.codeId==sightVO.regionId}">
								            <span>${codeVO.codeName}</span><br>
                                	 </c:if>
							</c:forEach>
							<label>縣市；</label> 
							<c:forEach var="codeVO" items="${codeSvc.all}">
									<c:if test="${codeVO.codeId==sightVO.countyId}">
								             	<span>${codeVO.codeName}</span><br>
                                	  </c:if>
							</c:forEach>
							<label>景點類型；</label> 
							<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								             	<span>${codeVO.codeName}</span><br>
                                	    </c:if>
							</c:forEach>
							<label>門票；</label> <span>${sightVO.ticket}</span><br>
							<label>開門時間；</label> <span>${sightVO.openTime}</span><br>
							<label>關門時間；</label> <span>${sightVO.closeIime}</span><br>
							<label>建議停留時間；</label> <span>${sightVO.spendHour}</span><br>
							<label>建議旅行時段；</label>
							<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.playPeriod}">
								             	<span>${codeVO.codeName}</span><br>
                                	    </c:if>
							</c:forEach>
							<label>評分；</label> <span>${sightVO.score}</span><br> 
							<!-- 經緯度隱藏欄位 -->
							<span id="myLng" hidden="true">${sightVO.longitude}</span>
							<span id="myLat" hidden="true">${sightVO.latitude}</span>
							<label>瀏覽人次；</label><span>${sightVO.watchNum}</span><br> 
							<label>收藏人次；</label><span>${sightVO.collectNum}</span><br>
							<label>電話；</label><span>${sightVO.phone}</span><br>
							<label>地址；</label> <span>${sightVO.addr}</span><br>
							<label>交通方式；</label> <span>${sightVO.trans}</span><br> 
							<label>上次更新時間；</label><span>${sightVO.modifyTime}</span><br> 
					</fieldset>
			</form>
	</div>
	</c:if>
</body>
</html>