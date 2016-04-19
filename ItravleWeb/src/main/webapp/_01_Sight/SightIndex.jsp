<%@page import="_00_Misc.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	// 	SightService sightService = new SightService();
	// 	List<SightVO> sightVO = sightService.select();
	// 	List<SightVO> watchNum = sightService.selectByWatchNum();
	// 	pageContext.setAttribute("sightVO", sightVO);
	// 	pageContext.setAttribute("watchNum", watchNum);

	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("regions", codeVO);
	List<CodeVO> codeVO2 = codeService.select("county");
	pageContext.setAttribute("county", codeVO2);
	List<CodeVO> codeVO3 = codeService.select("sight_type");
	pageContext.setAttribute("sight_type", codeVO3);
	List<CodeVO> codeVO4 = codeService.select("county");
	pageContext.setAttribute("county", codeVO2);
	List<CodeVO> codeVO5 = codeService.select("sight_time");
	pageContext.setAttribute("sight_time", codeVO5);
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>景點首頁</title>
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<style type="text/css">
.SearchSight {
	height: 400px;
	width: 350px;
	border: 1px solid #000000;
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
		
<!-- 		<nav> -->
<!--   <ul class="pagination"> -->
<!--     <li class="page-item"> -->
<!--       <a class="page-link" href="#" aria-label="Previous"> -->
<!--         <span aria-hidden="true">&laquo;</span> -->
<!--         <span class="sr-only">Previous</span> -->
<!--       </a> -->
<!--     </li> -->
<!--     <li class="ON"><a href="">1</a></li> -->
<!--     <li><a href="/ItravleWeb/_01_Sight/SightIndex.controller?region=region02&county=&sightType=">2</a></li> -->
<!--     <li><a href="#">3</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">4</a></li> -->
    
<!--     <li class="page-item"> -->
<!--       <a class="page-link" href="#" aria-label="Next"> -->
<!--         <span aria-hidden="true">&raquo;</span> -->
<!--         <span class="sr-only">Next</span> -->
<!--       </a> -->
<!--     </li> -->
<!--   </ul> -->
<!-- </nav> -->
		
		<!-- Button 進階搜尋 -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  進階搜尋
</button>

<!-- 進階搜尋 互動視窗 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">進階搜尋</h4>
      </div>
      <div class="modal-body">
        <form action="<c:url value="/_01_Sight/SightIndex.controller" />">
				<table>
					<tr>
						<td>地區:<select name="region">
						<option value=""> </option>
						<c:forEach var="obj"
									items="${regions}">
									<option value="${obj.codeId}"  <c:if test="${region == obj.codeId}">selected</c:if>>${obj.codeName}</option>
								</c:forEach></select>
						</td>
						<td>縣市:<select name="county">
						<option value=""> </option>
						<c:forEach var="region"
									items="${county}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
						</td>
						<td>類型:<select name="sightType">
						<option value=""> </option>
						<c:forEach
									var="region" items="${sight_type}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
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
	
<!-- 		<h5>熱門景點</h5> -->
<%-- 		<c:forEach var="watchNum" items="${watchNum}" begin="0" end="3"> --%>
<!-- 			<div class="SearchSight"> -->
<!-- 				<p>No:</p> -->
<!-- 				<img -->
<%-- 					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${watchNum.sightId}" />"> --%>
<!-- 				<p> -->
<!-- 					<a -->
<%-- 						href="<c:url value="/_01_Sight/Sight.controller?sightId=${watchNum.sightId}" />">名稱:${watchNum.sightName}</a> --%>
<!-- 				</p> -->
<!-- 				<p>類型:</p> -->
<!-- 				<p>縣市:</p> -->
<%-- 				<p>${watchNum.watchNum}人瀏覽,${watchNum.collectNum}人收藏</p> --%>
<!-- 			</div> -->
<%-- 		</c:forEach> --%>
		
		<br>
		<c:forEach var="sightVO" items="${sightVO}">
			<div class="SearchSight">
				<p>No:${sightVO.sightId}</p>
				<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
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
		<c:if test="${empty sightVO}">查無此資料</c:if>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
