<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Trip Map</title>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<style>
	#map {
        height: 100%;
	}
</style>
<script type="text/javascript">

var map;
function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: -34.397, lng: 150.644},
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.TERRAIN
	});
  
	var flightPlanCoordinates = [
 		{lat: 37.772, lng: -122.214},
		{lat: 21.291, lng: -157.821},
		{lat: -18.142, lng: 178.431},
		{lat: -27.467, lng: 153.027}
	];
	
	var flightPath = new google.maps.Polyline({
		path: flightPlanCoordinates,
		geodesic: true,
		strokeColor: '#FF0000',
		strokeOpacity: 1.0,
		strokeWeight: 2
	});

	flightPath.setMap(map);
}

</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA0Mlo6dd_r3AJczvlGoV0a3MjLTuirePg&callback=initMap"
        async defer></script>
</head>
<body>
	<div id="map"></div>

</body>
</html>