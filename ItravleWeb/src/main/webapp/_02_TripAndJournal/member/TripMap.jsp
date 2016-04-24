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
        height:100%;
	}
</style>
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
	console.log(latLngs);
		
	//第一組當起點
	var start= latLngs[0];
	console.log(start);
	latLngs.shift();
	//從latLngs取得終點
	var end = latLngs.pop();
	console.log(end);	


	function initMap() {
		directionsService = new google.maps.DirectionsService;
		directionsDisplay = new google.maps.DirectionsRenderer;
		var map = new google.maps.Map(document.getElementById('map'), {
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
</head>
<body>
	<div id="map"></div>

</body>
</html>
