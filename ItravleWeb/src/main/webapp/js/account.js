function sendRequest(method, url, id) {
	var settings = new Object();
	settings.method  = method;
	settings.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
	settings.url = url;
	settings.data = "memberAccount="+id;
	settings.async = true;
	settings.cache = false;
	
	
	settings.success = processText;

	$.ajax(settings);
}
function processText(data) {
	$("img:eq(0)").hide();
	
	var show = data;
	var index = data.indexOf(":");
	if(index!=-1) {
		show = data.substring(0, index);
		var temp = data.substring(index+1);
		var array = temp.split(",");
		$('input[name="memberAccount"]').val(array[0]);
	}
	$("span:eq(2)").text(show);
}

