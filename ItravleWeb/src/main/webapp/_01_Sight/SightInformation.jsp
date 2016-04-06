<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_01_Sight.model.*"%>

<jsp:useBean id="codeSvc" scope="page"
	class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>景點資訊</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({
			event : "mouseover"
		});
	});
</script>
</head>
<body>
	<h1>景點資訊</h1>

	<div>

		<p>地名:${sightVO.sightName}</p>
		<p>
			類型:
			<c:forEach var="codeVO" items="${codeSvc.all}">
				<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								${codeVO.codeName}
                             </c:if>
			</c:forEach>
		</p>
		<p>門票:${sightVO.ticket}</p>
		<p>營業時間:${openTime}-${closeTime}</p>
		<p>建議停留時間:${sightVO.spendHour}</p>
		<p>
			建議旅行時段:
			<c:forEach var="codeVO" items="${codeSvc.all}">
				<c:if test="${codeVO.codeId==sightVO.playPeriod}">
								${codeVO.codeName}
                             </c:if>
			</c:forEach>
		</p>
		<p>地址:${sightVO.addr}</p>
		<p>交通方式:${sightVO.trans}</p>
	</div>

	<div id="tabs">
	

		<ul>
			<li><a href="#tabs-1">相關行程</a></li>
			<li><a href="#tabs-2">相關遊記</a></li>
			<li><a href="#tabs-3">留言</a></li>
		</ul>
		<div id="tabs-1">
			<p>台北小清新之旅</p>
		</div>
		<div></div>
		<div id="tabs-2">
			<p>我的遊記</p>
		</div>
		<div id="tabs-3">
			<p>門票是不是漲價了</p>
		</div>
	</div>
</body>
</html>
