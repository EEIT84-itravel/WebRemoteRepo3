<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	SightService service = new SightService();
	List<SightVO> list = service.select();
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>景點首頁</title>
<style type="text/css">
div {
	height: 400px; /* 高度 120 */
	width: 400px; /* 寬度 120*/
	/*background-color: #6699FF;  背景色 藍色*/
	border: 1px solid #003366; /* 虛線邊框 2 像素 深藍色*/
	margin: 20px; /* 四周邊界 20 像素 */
	float: left;
	padding: 10px;
}
</style>
</head>
<body>
	<c:forEach var="region" items="${list}">
		<option value="${region.sightId}"></option>
	<div>
		<img alt="" src="">
		<p>
			<a href="/ItravleWeb/_01_Sight/SightInformation.jsp">名稱:${region.sightName}</a>
		</p>
		<p>類型:</p>
		<p>縣市:</p>
		<p>人瀏覽,人收藏</p>
	</div>
	</c:forEach>
	<div>
		<p>
			<a href="/ItravleWeb/_01_Sight/SightInformation.jsp">名稱:</a>
		</p>
		<p>類型:</p>
		<p>縣市:</p>
		<p>人瀏覽,人收藏</p>
	</div>
	<div>
		<p>
			<a href="/ItravleWeb/_01_Sight/SightInformation.jsp">名稱:</a>
		</p>
		<p>類型:</p>
		<p>縣市:</p>
		<p>人瀏覽,人收藏</p>
	</div>
	<div>
		<p>
			<a href="/ItravleWeb/_01_Sight/SightInformation.jsp">名稱:</a>
		</p>
		<p>類型:</p>
		<p>縣市:</p>
		<p>人瀏覽,人收藏</p>
	</div>
</body>
</html>