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
		var sightId;
		var sightName;
		var spendHour;
		var newIndex;
		$(".sight").draggable({
 			helper : "clone",	//複製一份
 			start: function( event, ui ) {
 				$("tr.sightId>td:first-child:last").each(function(){	//取得正在拖曳的物件的sightId
 					sightId =$(this).text();
 				});
 				$("tr.sightId>td:nth-child(3):last").each(function(){	//取得正在拖曳的物件的sightName
 					sightName =$(this).text(); 					
 				});
 				$("tr.sightId>td:nth-child(6):last").each(function(){	//取得正在拖曳的物件的spendHour
 					spendHour =$(this).text(); 					
 				});
 			}
		});		
		//讓左邊行程可被放下
		$(".day").droppable({
			appendTo: "#day1",  //要黏到的目標				
			accept: ".sight",	//只能接受sight class的物件
			activeClass: "ui-state-highlight",	//凸顯此區域是可以被放置的
			drop : function(event, ui) {
				$(this).find(".placeholder").remove();	//移除Add your items here
				//放下的時候黏form上去，一個tirpDetail是一個form				
				$(".tripDetail").append('<form action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post"><table><tr><td class="tripDetailPic'+sightId+'"></td><td><span class="tripDetailSightId'+sightId+'"></span></td><td><span class="tripDetailSightName'+sightId+'"></span></td><td><input type="hidden" name="sightId" value="'+sightId+'"/></td><td><input type="text" name="stayTime" value="' + spendHour + '" /></td><td><input type="text" name="notes" placeholder="請在此輸入筆記" /></td><td><input type="text" name="sightBudget" placeholder="請在此輸入預算" /></td><td><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td><td><input type="hidden" name="tripOrder" value=1 /><P/></td><td><input type="hidden" name="whichDay" value=1 /><P/></td><td><input type="hidden" name="referenceType" value="type_id01" /><P/></td><td><input type="submit" value="修改" /></td></tr></table></form>');
 				//依照sightId抓到圖片，黏到剛剛的tr裡面
				$(".tripDetailPic"+sightId).html('<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=' + sightId + '" />" width="80" height="60">');
				//抓到sightId，黏到剛剛的tr裡面
 				$(".tripDetailSightId"+sightId).html(sightId);
 				//抓到sightName，黏到剛剛的tr裡面
 				$(".tripDetailSightName"+sightId).html(sightName); 				
				ui.helper.draggable({
					disabled : true
				});
			}		
		});
		//讓tripDetail可排序
// 		$(".tripDetail>tbody").sortable({
		$(".tripDetail").sortable({
			revert: true,
			axis: 'y',	//只能延Y軸移動
			start: function (event, ui) {
				var start_pos = ui.item.index();		//被拖曳物件原本的順序(從0開始)
				ui.item.data('start_pos', start_pos);	//把抓到的順序存到data裡
			},
			update: function (event, ui) {	            
	            var oldIndex = ui.item.data('start_pos');	//取得被拖曳物件原本的順序(從0開始)
	            newIndex = ui.item.index();				//新的順序(從0開始)
	            console.log("oldIndex"+oldIndex);
	            console.log("newIndex"+newIndex);
	            $.ajax({	//利用ajax傳到後端?
// 	                type: 'post',
// 	                url: '/PeopleGroups/DropOrderItem',
// 	                data: {
// 	                    oldIndex: oldIndex + 1,
// 	                    newIndex: newIndex + 1,
// 	                    page: currPage,
// 	                    pageSize: pageSize
// 	                }
	            });
	        }
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
		<form action="" method="post">
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
						<input type="submit" value="儲存" name="store">
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
				<button id="add_new">加一天</button>		
				<div class="day">第一天
					<div class="tripDetail">
						<!-- 拖過來的tripDetail長會在這裡 -->					
					</div>
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
				<tr class="sightId">	
					<td>${sightVO.sightId}</td>
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
 					<td hidden="true">${sightVO.spendHour}</td>	<%-- 給jQuery抓每個景點預設的建議停留時間 --%>
					<td>評論</td>
					<td>最愛</td>					
				</tr>
				</table>
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

