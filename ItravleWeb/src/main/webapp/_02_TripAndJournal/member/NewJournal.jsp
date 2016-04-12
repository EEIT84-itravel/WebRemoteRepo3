<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
%>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//起始日期用jQuery UI
		$('input[name="beginTime"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="endTime"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin
		
		//換頁tabs
	    $( "#tabs" ).tabs({
	        beforeLoad: function( event, ui ) {
	          ui.jqXHR.fail(function() {
	            ui.panel.html(
	              "Couldn't load this tab. We'll try to fix this as soon as possible. " +
	              "If this wouldn't be a demo." );
	          });
	        }
	    });
	});
</script>
<style type="text/css">
article {
	margin: 20px;
}
.journal{
	color:black;
}
</style>
<title>ITravel-建立新遊記</title>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
	<div id="tabs">
  <ul>
    <li><a href="#tabs-1">建立新的遊記</a></li>
    <li><a href="<c:url value="/_02_TripAndJournal/member/FromTripToJournal.jsp"/>">從我的遊記載入</a></li>
     </ul>
  <div id="tabs-1">
		<h3>建立新的遊記</h3>
		<form action="<c:url value="/_02_TripAndJournal/member/NewJournal.controller" />" method="post">
			<table>
				<tr>
					<td>遊記名稱:</td>
					<td><input class="journal" type="text" name="journalName" value="${param.journalName}"></td>
					<td><span class="error">${error.journalName}</span></td>
				</tr>
				<tr>
					<td>遊記開始日期:</td>
					<td><input class="journal" type="text" id="beginTime" name="beginTime" value="${param.beginTime}"></td>
					<td><span class="error">${error.beginTime}</span></td>
				</tr>
				<tr>
					<td>遊記結束日期:</td>
					<td><input class="journal" type="text" id="endTime" name="endTime" value="${param.endTime}"></td>
					<td><span class="error">${error.endTime}</span></td>
				</tr>
				<tr>
					<td>地區:</td>
					<td><select class="journal" name="regionId">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}">${region.codeName}</option>
							</c:forEach>
					</select></td>
					<td><span class="error">${error.regionId}</span></td>
				</tr>
				<tr>
					<td>遊記簡介:</td>
					<td><textarea class="journal" name="journalIntro" rows="4" cols="50">${param.journalIntro}</textarea></td>
					<td><span class="error">${error.journalIntro}</span></td>
				</tr>
				<tr>
					<td><input class="journal" type="submit" value="開始寫遊記吧!"></td>
				</tr>
			</table>
		</form>
		</div>
</div>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
