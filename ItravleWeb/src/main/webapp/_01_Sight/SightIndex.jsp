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
	pageContext.setAttribute("region", codeVO);
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
<link rel="stylesheet" type="text/css"	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />
<script type="text/javascript"	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<style type="text/css">
.SearchSight {
	height: 400px; /* 高度 120 */
	width: 400px; /* 寬度 120*/
	/*background-color: #6699FF;  背景色 藍色*/
	border: 1px solid #000000; /* 虛線邊框 2 像素 深藍色*/
	margin: 20px; /* 四周邊界 20 像素 */
	float: left;
	padding: 10px;
}
</style>
<script type="text/javascript">
	//DataTable設定
	var opt = {
		"iDisplayLength" : 15,
		"sDom" : '<"top"fp><"bottom"><"clear">',
		"oLanguage" : {
			"sProcessing" : "處理中...",
			"sLengthMenu" : "顯示 _MENU_ 項結果",
			"sZeroRecords" : "沒有匹配結果",
			"sInfo" : "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
			"sInfoEmpty" : "顯示第 0 至 0 項結果，共 0 項",
			"sInfoFiltered" : "(從 _MAX_ 項結果過濾)",
			"sSearch" : "關鍵字搜尋:",
			"oPaginate" : {
				"sFirst" : "首頁",
				"sPrevious" : "上一頁",
				"sNext" : "下一頁",
				"sLast" : "最末頁"
			}
		}
	};
	//datatable
	$(document).ready(function() {
		$("#forum").DataTable(opt);		
	})
</script>

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
		<div class="SearchSight">
			<input type="button" value="進階搜尋"> <br>
			<form action="<c:url value="/_01_Sight/SightIndex.controller" />">
				<table id="forum">
					<tr>
						<td>地區:<select name="region"><c:forEach var="region"
									items="${region}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
						</td>
						<td>縣市:<select name="county"><c:forEach var="region"
									items="${county}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
						</td>
						<td>類型:<select name="sightType"><c:forEach
									var="region" items="${sight_type}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
						</td>
						<td>消費金額:<select name="money">
								<option value="free">免費</option>
								<option value="nofree">付費</option>
						</select>
						</td>
						<td>開放時間:<select name="sightTime"><c:forEach
									var="region" items="${sight_time}">
									<option value="${region.codeId}">${region.codeName}</option>
								</c:forEach></select>
						</td>
					</tr>
				</table>
				<input type="submit" />
			</form>

		</div>
		<h5>熱門景點</h5>
		<c:forEach var="watchNum" items="${watchNum}" begin="0" end="3">

			<div class="SearchSight">
				<p>No:</p>
				<img alt=""
					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${watchNum.sightId}" />"
					width="240" height="180">
				<p>
					<a
						href="<c:url value="/_01_Sight/Sight.controller?sightId=${watchNum.sightId}" />">名稱:${watchNum.sightName}</a>
				</p>
				<p>類型:</p>
				<p>縣市:</p>
				<p>${watchNum.watchNum}人瀏覽,${watchNum.collectNum}人收藏</p>
			</div>

		</c:forEach>
		<br>

		<c:forEach var="sightVO" items="${sightVO}">
			<div class="SearchSight">
				<p>No:${sightVO.sightId}</p>
				<img alt=""
					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
					width="240" height="180">
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
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
