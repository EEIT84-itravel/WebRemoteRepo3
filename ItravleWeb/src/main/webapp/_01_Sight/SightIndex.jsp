<%@page import="_00_Misc.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("regions", codeVO);
	List<CodeVO> codeVO2 = codeService.select("county");
	pageContext.setAttribute("countys", codeVO2);
	List<CodeVO> codeVO3 = codeService.select("sight_type");
	pageContext.setAttribute("sight_type", codeVO3);
%>
<jsp:useBean id="codeSvc" scope="page"
	class="_00_Misc.model.CodeService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>景點首頁</title>
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>

<style type="text/css">
.SearchSight {
	height: 400px;
	width: 350px;
	border: 2px solid black;
	margin: 20px;
	padding: 10px;
	float: left;
	border-radius: 10px;
}
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
		<h5>首頁>看景點</h5>

		<!-- Button 進階搜尋 -->
		<button type="button" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModal">進階搜尋</button>

		<!-- 進階搜尋 互動視窗 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">進階搜尋</h4>
					</div>
					<div class="modal-body">
						<form action="<c:url value="/_01_Sight/SightIndex.controller" />">
							<table>
								<tr>
									<td>地區:<select name="region">
											<option value=""></option>
											<c:forEach var="obj" items="${regions}">
												<option value="${obj.codeId}"
													<c:if test="${region == obj.codeId}">selected</c:if>>${obj.codeName}</option>
											</c:forEach>
									</select>
									</td>
									<td>縣市:<select name="county">
											<option value=""></option>
											<c:forEach var="obj1" items="${countys}">
												<option value="${obj1.codeId}"
													<c:if test="${county == obj1.codeId}">selected</c:if>>${obj1.codeName}</option>
											</c:forEach>
									</select>
									</td>
									<td>類型:<select name="sightType">
											<option value=""></option>
											<c:forEach var="region" items="${sight_type}">
												<option value="${region.codeId}"
													<c:if test="${sightType == region.codeId}">selected</c:if>>${region.codeName}</option>
											</c:forEach>
									</select>
									</td>
								</tr>
							</table>
							<input type="submit" />
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 進階搜尋 互動視窗 End-->

		<br>
		<c:forEach var="sightVO" items="${sightVO}">
			<div class="SearchSight">
				<p>No:${sightVO.sightId}</p>
				<img
					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
					width="280" height="210">
				<p>
					<a
						href="<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />">名稱:${sightVO.sightName}</a>
				</p>
				<p>
					類型:
					<c:forEach var="codeVO" items="${codeSvc.all}">
						<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								${codeVO.codeName}
                             </c:if>
					</c:forEach>
				</p>
				<p>
					縣市:
					<c:forEach var="codeVO" items="${codeSvc.all}">
						<c:if test="${codeVO.codeId==sightVO.countyId}">
								${codeVO.codeName}
                             </c:if>
					</c:forEach>
				</p>
				<p>${sightVO.watchNum}人瀏覽,${sightVO.collectNum}人收藏</p>
			</div>
		</c:forEach>
		<c:if test="${empty sightVO}">查無此筆資訊</c:if>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
