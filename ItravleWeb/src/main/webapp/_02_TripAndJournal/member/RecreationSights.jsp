<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_01_Sight.model.dao.*"%>
<%@ page import="java.util.*"%>
<!-- 以下的要再改成jQuery 的ajax   不要在jsp出現java code -->

<%
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.selectByType("sight_type05");
	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RecreationSights</title>
<script>
	$(".sight").draggable({
		helper : "clone" //只拖動複製的圖片，原始圖片保持不動
	});
</script>
</head>
<body>
	RecreationSights.jsp
	<c:forEach var="sightVO" items="${sightVO}">
		<table class="sight">
			<tr>
				<td><img
					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
					width="80" height="60"></td>
				<td>${sightVO.sightName}</td>
				<td>${sightVO.score}分</td>
				<td>評論</td>
				<td>最愛</td>
			</tr>
		</table>
	</c:forEach>
</body>
</html>