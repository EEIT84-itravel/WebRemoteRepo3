<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
// 	int dateDiff = tripService.selectDateDiff(tripVO.getTripId());
	
	//以下三行應該放在會員的行程列表，點選可編輯單一行程的按鈕的servlet
	TripDetailService tripDetailService = new TripDetailService();	
// 	List<TripDetailVO> tripDetailVO = tripDetailService.select(tripVO.getTripId());
//	List<TripDetailVO> tripDetailVO = tripDetailService.select(2);
//	pageContext.setAttribute("tripDetailVO", tripDetailVO);
	
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-排行程</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/WriteTrip.css"/>" />
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<!-- 景點dialog功能 -->
<script type="text/javascript" src="<c:url value="/js/sightDialog.js"/>"></script>
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
				$(".tripDetail").append('<form action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post"><table><tr><td rowspan="2" class="tripDetailPic'+sightId+'"></td><td rowspan="2"><span class="tripDetailSightId'+sightId+'"></span></td><td rowspan="2"><span class="tripDetailSightName'+sightId+'"></span></td><td rowspan="2"><input type="hidden" name="sightId" value="'+sightId+'"/></td><td><label>行程順序：</label><span class="tripDetailOrder'+sightId+'"></span></td>	<td><label>停留時間：</label><input type="text" name="stayTime" value="' + spendHour + '" size="10" /></td><td><label>預算：</label><input type="text" name="sightBudget" placeholder="請在此輸入預算" /></td><td><input type="submit" value="修改" /></td></tr><tr><td colspan="4"><label>筆記：</label><textarea name="notes" rows="3" cols="70"></textarea></td></tr><tr><td><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td><td><input type="hidden" name="whichDay" value=1 /><P/></td><td><input type="hidden" name="referenceType" value="type_id01" /><P/></td></tr></table></form>');
				//依照sightId抓到圖片，黏到剛剛的tr裡面
				$(".tripDetailPic"+sightId).html('<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=' + sightId + '" />" width="80" height="60">');
				//抓到sightId，黏到剛剛的tr裡面
 				$(".tripDetailSightId"+sightId).html(sightId);
 				//抓到sightName，黏到剛剛的tr裡面
 				$(".tripDetailSightName"+sightId).html(sightName);
 				//抓到擺放順序，當做行程順序
 				var order = ui.draggable.index();
 				$(".tripDetailOrder"+sightId).html(order); 				
				ui.helper.draggable({
					disabled : true
				});	
				
				
				$.post({	//利用ajax傳到後端?	                
	                url: '<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />',
	                data: {
// 	                    tripId: 111	                    
	                }
	            });
			}		
		});
		//讓tripDetail可排序
		$(".tripDetail").sortable({
			revert: true,
			axis: 'y',	//只能延Y軸移動
			start: function (event, ui) {
				var start_pos = ui.item.index();		//被拖曳物件原本的順序(從0開始)
				ui.item.data('start_pos', start_pos);	//把抓到的順序存到data裡
				console.log(ui.item);
			},
			update: function (event, ui) {	            
	            var oldIndex = ui.item.data('start_pos');	//從data裡取得被拖曳物件原本的順序(從0開始)
	            newIndex = ui.item.index()+1;				//新的順序(從0開始)
	            console.log("update");
	            console.log(ui.item);
	            console.log("oldIndex"+oldIndex);
	            console.log("newIndex"+newIndex);
	            $(".tripDetailOrder"+sightId).html(newIndex);
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
			heightStyle : "auto"
		});
	});
</script>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>		
		<div id="left">
			<table>
				<tr>
					<td>
						<h4>行程名稱：${tripVO.tripName}</h4>
					</td>
					<td>
						<h4>tripId：${tripVO.tripId}</h4>
					</td>
					<td id="topButton">
						<a href="">預算一覽</a>						
						<a href="">下載旅遊書</a>					
						<a href="">旅伴</a>
						<a href="<c:url value="/_02_TripAndJournal/member/SaveTripDetailCart.controller?tripId=${tripVO.tripId}"/>">儲存行程</a>
						<a href="">發布</a>						
					</td>
				</tr>
			</table>		
			<div id="days">
				<p>行程開始日期：<br>${tripVO.tripStartDate}</p>
<%-- 				<p>本行程共<%=dateDiff%>天</p> --%>
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
						<!-- 從session取出tripDetailCart -->
						<c:if test="${not empty sessionScope.tripDetailCart}">						
						<c:forEach var="tripDetailVO" items="${sessionScope.tripDetailCart}">
							<form action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post">
							<table>
							<tr>
								<td rowspan="2"><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${tripDetailVO.referenceNo}" />" width="80" height="60"></td>
								<td rowspan="2">${tripDetailVO.referenceNo}</td>
								<td rowspan="2">${tripDetailVO.referenceNo}景點名稱</td>
								<td rowspan="2"><input type="hidden" name="sightId" value="${tripDetailVO.referenceNo}"/></td>
								<td><label>行程順序：</label><input type="text" name="tripOrder" value="${tripDetailVO.tripOrder}" size="5" /><P/></td>
								<td><label>停留時間：</label><input type="text" name="stayTime" value="${tripDetailVO.stayTime}" size="10"/></td>
								<td><label>預算：</label><input type="text" name="sightBudget" value="${tripDetailVO.sightBudget}" /></td>
								<td><input type="submit" value="修改" /></td>
							</tr>
							<tr>
								<td colspan="4"><label>筆記：</label><textarea name="notes" rows="3" cols="70">${tripDetailVO.notes}</textarea></td>
							</tr>
							<tr>
								<td><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td>							
								<td><input type="hidden" name="whichDay" value="${tripDetailVO.whichDay}" /><P/></td>
								<td><input type="hidden" name="referenceType" value="${tripDetailVO.referenceType}" /><P/></td>
							</tr>
							</table>
							</form>
						</c:forEach>
						</c:if>						
					</div>
   				</div>	<!-- end div day -->   				
			</div>	<!-- end div 行程 -->
		</div>	<!-- end div left -->
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
			    <li><a href="<c:url value="/_02_TripAndJournal/member/TripMap.jsp" />">行程地圖</a></li>
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
					<!-- 景點彈出視窗功能 -->
					<td><button class="label label-primary" onclick="window.open('<c:url value="/_02_TripAndJournal/ShowSightDetail.controller?sightId=${sightVO.sightId}" />','sightDetail','height=500,width=500,toolbar=no,titlebar=no,status=no,left=450,top=350');">詳情</button></td>					
				</tr>
				</table>
				</c:forEach>
			</div>	<!-- end div tabs-1 -->
			</div>	<!-- end div sightsTabs -->
		</div><!-- end div right -->
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
