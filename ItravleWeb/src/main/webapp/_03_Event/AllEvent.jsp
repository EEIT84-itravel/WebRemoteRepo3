<!-- 外接程式碼 -->
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_03_Event.model.*"%>
<%@ page import="java.util.*"%>
<%
	EventService eventService = new EventService();
	List<EventVO> eventVO = eventService.select();
	pageContext.setAttribute("eventVO", eventVO);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css"
	href="../css/_04_Forum/datatable.css" />
<link rel="stylesheet" type="text/css"
	href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />

<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	//DataTable設定
	var opt = {
		"oLanguage" : {
			"sProcessing" : "處理中...",
			"sLengthMenu" : "顯示 _MENU_ 項結果",
			"sZeroRecords" : "沒有匹配結果",
			"sInfo" : "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
			"sInfoEmpty" : "顯示第 0 至 0 項結果，共 0 項",
			"sInfoFiltered" : "(從 _MAX_ 項結果過濾)",
			"sSearch" : "關鍵字搜尋:",
			"bJQueryUI" : true,
			"oPaginate" : {
				"sFirst" : "首頁",
				"sPrevious" : "上一頁",
				"sNext" : "下一頁",
				"sLast" : "最末頁"
			}
		}
	};
	$(document).ready(function() {
		$("#event").DataTable(opt);
	})
</script>
<title>I-Travel全部活動</title>
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
		<form action="">
			<table border='1' id="event">
				<thead>
					<tr>
						<th>活動主題</th>
						<th>活動開始時間</th>
						<th>活動結束時間</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="eventVO" items="${eventVO}">
					<c:if test="${eventVO.eventRemoved==false}">
						<tr>
							<td><a href="<c:url value="/_03_Event/ShowEvent.controller?eventId=${eventVO.eventId}" />">${eventVO.eventTopic}</a></td>
							<td>${eventVO.eventStartDate}</td>
							<td>${eventVO.eventEndDate}</td>
						</tr>
					</c:if>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>