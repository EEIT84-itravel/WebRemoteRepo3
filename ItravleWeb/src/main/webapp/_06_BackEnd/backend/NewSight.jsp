<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="_00_Misc.model.CodeVO"%>
<%@ page import="_00_Misc.model.CodeService"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> region = service.select("region");
	pageContext.setAttribute("region", region);
	List<CodeVO> county = service.select("county");
	pageContext.setAttribute("county", county);
	List<CodeVO> sightType = service.select("sight_type");
	pageContext.setAttribute("sightType", sightType);
	List<CodeVO> sightTime = service.select("sight_time");
	pageContext.setAttribute("sightTime", sightTime);
%>
<title>I-Travel後台:新增景點</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
$(document).ready(function() {
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
});
</script>
</head>
<body>
	<h2>I-Travel後台:新增景點</h2>
		<form action="<c:url value="/_06_BackEnd/backEnd/BackendSight.controller" />" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>景點名稱：</td>
					<td><input type="text" name="sightName" value="${param.sightName}"></td>
					<td><span class="error">${error.sightName}</span></td>
				</tr>
				<tr>
					<td>地區：</td>
					<td>
						<select name="regionId" id="sel">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}" ${(param.regionId==region.codeId)?'selected':'' }>${region.codeName}</option>
							</c:forEach>
						</select>
					</td>
					<td><span class="error">${error.regionId}</span></td>
				</tr>
				<tr>
					<td>縣市：</td>
					<td>
						<select name="countyId" id="sel2">
							<c:forEach var="county" items="${county}">
								<option value="${county.codeId}" ${(param.countyId==county.codeId)?'selected':'' }>${county.codeName}</option>
							</c:forEach>
						</select>
					</td>
					<td><span class="error">${error.countyId}</span></td>
				</tr>
				<tr>
					<td>景點類型：</td>
					<td>
						<select name="sightTypeId">
							<c:forEach var="sightType" items="${sightType}">
								<option value="${sightType.codeId}" ${(param.sightTypeId==sightType.codeId)?'selected':'' }>${sightType.codeName}</option>
							</c:forEach>
						</select>
					</td>
					<td><span class="error">${error.sightTypeId}</span></td>
				</tr>
				<tr>
					<td>門票：</td>
					<td><input type="text" name="ticket" value="${param.ticket}" size="45"></td>
					<td><span class="error">${error.ticket}</span></td>
				</tr>
				<tr>
					<td>開門時間：</td>
					<td><input type="time" name="openTime" value="${param.openTime}"></td>
					<td><span class="error">${error.openTime}</span></td>
				</tr>
				<tr>
					<td>關門時間：</td>
					<td><input type="time" name="closeIime" value="${param.closeIime}"></td>
					<td><span class="error">${error.closeIime}</span></td>
				</tr>
				<tr>
					<td>建議旅行時段：</td>
					<td>
						<select name="playPeriod">
							<c:forEach var="sightTime" items="${sightTime}">
								<option value="${sightTime.codeId}" ${(param.playPeriod==sightTime.codeId)?'selected':'' }>${sightTime.codeName}</option>
							</c:forEach>
						</select>
					</td>
					<td><span class="error">${error.playPeriod}</span></td>
				</tr>
				<tr>
					<td>經度：</td>
					<td><input type="text" name="longitude" value="${param.longitude}"></td>
					<td><span class="error">${error.longitude}</span></td>
				</tr>
						<tr>
					<td>緯度：</td>
					<td><input type="text" name="latitude" value="${param.latitude}"></td>
					<td><span class="error">${error.latitude}</span></td>
				</tr>
				<tr>
					<td>電話：</td>
					<td><input type="text" name="phone" value="${param.phone}"></td>
					<td><span class="error">${error.phone}</span></td>
				</tr>
				<tr>
					<td>地址：</td>
					<td><input type="text" name="addr" value="${param.addr}" size="45"></td>
					<td><span class="error">${error.addr}</span></td>
				</tr>
				<tr>
					<td>是否顯示：</td>
					<td>
					<input type="radio" name="del" value="true" checked="checked">是
					<input type="radio" name="del" value="false">否</td>
				</tr>
				<tr>
					<td>交通方式：</td>
					<td><textarea rows="8" cols="50" name="trans">${param.trans}</textarea>
					</td>
					<td><span class="error">${error.trans}</span></td>
				</tr>
				<tr>
					<td>簡介：</td>
					<td><textarea rows="8" cols="50" name="intro">${param.intro}</textarea></td>
					<td><span class="error">${error.intro}</span></td>
				</tr>
				<tr>
					<td>景點照片：</td>
					<td><input type="file" name="pic"></td>
					<td><span class="error">${error.pic}</span></td>
				</tr>
				<tr>
					<td><input type="hidden" name="action" value="insert"></td>
					<td><input type="submit" value="新增景點" /></td>
				</tr>
			</table>
		</form>
</body>
</html>