<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<!-- 以下的要再改成jQuery 的ajax   不要在jsp出現java code -->

<%
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("region", codeVO);
	
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.select();
	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-排行程</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_02_TripAndJournal/WriteTrip.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />

<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script>
	$(function() {
		$(".sight").draggable();
		$("#trip").droppable(
				{
					drop : function(event, ui) {
						$(this).addClass("ui-state-highlight").find("p").html(
								"Dropped!");
					}
				});
	});
</script>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<nav>
		<!-- import共同的 -->
	</nav>
	<article>
		<form action="" method="get">
			<div id="left">
				<table>
					<tr>
						<td>
							<h4>行程名稱行程名稱行程名稱行程名稱行程名稱</h4>
						</td>
						<td id="topButton"><input type="submit" value="預算一覽"
							name="budget"> <input type="submit" value="下載旅遊書"
							name="download travel book"> <input type="submit"
							value="旅伴" name="partner"> <input type="submit"
							value="儲存" name="store"> <input type="submit" value="發布"
							name="publish"></td>
					</tr>
				</table>
				<div id="days">
					<p>2016/03/30</p>
					<p>第一天</p>
					<p>第二天</p>
					<p>第三天</p>
				</div>
				<!-- end div 選天數 -->
				<div id="trip">
					<p>行程</p>
				</div>
				<!-- end div 行程 -->
			</div>
			<!-- end div left -->
		</form>
		<form action="/WriteTrip" method="get">
			<div id="right">
				<div id="blank"></div>
				<select>
					<c:forEach var="region" items="${region}">
						<option value="${region.codeId}">${region.codeName}</option>
					</c:forEach>
				</select>
				<table>
					<tr>
						<td><input type="button" value="我的收藏" name="my collection">
							<input type="button" value="娛樂" name="amusement"> <input
							type="button" value="購物" name="shopping"> <input
							type="button" value="美食" name="food"> <input
							type="button" value="住宿" name="hotel"> <input
							type="button" value="其他" name="others"></td>
					</tr>
				</table>
				<div>排序：評分最高/最多人收藏</div>
				<div id="sights">
					<c:forEach var="sightVO" items="${sightVO}">
						<div class="sight">
							<span>照片</span><span>${sightVO.sightName}</span><span>${sightVO.score}分</span><span>評論</span><span>最愛</span>
						</div>
					</c:forEach>
				</div>
				<!-- end div sights -->
			</div>
			<!-- end div right -->
		</form>

		<!--測試用
	<c:if test="${not empty tripVO}">
		<table>
			<thead>
				<tr>
					<th>tripId</th>
					<th>memberId</th>
					<th>tripName</th>
					<th>tripStartDate</th>
					<th>tripEndDate</th>
					<th>startTime</th>
					<th>regionId</th>
					<th>transFormId</th>
					<th>tripIntro</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>${tripVO.tripId}</td>
						<td>${tripVO.memberId}</td>
						<td>${tripVO.tripName}</td>
						<td>${tripVO.tripStartDate}</td>
						<td>${tripVO.tripEndDate}</td>
						<td>${tripVO.startTime}</td>
						<td>${tripVO.regionId}</td>
						<td>${tripVO.transFormId}</td>
						<td>${tripVO.tripIntro}</td>
					</tr>
			</tbody>
		</table>
	</c:if>
-->


	</article>
	<footer>
		<!-- import共同的 -->
	</footer>



</body>
</html>
