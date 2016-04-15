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
        height: 700px;
	}
</style>
<script type="text/javascript">
var directionsService;
var directionsDisplay;
var locationArray=[];
// 取得中間的景點名稱
var thisSight;
$("td.sightName").each(function(){
	thisSight = $(this).text().trim();
	locationArray.push(thisSight);
// 	console.log(thisSight);
});
console.log(locationArray);
//從locationArray取得起點
var start= locationArray[0];
console.log(start);
locationArray.shift();
//從locationArray取得終點
var end = locationArray.pop();
console.log(end);

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
// 	var locationArray = ["臺北101購物中心" ,"五分埔商圈", "饒河街觀光夜市"];
	//從左側畫面依照順序取得景點字串
	for (var i = 0; i < locationArray.length; i++) {
		waypts.push({
			location: locationArray[i],
			stopover: true
		});
	};
	console.log(waypts);
	
	//規畫路徑請求
	directionsService.route({
		origin: start,	//改從左側畫面接
	    destination: end,	//改從左側畫面接
	    waypoints: waypts,
	    optimizeWaypoints: true,
	    travelMode: google.maps.TravelMode.DRIVING	//改從左側畫面接?
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