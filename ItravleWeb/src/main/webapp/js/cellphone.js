function sendRequest2(method, url2, id2) {
	var settings2 = new Object();
	settings2.method  = method;
	settings2.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
	settings2.url = url2;
	settings2.data = "cellphone="+id2;
	settings2.async = true;
	settings2.cache = false;
	
	settings2.success = processText2;

	$.ajax(settings2);
}
function processText2(data) {
	$("img:eq(1)").hide();
	
	var show2 = data;
	var index2 = data.indexOf(":");
	if(index2!=-1) {
		show2 = data.substring(0, index2);
		var temp2 = data.substring(index2+1);
		var array2 = temp2.split(",");
		$('input[name="cellphone"]').val(array2[0]);
	}
	$("#cellphone5").text(show2);
}

