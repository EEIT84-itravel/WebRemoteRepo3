<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<!-- 以下的要再改成jQuery 的ajax   不要在jsp出現java code -->

<%
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("region", codeVO);
	
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.select();
	pageContext.setAttribute("sightVO", sightVO);	
	
	TripService tripService = new TripService();
	TripVO tripVO=(TripVO)session.getAttribute("tripVO");	
	int dateDiff = tripService.selectDateDiff(tripVO.getTripId());
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-排行程</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/WriteTrip.css"/>"/>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script>
	$(function() {
		//讓右邊景點可以被拖曳
		$(".sight").draggable({
			helper : "clone" //只拖動複製的圖片，原始圖片保持不動
		});
		//讓左邊行程可被放下
		$(".day").droppable({
			appendTo: "#day1",  //要黏到的目標				
			accept: ".sight",	//只能接受sight class的物件
			activeClass: "ui-state-highlight",	//凸顯此區域是可以被放置的
			drop : function(event, ui) {
				$(this).find(".placeholder").remove();	//移除Add your items here
				$("<table></table>").html( ui.draggable.html() ).appendTo(this);  //把拖曳到的物件以html格式寫到<table>
				ui.helper.draggable({
					disabled : true
				})				
			}		
		}).sortable({
		      revert: true		      
	    });
		// 建立右邊景點的分頁
		$("#sightsTabs").tabs({
			heightStyle: "auto"	
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
						<h4>行程名稱：${tripVO.tripName}</h4>
					</td>
					<td id="topButton">						
						<input type="button" value="預算一覽" name="budget">
						<input type="button" value="下載旅遊書" name="download travel book">
						<input type="button" value="旅伴" name="partner">
						<input type="button" value="儲存" name="store">
						<input type="button" value="發布" name="publish">
					</td>
				</tr>
			</table>		
			<div id="days">
				<p>行程開始日期：<br>${tripVO.tripStartDate}</p>
				<p>本行程共<%=dateDiff%>天</p>
				<p>行程開始時間：<br>${tripVO.startTime}</p>				
				<p>第一天：</p>
				<p>第二天：</p>
				<p>第三天：</p>
			</div> <!-- end div 選天數 -->
			<div id="trip">
				<div id="tripBut">
					<span>主要交通方式：${tripVO.transFormId}</span>
					<span><input type="button" value="google map" name="google map"></span>
					<span><input type="button" value="顯示預算" name="show budget"></span>
					<span><input type="button" value="顯示筆記" name="show notes"></span>
					<span><input type="button" value="智慧調整" name="intelligent adjust"></span>
				</div>	<!-- end div tripBut -->
						
				<div class="day">第一天
      				<table class="placeholder"><tr><td>Add your items here</td></tr></table>
   				</div>	<!-- end div day -->
   				<div class="day">第二天
      				<table class="placeholder"><tr><td>Add your items here</td></tr></table>
   				</div>	<!-- end div day -->
   				<div class="day">第三天
      				<table class="placeholder"><tr><td>Add your items here</td></tr></table>
   				</div>	<!-- end div day -->
			</div>	<!-- end div 行程 -->
		</div>	<!-- end div left -->
		</form>		
		<div id="right">
			<div id="blank"></div>			
			<select>
			<c:forEach var="region" items="${region}">
				<option value="${region.codeId}">${region.codeName}</option>				
			</c:forEach>
			</select>
			<div id="sightsTabs">
			<ul>
			    <li><a href="#tabs-1">我的收藏</a></li>			    
			    <li><a href="<c:url value="/_02_TripAndJournal/member/RecreationSights.jsp" />">娛樂</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/ShoppingSights.jsp" />">購物</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/FoodSights.jsp" />">美食</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/HotelSights.jsp" />">住宿</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/OthersSights.jsp" />">其他</a></li>
  			</ul>	
  			<div id="tabs-1">		
			<div>排序：評分最高/最多人收藏</div>			
				<c:forEach var="sightVO" items="${sightVO}">
				<table class="sight">
				<tr>	
					<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
							 width="80" height="60">
					</td>
					<td>${sightVO.sightName}</td>
					<td>建議旅行時段:
						<c:forEach var="codeVO" items="${codeSvc.all}">
                             <c:if test="${codeVO.codeId==sightVO.playPeriod}">
								${codeVO.codeName}
                             </c:if>
						</c:forEach>
					</td>
					<td>${sightVO.score}分</td>
					<td>評論</td>
					<td>最愛</td>					
				</tr>
				</table>
				<form action="<c:url value="/_02_TripAndJournal/member/WriteTrip.controller" />" method="post">
					<!-- 下面的隱藏欄位都會送到後端 -->					
					<input type="hidden" name="tripId" value="${tripVO.tripId}"><P/>
					<input type="hidden" name="tripOrder" value=1><P/>  <!-- 先寫死 -->
					<input type="hidden" name="stayTime" value="${sightVO.spendHour}"><P/>
					<input type="hidden" name="whichDay" value=1><P/>  <!-- 先寫死 -->	
					<input type="hidden" name="referenceType" value="type_id01"><P/>
					<input type="hidden" name="sightId" value="${sightVO.sightId}"><p/>					
					<input type="hidden" name="notes" value="test notes"><p/>  <!-- 先寫死 -->						
					<input type="hidden" name="sightBudget" value=100.0><p/>  <!-- 先寫死 -->						
					<input type="submit" value="加入本次行程">
					</form>
				</c:forEach>
			</div>	<!-- end div tabs-1 -->
			</div>	<!-- end div sightsTabs -->										
			
		</div><!-- end div right -->
		


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
