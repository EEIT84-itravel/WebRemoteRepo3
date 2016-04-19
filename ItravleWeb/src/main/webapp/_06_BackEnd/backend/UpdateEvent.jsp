<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> region = service.select("region");
	pageContext.setAttribute("region", region);
	List<CodeVO> county = service.select("county");
	pageContext.setAttribute("county", county);
	SightService sightService=new SightService();
	List<SightVO> sightVO=sightService.select();
	pageContext.setAttribute("sightVO", sightVO);
%>
<jsp:useBean id="SightService" scope="page" class="_01_Sight.model.SightService" />
<title>I-Travel後台:修改活動</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//景點select選單
		$("#sel").change(function(){
			  switch ($(this).val()){
					case "region00": 
			      $("#sel2 option").remove();
			      break;
					case "region01": 
			      $("#sel2 option").remove();
			      var array = [ "臺北市","新北市","基隆市","宜蘭縣","桃園縣","新竹市","新竹縣"];
			      var arrayId=["county01","county02","county07","county17","county03","county08","county10"];
			      //利用each遍歷array中的值並將每個值新增到Select中
			      $.each(array, function(i, val) {
			        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
			      });      
			      break;
					case "region02": 
			      $("#sel2 option").remove();
			      var array = [ "臺中市","彰化縣","南投縣","苗栗縣","雲林縣"];
			      var arrayId=["county04","county12","county13","county11","county14"];
			      $.each(array, function(i, val) {
			        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
			      });      
			      break;
					case "region03": 
					      $("#sel2 option").remove();
					      var array = [ "嘉義市","嘉義縣","臺南市","高雄市","屏東縣","澎湖縣"];
					      var arrayId=["county09","county15","county05","county06","county16","county20"];
					      $.each(array, function(i, val) {
					        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
					      });      
					      break;
					case "region04": 
					      $("#sel2 option").remove();
					      var array = [ "花蓮縣","臺東縣","金門縣","連江縣"];
					      var arrayId=["county18","county19","county21","county22"];
					      $.each(array, function(i, val) {
					        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
					      });      
					      break;
				}
			});
		//動態顯示各縣市景點
		$('#sel2').change(function(){
			$("#sel3 option").remove();
					var url='<c:url value="/_06_BackEnd/backEnd/SightCountyServlet.view" />';
					var countyId=$('#sel2').val();
					var settings = new Object();
					settings.method  = "GET";
					settings.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
					settings.url = url;
					settings.data = "countyId="+countyId;
					settings.async = true;
					settings.cache = false;
					settings.success = processText;
					$.ajax(settings);
 			});
		//起始日期用jQuery UI
		$('input[name="eventStartDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="eventEndDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin
	});
	//動態顯示各縣市景點處理傳回資料
	function processText(data){
				var array = data.split(",");
				var sightIds=[];
				var sightNames=[];
				//景點ID 1,5,7...
				for (var i = 0; i < (array.length/2-1); i++) {
					  sightIds[i]=array[(2*i)];
					}
				//景點名稱 2,4,6
				for (var j = 0; j < (array.length/2-1); j++) {
					sightNames[j]=array[(2*j+1)];
					}
				//塞入sel3
				for (var k = 1; k < sightIds.length; k++) {
					$('#sel3').append('<option value="'+sightIds[k]+'">'+sightNames[k]+'</option>');
				}
	}
</script>
</head>
<body>
	<h2>I-Travel後台:修改活動</h2>
		<form action="<c:url value="/_06_BackEnd/backend/NewEvent.controller" />" method="post" enctype="multipart/form-data">
			<table>
			<c:if test="${not empty eventVO}">
				<tr hidden="true">
					<td><input type="text" name="eventId" value="${eventVO.eventId}"></td>
				</tr>
				<tr>
					<td>活動名稱：</td>
					<td><input type="text" name="eventTopic" value="${eventVO.eventTopic}"></td>
					<td><span class="error">${error.eventTopic}</span></td>
				</tr>
				<tr>
					<td>活動內容：</td>
					<td><textarea rows="5" cols="40" name="eventContent" style="resize: none">${eventVO.eventContent}</textarea></td>
					<td><span class="error">${error.eventContent}</span></td>
				</tr>
				<tr>
					<td>活動開始時間：</td>
					<td><input type="text" id="eventStartDate" name="eventStartDate" value="${eventVO.eventStartDate}"></td>
					<td><span class="error">${error.eventStartDate}</span></td>
				</tr>
				<tr>
					<td>活動結束時間：</td>
					<td><input type="text" id="eventEndDate" name="eventEndDate" value="${eventVO.eventEndDate}"></td>
					<td><span class="error">${error.eventEndDate}</span></td>
				</tr>
				<c:forEach var="sightVO1" items="${sightVO}">
				<c:if test="${eventVO.sightId==sightVO1.sightId}">
				<tr>
					<td>對應景點：</td>
					<td>地區：
						<select name="regionId" id="sel">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}" ${(sightVO1.regionId==region.codeId)?'selected':'' }>${region.codeName}</option>
							</c:forEach>
						</select>
							縣市：
						<select name="countyId" id="sel2">
							<c:forEach var="county" items="${county}">
								<option value="${county.codeId}" ${(sightVO1.countyId==county.codeId)?'selected':'' }>${county.codeName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				</c:if>
				</c:forEach>
				<tr>
				<td></td>
					<td>
						<select name="sightId" id="sel3">
						<c:forEach var="sightVO2" items="${sightVO}">
							<option value="${sightVO2.sightId}" ${(eventVO.sightId==sightVO2.sightId)?'selected':'' }>${sightVO2.sightName}</option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>是否下架：</td>
					<td><input type="radio" name="eventRemoved" value="true" >是
					<input type="radio" name="eventRemoved" value="false" checked="checked">否</td>
				</tr>
				<tr>
					<td>活動圖片：</td>
					<td><img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="80" height="60"><input type="file" name="eventPhoto"></td>
					<td><span class="error">${error.eventPhoto}</span></td>
				</tr>
				</c:if>
				<!-- 錯誤處理後由request參數回填 -->
				<c:if test="${empty eventVO}">
				<tr hidden="true">
					<td><input type="text" name="eventId" value="${param.eventId}"></td>
				</tr>
				<tr>
					<td>活動名稱：</td>
					<td><input type="text" name="eventTopic" value="${param.eventTopic}"></td>
					<td><span class="error">${error.eventTopic}</span></td>
				</tr>
				<tr>
					<td>活動內容：</td>
					<td><textarea rows="5" cols="40" name="eventContent" style="resize: none">${param.eventContent}</textarea></td>
					<td><span class="error">${error.eventContent}</span></td>
				</tr>
				<tr>
					<td>活動開始時間：</td>
					<td><input type="text" id="eventStartDate" name="eventStartDate" value="${param.eventStartDate}"></td>
					<td><span class="error">${error.eventStartDate}</span></td>
				</tr>
				<tr>
					<td>活動結束時間：</td>
					<td><input type="text" id="eventEndDate" name="eventEndDate" value="${param.eventEndDate}"></td>
					<td><span class="error">${error.eventEndDate}</span></td>
				</tr>
				<tr>
				<c:forEach var="sightVO3" items="${sightVO}">
				<c:if test="${eventVO.sightId==sightVO3.sightId}">
				<tr>
					<td>對應景點：</td>
					<td>地區：
						<select name="regionId" id="sel">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}" ${(param.regionId==region.codeId)?'selected':'' }>${region.codeName}</option>
							</c:forEach>
						</select>
							縣市：
						<select name="countyId" id="sel2">
							<c:forEach var="county" items="${county}">
								<option value="${county.codeId}" ${(param.countyId==county.codeId)?'selected':'' }>${county.codeName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				</c:if>
				</c:forEach>
				<tr>
				<td></td>
					<td>
						<select name="sightId" id="sel3">
						<c:forEach var="sightVO4" items="${sightVO}">
							<option value="${sightVO4.sightId}" ${(param.sightId==sightVO4.sightId)?'selected':'' }>${sightVO4.sightName}</option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>是否下架：</td>
					<td><input type="radio" name="eventRemoved" value="true" >是
					<input type="radio" name="eventRemoved" value="false" checked="checked">否</td>
				</tr>
				<tr>
					<td>活動圖片：</td>
					<td><img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${param.eventId}" />" width="80" height="60"><input type="file" name="eventPhoto"></td>
					<td><span class="error">${error.eventPhoto}</span></td>
				</tr>
				</c:if>
				<tr>
					<td><input type="hidden" name="action" value="update"></td>
					<td><input type="submit" value="修改活動" /></td>
				</tr>
			</table>
		</form>
</body>
</html>