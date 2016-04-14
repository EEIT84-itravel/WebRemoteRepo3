<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Trip Map</title>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
	#map {
        width:100%;
        height: 500px;
	}
</style>
<script type="text/javascript">
//取得畫面上的景點名稱順序?!?!
// var sightNames = $("td.sightName").each(function(){
// 	thisSight=$(this).css("color","red");

// });
// var sightNames = $("td.sightName").toArray();
// console.log(sightNames);

var directionsService;
var directionsDisplay;

function initMap() {
	directionsService = new google.maps.DirectionsService;
	directionsDisplay = new google.maps.DirectionsRenderer;
	var map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: 25.100, lng: 121.510},
		zoom: 11,
	 	mapTypeId: google.maps.MapTypeId.ROADMAP
	});
	directionsDisplay.setMap(map);

	calculateAndDisplayRoute(directionsService, directionsDisplay);

}

//規畫路徑
function calculateAndDisplayRoute(directionsService, directionsDisplay) {
	
	//經過地點
	var waypts = [];
	//從session依照順序取得景點字串?
	var locationArray = ["台中市政府", "台中火車站"];
	for (var i = 0; i < locationArray.length; i++) {
		waypts.push({
			location: locationArray[i],
			stopover: true
		});
	};
	
	//規畫路徑請求
	directionsService.route({
		origin: '台中市西區五權路50號',	//改從session接
	    destination: '台中市體育場',	//改從session接
	    waypoints: waypts,
	    optimizeWaypoints: true,
	    travelMode: google.maps.TravelMode.DRIVING	//改從session接?
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
</head>
<body>
	<div id="map"></div>

</body>
</html>