<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<jsp:useBean id="sightSvc" scope="page" class="_01_Sight.model.SightService" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${eventVO.eventTopic}</title>
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {	
		//景點詳情dialog功能
 		var uri = "${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
		var dialog;
		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 700,
			width : 600,
			draggable : true,
			resizable : false,
			modal : true,
			open : function() {
				closedialog = 1;
				$(document).bind('click', overlayclickclose);
			},
			focus : function() {
				closedialog = 0;
			},
			close : function() {
				$(document).unbind('click');
			}
		}); 

		$("tr.sightId>td:nth-child(2)").each(function() {
							$(this).click(
											function() {
												var sightId = $(this).prev().text();
												console.log(sightId);
												var stylei = ' width="98%" height="98%"  frameborder="0" scrolling="auto"';
												$("#dialog-form").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
												dialog.dialog("open");
												closedialog = 0;
											});
						});
	 	var closedialog;
		function overlayclickclose() {
			if (closedialog) {
				$('#dialog-form').dialog('close');
			}
			closedialog = 1;//set to one because click on dialog box sets to zero   
		} 
	});
</script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<style type="text/css">
</style>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<!-- import共同的 -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
	<div id="dialog-form"></div>
		<form>
			<table>
				<tr>
					<td>活動主題：${eventVO.eventTopic}</td>
				</tr>
				<tr>
					<td>活動起訖時間：${eventVO.eventStartDate}起，至${eventVO.eventEndDate}</td>
				</tr>
				<tr>
				<tr class="sightId">
					<td hidden="true">${eventVO.sightId}</td>
					<td>相關景點: 
					<c:forEach var="sightVO" items="${sightSvc.all}">
                          <c:if test="${sightVO.sightId==eventVO.sightId}">
								${sightVO.sightName}
                          </c:if>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<td>活動圖片：<img src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="400" height="300"></td>
				</tr>
				<tr>
					<td>活動內容：${eventVO.eventContent}</td>
				</tr>
				<tr>
					<td><a href="<c:url value="/_03_Event/AllEvent.jsp" />">回活動首頁</a></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>