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
<script>
var sightId;
var spendHour;

	$(function() {
				
		var tripId = '${tripVO.tripId}';
		var sightName;
		var newIndex;
		var latitude;	//緯度
		var longitude;  //經度
		
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
 				$("tr.sightId>td:nth-child(6):last").each(function(){	//取得正在拖曳的物件的spendHour
 					spendHour =$(this).text(); 					
 				});
 				$("tr.sightId>td:nth-child(10):last").each(function(){	//取得正在拖曳的物件的latitude(緯度)
 					latitude =$(this).text(); 	
 					console.log("latitude"+latitude);
 				});
 				$("tr.sightId>td:nth-child(11):last").each(function(){	//取得正在拖曳的物件的longitude(經度)
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
				//form黏上去前取得div tripDetail有幾個小孩
				var iii = $( ".tripDetail" ).children().length;	
				var order = ( iii+1 ) * 2 - 1;
 				console.log("order="+order); 			
				$(this).find(".placeholder").remove();	//移除Add your items here
// 				$(".day").css("background-color","white");
				//放下的時候黏form上去，一個tirpDetail是一個form
				$(".tripDetail").append('<form class="tripDetailForm'+sightId+'" action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post"></form>');
				//把table黏上去
				$(".tripDetailForm"+sightId).html('<table class="tripDetailTable"><tr class="delTripDetail"><td rowspan="2" class="tripDetailPic'+sightId+'"></td><td rowspan="2" class="sightName"><span class="tripDetailSightName'+sightId+'"></span><label>預算：</label><input type="number" name="sightBudget" placeholder="請在此輸入預算" />元<br><label>筆記：</label><textarea class="noteTextarea" name="notes"></textarea></td><td><input type="submit" value="修改"/><br><input type="button" value="刪除" onclick="location.href=' + "'" + 'DelTripDetail.controller?tripOrder=' + order + "'" +'"></td></tr><tr hidden="true"><td hidden="true"><span class="tripDetailSightId'+sightId+'"></span></td><td hidden="true"><label>行程順序：</label><span class="tripDetailOrder'+sightId+'"></span></td><td hidden="true"><label>停留時間：</label><input type="text" name="stayTime" value="' + spendHour + '" size="10" /></td><td hidden="true"><input type="hidden" name="sightId" value="'+sightId+'"/></td><td hidden="true"><input type="hidden" name="tripId" value="${tripVO.tripId}" /></td><td hidden="true"><input type="hidden" name="whichDay" value=1 /><P/></td><td hidden="true"><input type="hidden" name="referenceType" value="type_id01" /></td><td class="lat'+sightId+'" hidden="true"></td><td class="lng'+sightId+'" hidden="true"></td></tr></table>');
				//依照sightId抓到圖片，黏到剛剛的tr裡面
				$(".tripDetailPic"+sightId).html('<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=' + sightId + '" />" width="160" height="120">');
				//抓到sightId，黏到剛剛的tr裡面
 				$(".tripDetailSightId"+sightId).html(sightId);
 				//抓到sightName，黏到剛剛的tr裡面
 				$(".tripDetailSightName"+sightId).html('<h3>'+sightName+'</h3>'); 				
 				$(".tripDetailOrder"+sightId).html('<input type="text" name="tripOrder" value="'+ order +'"/>');
 				//抓到latitude，黏到td裡面
 				$(".lat"+sightId).html('<input type="hidden" name="lat" value="'+ latitude +'"/>'); 
 				//抓到latitude，黏到td裡面
 				$(".lng"+sightId).html('<input type="hidden" name="lng" value="'+ longitude +'"/>'); 
				//放下後關閉可拖動項目
 				ui.helper.draggable({
					disabled : true
				});		
// 				console.log("sightId"+sightId);
// 				console.log("spendHour"+spendHour);
				//放下的同時寫一筆資料到session裡的tripDetailCart
				var jqxhr = $.post({		                
					//資料回填?
					url: '<c:url value="/_02_TripAndJournal/member/AddToTripDetailCart.controller" />',
	                cache: false,
	                data: {
	                    tripId: tripId,
	                    tripOrder: order,
	                    stayTime: spendHour,
	                    whichDay: 1,
	                    referenceType: "type_id01",
	                    sightId: sightId,
	                    notes: "",
	                    sightBudget: 0 
	                },
	                success: function() {
	                	alert("新增成功！");
	                }
	            }).fail(function(){
	            	alert("行程明細更新失敗，請再試一次");
	            	//要再改成按鈕，按下後把畫面上的那一筆tripDetail刪除
	            });				
				
			}		
		});
		var test =$( ".tripDetail" ).children().length;
		console.log(test+"test");
		if(test>1) {
			$(".placeholder").remove();
// 			$(".day").css("background-color","white");
		}
		//讓tripDetail可排序
		$(".tripDetail").sortable({
			revert: true,
			axis: 'y',	//只能延Y軸移動
			start: function (event, ui) {
				var start_pos = ui.item.index();		//被拖曳物件原本的順序(從0開始)
				ui.item.data( 'start_pos', start_pos );	//把抓到的順序存到data裡				
			},
			update: function (event, ui) {	            
	            var oldIndex = ui.item.data( 'start_pos' );	//從data裡取得被拖曳物件原本的順序(從0開始)
	            newIndex = ui.item.index();				//新的順序(從0開始)
	            console.log( "update" );
	            console.log( ui.item );
	            console.log( "oldIndex:"+oldIndex );
	            console.log( "newIndex:"+newIndex );
	            var data = $(this).sortable('serialize');
	            console.log(data);
	            var jqxhr = $.ajax({	//傳到servlet修改值
	                type: 'post',
	                url: '<c:url value="/_02_TripAndJournal/member/UpdateTripDetailOrder.controller" />',
	                data: {
	                    oldIndex: oldIndex,
	                    newIndex: newIndex
	                },
	                success: function() {
	                	location.reload();
	                }
	            }).fail(function(){
	            	alert("更新失敗");
	            	//要再改成按鈕，後續處理?
	            });
	        }
	    }).draggable();
		// 建立右邊景點的分頁
		$("#sightsTabs").tabs({
			heightStyle : "fill"
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
		
// 		//刪除單筆tripDetail
// 		$("td.delTripDetail").each(function(){
// 			$(this).click(function() {	 			
// 	 			$.post({
// 	 				url: '<c:url value="/_02_TripAndJournal/member/DelTripDetail.controller" />',
// 	 				cache: false,
// 	 				processData: false,
// 	 				data: {
// 	 					tripOrder:$("#tripDetailForm")
// 	 				},
// 	 				success: function(){
// 	 					alert("deleteeeeee");
// 	 				}
// 	 			});	 	
// 	 		});
// 		});
		

	});  /* onload function end */
 	
	//呼叫servlet把cart裡的東西寫到DB
	function saveTripDetailCart() {		
		var jqxhr = $.post({		                
            url: '<c:url value="/_02_TripAndJournal/member/SaveTripDetailCart.controller" />',
            cache: false,            
            success: function(){
            	//資料回填?
            	$("#divSaveSuccess").dialog({
					resizable: false,					
					height:150,
					modal: true,
					buttons: {
						"確認": function() {							
							$( this ).dialog( "close" );
							//導向我的行程頁，按瀏覽器"上一頁"看不到東西
							window.location.replace('<c:url value="/_05_Member/member/MemberTrip.jsp" />');						
						}
					}
				})            	
            }
        }).fail(function(){
        	alert("儲存失敗");
        	//要再改成按鈕，後續處理?
        });		
		
	};	
	
	//修改單筆tripDetail
// 	function updateTripDetail() {
// 		$.post({
// 			url: '<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />',
// 			cache: false,
// 			processData: false,
// 			data: $('.tripDetailForm'+sightId).serialize(),	//把form裡面的資料變成字串送出			
// 			success: function(){
				//資料回填?
				//跳出確認的對話框
// 				$("#divUpdateSuccess").dialog({
// 					resizable: false,					
// 					height:150,
// 					modal: true,
// 					buttons: {
// 						"確認": function() {							
// 							$( this ).dialog( "close" );												
// 						}
// 					}
// 				})
// 				location.reload();
// 			}
// 		});		
// 	}
	
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
			<h2 class="h2">行程名稱：${tripVO.tripName}</h2>					
			<div id="days">
				<p>tripId：${tripVO.tripId}</p>
				<p>行程開始日期：<br>${tripVO.tripStartDate}</p>
<%-- 				<p>本行程共<%=dateDiff%>天</p> --%>
				<p>行程開始時間：<br>${tripVO.startTime}</p>
				<button id="btnBudget" class="btn btn-info">預算一覽</button><br>				
				<button id="add_new">加一天</button>
			</div> <!-- end div 選天數 -->
			<div id="trip">
				<div id="tripBut">					
				</div>	<!-- end div tripBut -->						
				<div class="day">
					<div class="tripDetail">
						<div class="placeholder">請將景點拖曳到此</div>						
						<!-- 拖過來的tripDetail長會在這裡 -->	
						<!-- 如果是舊的行程拿出來改，要從session取出tripDetailCart -->
						<c:if test="${not empty sessionScope.tripDetailCart}">										
						<c:forEach var="tripDetailVO" items="${sessionScope.tripDetailCart}">
<%-- 						<c:if test="${tripDetailVO.tripId==tripVO.tripId}"> --%>
							<form id="tripDetailForm" action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post">
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
								<td><input type="submit" value="修改"/><br>
								<c:url value="/_02_TripAndJournal/member/DelTripDetail.controller" var="path" scope="page">
									<c:param name="tripOrder" value="${tripDetailVO.tripOrder}" />									
								</c:url>
								<input type="button" value="刪除" onclick="location.href='${path}'"></td>
							</tr>
							<tr hidden="true">
								<td hidden="true"><label>停留時間：</label><input type="hidden" name="stayTime" value="${tripDetailVO.stayTime}" size="10"/></td>
								<td hidden="true"><input type="hidden" name="tripOrder" value="${tripDetailVO.tripOrder}" size="5" /></td>
								<td rowspan="2" hidden="true"><input type="hidden" name="sightId" value="${tripDetailVO.referenceNo}"/></td>
								<td hidden="true"><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td>							
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
							</form>							
<%-- 						</c:if> --%>
						</c:forEach>						
						</c:if>						
					</div>
   				</div>	<!-- end div day -->   				
			</div>	<!-- end div 行程 -->
		</div>	<!-- end div left -->
		<div id="right">
			<div id="divsaveTrip"><button id="saveTrip" class="btn btn-info">儲存行程</button></div>
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
		
		<!-- 修改tripDeatil成功觸發的對話框 -->
<!-- 		<div id="divUpdateSuccess" title="修改成功" hidden="true"> -->
<!-- 			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>修改成功</p> -->
<!-- 		</div>	end div divUpdateSuccess -->
		
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
