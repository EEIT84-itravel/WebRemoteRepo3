<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<% 
    int rowNumber=0;      //總筆數
    int pageNumber=0;     //總頁數      
    int whichPage=1;      //第幾頁
    int pageIndexArray[]=null;
    int pageIndex=0; 
    int rowsPerPage;
%>
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
	
	CollectionService collectionService = new CollectionService();
	int memberId=((MemberVO)session.getAttribute("user")).getMemberId();
	List<CollectionVO> memberColl =collectionService.selectByMemberId(memberId);
	pageContext.setAttribute("memberColl", memberColl);
	
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<jsp:useBean id="sightSvc" scope="page" class="_01_Sight.model.SightService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-排行程</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/WriteTrip.css"/>" />
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">

var sightId;
var spendHour;
var sightName;
var latitude;	//緯度
var longitude;  //經度

	$(function() {
				
		var tripId = '${tripVO.tripId}';		
		var newIndex;
	
		
		//判斷cart裡是否有detail，沒有的話才上背景色，有東西放下移除背景色
		var test =$( ".tripDetailTable" ).children().length;
		console.log(test+"test");
		if(test==0) {		
			$(".day").css("background-color","#e6e6ff");
		}
		
		//讓右邊景點可以被拖曳
		$(".sight").draggable({
 			helper : "clone",	//複製一份 			
 			start: function( event, ui ) {
 				$("tr.sightId>td:first-child:last").each(function(){	//取得正在拖曳的物件的sightId
 					sightId =$(this).text();
 				});
 				$("tr.sightId>td:nth-child(3):last").each(function(){	//取得正在拖曳的物件的sightName
 					sightName =$(this).text(); 					
 				});
 				$("tr.sightId>td:nth-child(5):last").each(function(){	//取得正在拖曳的物件的spendHour
 					spendHour =$(this).text(); 					
 				});
 				$("tr.sightId>td:nth-child(7):last").each(function(){	//取得正在拖曳的物件的latitude(緯度)
 					latitude =$(this).text(); 	
 					console.log("latitude"+latitude);
 				});
 				$("tr.sightId>td:nth-child(8):last").each(function(){	//取得正在拖曳的物件的longitude(經度)
 					longitude =$(this).text(); 	
 					console.log("longitude"+longitude);
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
				$(".day").css("background-color","transparent");	//放下後移除背景色
				$(".tripDetail").append('<div class="tripDetailForm'+sightId+'"></div>');
				//把table黏上去
				$(".tripDetailForm"+sightId).html('<table class="tripDetailTable"><tr class="delTripDetail"><td rowspan="2" class="tripDetailPic'+sightId+'"></td><td rowspan="2" class="sightName"><span class="tripDetailSightName'+sightId+'"></span><label>預算：</label><input type="number" name="sightBudget" placeholder="請輸入數字" pattern="[0-9]*" />元<br><label>筆記：</label><textarea class="noteTextarea" name="notes"></textarea></td><td><input type="button" value="刪除" onclick="delADetail('+sightId+')"></td></tr><tr hidden="true"><td hidden="true"><label>停留時間：</label><input type="text" name="stayTime" value="' + spendHour + '" size="10" /></td><td hidden="true"><input type="hidden" name="sightId" value="'+sightId+'"/></td><td hidden="true"><td hidden="true"><input type="hidden" name="whichDay" value=1 /><P/></td><td hidden="true"><input type="hidden" name="referenceType" value="type_id01" /></td><td class="lat'+sightId+'" hidden="true"></td><td class="lng'+sightId+'" hidden="true"></td></tr></table>');
				//依照sightId抓到圖片，黏到剛剛的tr裡面
				$(".tripDetailPic"+sightId).html('<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=' + sightId + '" />" width="160" height="120">');
				//抓到sightId，黏到剛剛的tr裡面
 				$(".tripDetailSightId"+sightId).html('<input type="text" name="sightId" value="'+ sightId +'"/>');
 				//抓到sightName，黏到剛剛的tr裡面
 				$(".tripDetailSightName"+sightId).html('<h3>'+sightName+'</h3>'); 				
 				//抓到latitude，黏到td裡面
 				$(".lat"+sightId).html('<input type="hidden" name="lat" value="'+ latitude +'"/>'); 
 				//抓到latitude，黏到td裡面
 				$(".lng"+sightId).html('<input type="hidden" name="lng" value="'+ longitude +'"/>'); 
				//放下後關閉可拖動項目
 				ui.helper.draggable({
					disabled : true
				});	
			}		
		});	
		
		//讓tripDetail可排序
		$(".tripDetail").sortable({
			revert: true,
			axis: 'y',	//只能延Y軸移動
			//放下時重新計算路徑
// 			update: function( event, ui ) {
// 				calculateAndDisplayRoute(directionsService, directionsDisplay);
// 			}
	    }).draggable();
		
		// 建立右邊景點的分頁
		$("#sightsTabs").tabs({
			heightStyle : "fill"
		});
		$("#sightsTabs").click(function() {
			var current_index = $("#sightsTabs").tabs("option","active");
			alert(current_index);
			$("#sightsTabs").tabs('load',current_index);
			
		});

		
		//景點詳情dialog功能
		var uri="${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
 		var dialog;
			dialog = $( "#mysight" ).dialog({
	        autoOpen: false,
	        height: 700,
	        width: 600,
	        draggable: true,
	        resizable: false,
	        modal: true,
	        open: function() {
	            closedialog = 1;
	            $(document).bind('click', overlayclickclose); },
	        focus: function() { 
	            closedialog = 0; },
	        close: function() { 
	            $(document).unbind('click'); }
	    });
		$("tr.sightId>td:nth-child(6)").each(function(){
			$(this).click(function(){
					var sightId=$(this).prev().prev().prev().prev().prev().text();	
					console.log(sightId);
					var stylei=' width="98%" height="98%"  frameborder="0" scrolling="auto"';
					$("#mysight").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
					dialog.dialog( "open" );
					closedialog = 0;
			});
		});
		var closedialog;
		 function overlayclickclose() {
		        if (closedialog) {
		            $('#mysight').dialog('close');
		        }
		        closedialog = 1;//set to one because click on dialog box sets to zero
		    }	
		//景點明細dialog功能結束  
		
		// 儲存時的確認對話框
		var dialog2 = $( "#dialog-confirm" ).dialog({
			resizable: false,
			autoOpen: false,
			height:150,
			modal: true,
			buttons: {
				"確認": function() {
					saveTripDetailCart();
					$( this ).dialog( "close" );					
				},
		        "取消": function() {
		        	$( this ).dialog( "close" );
		        }
		 	}			
		 });
		// 按鈕觸發對話框
		$("#saveTrip").button().on( "click", function() {
		      dialog2.dialog( "open" );
	    });
		
		

	});  /* onload function end */

	

	
//移除單一景點(html黏上時在form加景點編號當參數)
function delADetail(referenceNo) {	
	$(".tripDetailForm"+referenceNo).remove();
}
	

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
	<article class="center-block">
		<!-- 景點dialog顯示頁面 平時隱藏 -->
		<!-- tab由左往右開dialog正常，但往左回來會怪怪 -->
		<div id="mysight" title="景點明細"></div>	
<%-- 	<p>${pageContext.session.id}</p> --%>
		<div id="left">
		<form method="post" action="<c:url value="/_02_TripAndJournal/member/TripDetail2.controller" />">	
			<h2 class="h2">行程名稱：${tripVO.tripName}</h2>					
			<div id="days">
				<p>tripId：${tripVO.tripId}</p>
				<input type="hidden" name="tripId" value="${tripVO.tripId}">
				<p>行程開始日期：<br>${tripVO.tripStartDate}</p>
<%-- 				<p>本行程共<%=dateDiff%>天</p> --%>				
				<button id="btnBudget" class="btn btn-info btn-lg">預算一覽</button><br>
				<input type="submit" value="儲存行程" class="btn btn-primary btn-lg">
			</div> <!-- end div days -->
			<div id="trip">
				<div id="tripBut">					
				</div>	<!-- end div tripBut -->						
				<div class="day">
					<div class="tripDetail">
						<c:if test="${empty tripDetailCart}">
						<div class="placeholder">
							<h2 class="h2">請將景點拖曳到此</h2>
						</div>
						</c:if>					
						<!-- 拖過來的tripDetail長會在這裡 -->						
						<!-- 如果是舊的行程拿出來改，要從request取出tripDetailCart -->
						<c:if test="${not empty tripDetailCart}">										
						<c:forEach var="tripDetailVO" items="${tripDetailCart}">
<%-- 						<c:if test="${tripDetailVO.tripId==tripVO.tripId}"> --%>
							<div class="tripDetailForm${tripDetailVO.referenceNo}">
							<table class="tripDetailTable">
							<tr>
								<td rowspan="2"><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${tripDetailVO.referenceNo}" />" width="160" height="120"></td>
								<td rowspan="2" class="sightName">
									<c:forEach var="sightVO2" items="${sightSvc.all}">
                            			<c:if test="${sightVO2.sightId==tripDetailVO.referenceNo}">
											<h3>${sightVO2.sightName}</h3>
                             			</c:if>
									</c:forEach>					
									<label>預算：</label><input type="number" name="sightBudget" value="${tripDetailVO.sightBudget}" />元<br>
									<label>筆記：</label><textarea class="noteTextarea" name="notes">${tripDetailVO.notes}</textarea>
								</td>
								<td>
								<c:url value="/_02_TripAndJournal/member/DelTripDetail.controller" var="path" scope="page">
									<c:param name="tripOrder" value="${tripDetailVO.tripOrder}" />									
								</c:url>
								<input type="button" value="刪除" onclick="delADetail(${tripDetailVO.referenceNo})"></td>
							</tr>
							<tr hidden="true">
								<td hidden="true"><label>停留時間：</label><input type="hidden" name="stayTime" value="${tripDetailVO.stayTime}" size="10"/></td>
								<td hidden="true"><input type="hidden" name="tripOrder" value="${tripDetailVO.tripOrder}" size="5" /></td>
								<td rowspan="2" hidden="true"><input type="hidden" name="sightId" value="${tripDetailVO.referenceNo}"/></td>
<%-- 								<td hidden="true"><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td>							 --%>
								<td hidden="true"><input type="hidden" name="whichDay" value="${tripDetailVO.whichDay}" /><P/></td>
								<td hidden="true"><input type="hidden" name="referenceType" value="${tripDetailVO.referenceType}" /><P/></td>
								<td hidden="true">
									<c:forEach var="sightVO3" items="${sightSvc.all}">
                            			<c:if test="${sightVO3.sightId==tripDetailVO.referenceNo}">
											<input type="text" name="lat" value="${sightVO3.latitude}"/>
                             			</c:if>
									</c:forEach>								
								</td>
								<td hidden="true">
									<c:forEach var="sightVO4" items="${sightSvc.all}">
                            			<c:if test="${sightVO4.sightId==tripDetailVO.referenceNo}">
											<input type="text" name="lng" value="${sightVO4.longitude}"/>
                             			</c:if>
									</c:forEach>
								</td>
							</tr>
							</table>
							</div>
<%-- 						</c:if> --%>
						</c:forEach>						
						</c:if>						
					</div>
   				</div>	<!-- end div day -->   				
			</div>	<!-- end div 行程 -->
			</form><!-- end 儲存行程form -->
		</div>	<!-- end div left -->
		<div id="right">
			<div id="divsaveTrip">
<!-- 				<button id="saveTrip" class="btn btn-info">儲存行程</button> -->
<!-- 				<input type="submit" value="儲存行程" class="btn btn-primary btn-lg"> -->
			</div>
			<div id="sightsTabs">
			<ul>
			    <li><a href="#tabs-1">我的收藏</a></li>			    
			    <li><a href="<c:url value="/_02_TripAndJournal/member/RecreationSights.jsp" />">娛樂</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/ShoppingSights.jsp" />">購物</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/FoodSights.jsp" />">美食</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/HotelSights.jsp" />">住宿</a></li>
			    <li><a href="<c:url value="/_02_TripAndJournal/member/OthersSights.jsp" />">其他</a></li>
<!-- 			    <li><a href="#tabs-1">娛樂</a></li> -->
<!-- 			    <li><a href="#tabs-2">購物</a></li> -->
<!-- 			    <li><a href="#tabs-3">美食</a></li> -->
<!-- 			    <li><a href="#tabs-4">住宿</a></li> -->
<!-- 			    <li><a href="#tabs-5">其他</a></li> -->
			    <li><a href="<c:url value="/_02_TripAndJournal/member/TripMap.jsp" />">行程地圖</a></li>
  			</ul>	
  			<div id="tabs-1">			
			<%  rowsPerPage = 10;  //每頁的筆數 
				rowNumber=memberColl.size(); 
			%>
			<%@ include file="/_00_Misc/page1.file" %>
			<c:forEach var="sightVO" items="${sightSvc.all}">
				<c:forEach var="memberColl1" items="${memberColl}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
				<c:if test="${sightVO.sightId==memberColl1.referenceType}">
				<table class="sight table">
				<tr class="sightId">	
					<td>${sightVO.sightId}</td>
					<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
							 width="80" height="60">
					</td>					
					<td><h4 class="h4">${sightVO.sightName}</h4>											
					</td>					
					<td>${sightVO.score}分<br>
						建議旅行時段：
						<c:forEach var="codeVO" items="${codeSvc.all}">
                             <c:if test="${codeVO.codeId==sightVO.playPeriod}">
								${codeVO.codeName}
                             </c:if>
						</c:forEach>
					</td>
 					<td hidden="true">${sightVO.spendHour}</td>	<%-- 給jQuery抓每個景點預設的建議停留時間 --%>
					<!-- 景點彈出視窗功能 -->
					<td><button class="label label-primary">詳情</button></td>	
					<td hidden="true">${sightVO.latitude}</td>	<%-- 給jQuery抓每個景點預設的緯度 --%>
 					<td hidden="true">${sightVO.longitude}</td>	<%-- 給jQuery抓每個景點預設的經度 --%>				
				</tr>
				</table>
				</c:if>
				</c:forEach>				
			</c:forEach>
			<%@ include file="/_00_Misc/page2.file" %>
			</div>	<!-- end div tabs-1 -->			
			</div>	<!-- end div sightsTabs -->
		</div><!-- end div right -->
		
		<!-- 儲存行程觸發的對話框 -->
		<div id="dialog-confirm" title="確認儲存?" >
 			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>確定要儲存嗎?</p>
		</div>	<!-- end div dialog-confirm -->		
		
		<!-- 儲存行程成功觸發的對話框 -->
		<div id="divSaveSuccess" title="儲存成功" hidden="true">
			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>儲存成功</p>
		</div>	<!-- end div divUpdateSuccess -->
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
