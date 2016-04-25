function sendRequest3(method, url3, cellphone1,cellphone2) {
	var settings3 = new Object();
	settings3.method  = method;
	settings3.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
	settings3.url = url3;
	settings3.data = "cellphone1="+cellphone1+"&cellphone2="+cellphone2;
	settings3.async = true;
	settings3.cache = false;
	
	settings3.success = processText3;

	$.ajax(settings3);
}
function processText3(data) {
	$("img:eq(1)").hide();
	
	var show3 = data;
	var index3 = data.indexOf(":");
	if(index3!=-1) {
		show3 = data.substring(0, index3);
		var temp3 = data.substring(index3+1);
		var array3 = temp3.split(",");
		$('input[name="cellphone2"]').val(array3[0]);
	}
	$("#cellphone5").text(show3);
}

