<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.select();
	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>景點首頁</title>
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>

<style type="text/css">
div {
	height: 400px; /* 高度 120 */
	width: 400px; /* 寬度 120*/
	/*background-color: #6699FF;  背景色 藍色*/
	border: 1px solid #000000; /* 虛線邊框 2 像素 深藍色*/
	margin: 20px; /* 四周邊界 20 像素 */
	float: left;
	padding: 10px;
}
</style>

</head>
<body>
	<h5>首頁>看景點</h5>
	<input type="button" value="進階搜尋">
	<br>
	<c:forEach var="sightVO" items="${sightVO}">
		<div id="tbl">
			<p>No:${sightVO.sightId}</p>
			<img alt="" src="">
			<p>
				<a href="/ItravleWeb/_01_Sight/SightInformation.jsp">名稱:${sightVO.sightName}</a>
			</p>
			<p>類型:${sightVO.sightTypeId}</p>
			<p>縣市:</p>
			<p>${sightVO.watchNum}人瀏覽,${sightVO.collectNum}人收藏</p>
		</div>
	</c:forEach>
</body>
</html>