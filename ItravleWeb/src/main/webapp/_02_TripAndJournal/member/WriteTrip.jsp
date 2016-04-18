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
<jsp:useBean id="sightSvc" scope="page" class="_01_Sight.model.SightService" />
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
<script>
var sightId;
var spendHour;

	$(function() {
				
		var tripId = '${tripVO.tripId}';
		var sightName;
		var newIndex;
		
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
 			}
		});	
		
		//從session取得tripDetailCart裡有幾筆
		var i = '${sessionScope.count}';
		//讓左邊行程可被放下
		$(".day").droppable({
			appendTo: "#day1",  //要黏到的目標				
			accept: ".sight",	//只能接受sight class的物件
			activeClass: "ui-state-highlight",	//凸顯此區域是可以被放置的
			drop : function(event, ui) {
				$(this).find(".placeholder").remove();	//移除Add your items here
				//放下的時候黏form上去，一個tirpDetail是一個form
				$(".tripDetail").append('<form class="tripDetailForm'+sightId+'" action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post"></form>');
				//把table黏上去
				$(".tripDetailForm"+sightId).html('<table><tr class="delTripDetail"><td rowspan="2" class="tripDetailPic'+sightId+'"></td><td rowspan="2"><span class="tripDetailSightId'+sightId+'"></span></td><td rowspan="2"><span class="tripDetailSightName'+sightId+'"></span></td><td rowspan="2"><input type="hidden" name="sightId" value="'+sightId+'"/></td><td><label>行程順序：</label><span class="tripDetailOrder'+sightId+'"></span></td><td><label>停留時間：</label><input type="text" name="stayTime" value="' + spendHour + '" size="10" /></td><td><label>預算：</label><input type="text" name="sightBudget" placeholder="請在此輸入預算" /></td><td><input type="submit" value="修改"/></td><td><button>刪除</button></td></tr><tr><td colspan="4"><label>筆記：</label><textarea name="notes" rows="3" cols="70"></textarea></td></tr><tr><td><input type="hidden" name="tripId" value="${tripVO.tripId}" /><P/></td><td><input type="hidden" name="whichDay" value=1 /><P/></td><td><input type="hidden" name="referenceType" value="type_id01" /><P/></td></tr></table>');
				//依照sightId抓到圖片，黏到剛剛的tr裡面
				$(".tripDetailPic"+sightId).html('<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=' + sightId + '" />" width="120" height="90">');
				//抓到sightId，黏到剛剛的tr裡面
 				$(".tripDetailSightId"+sightId).html(sightId);
 				//抓到sightName，黏到剛剛的tr裡面
 				$(".tripDetailSightName"+sightId).html(sightName); 				
 				var order = i;
 				console.log("" + order);
 				$(".tripDetailOrder"+sightId).html('<input type="text" name="tripOrder" value="'+ order +'"/>'); 				
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
// 	                	location.reload();
	                	alert("Insertion successful!");
	                }
	            }).fail(function(){
	            	alert("購物車更新失敗");
	            	//要再改成按鈕，按下後把畫面上的那一筆tripDetail刪除
	            });
			}		
		});
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
 		var dialog2;
			dialog2 = $( "#mysight" ).dialog({
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
		$("tr.sightId>td:nth-child(9)").each(function(){
			$(this).click(function(){
					var sightId=$(this).prev().prev().prev().prev().prev().prev().prev().prev().text();	
					console.log(sightId);
					var stylei=' width="98%" height="98%"  frameborder="0" scrolling="auto"';
					$("#mysight").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
					dialog2.dialog( "open" );
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
		var dialog = $( "#dialog-confirm" ).dialog({
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
		      dialog.dialog( "open" );
	    });		

	});
	
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
							window.location.replace('<c:url value="/_05_Member/member/MyTrip.jsp" />');						
						}
					}
				})            	
            }
        }).fail(function(){
        	alert("儲存失敗");
        	//要再改成按鈕，後續處理?
        });
	};
	
	//刪除單筆tripDetail
	$("tr.delTripDetail>td:last-child").each(function(){
		$(this).hide();
	});
// 	$("button.delTripDetail").each(function() {
// 		$(this).css("color", "red");
// 		click(function() {
// 			alert("555555555555555555555555");
// 			$.post({
// 				url: '<c:url value="/_02_TripAndJournal/member/DelTripDetail.controller" />',
// 				cache: false,
// 				processData: false,
// 				success: function(){
// 					alert("deleteeeeee");
// 				}
// 	// 			data: $('.tripDetailForm'+sightId).serialize(),
// 			});
// 		});
// 	});
	
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
	<article>	
		<!-- 	景點dialog顯示頁面 平時隱藏 -->
		<div id="mysight" title="景點明細"></div>	
	<p>${pageContext.session.id}</p>
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
						<button id="btnBudget">預算一覽</button>							
						<button id="btnPartner">旅伴</button>
						<button id="saveTrip">儲存行程</button>																		
					</td>
				</tr>
			</table>		
			<div id="days">
				<p>行程開始日期：<br>${tripVO.tripStartDate}</p>
<%-- 				<p>本行程共<%=dateDiff%>天</p> --%>
				<p>行程開始時間：<br>${tripVO.startTime}</p>
				<p>主要交通方式：${tripVO.transFormId}</p>				
				<p>第一天：</p>
				<p>第二天：</p>
				<p>第三天：</p>
				<button id="add_new">加一天</button>
			</div> <!-- end div 選天數 -->
			<div id="trip">
				<div id="tripBut">										
					<span><input type="button" value="顯示預算" name="show budget"></span>
					<span><input type="button" value="顯示筆記" name="show notes"></span>					
				</div>	<!-- end div tripBut -->						
				<div class="day">第一天
					<div class="tripDetail">
						<!-- 拖過來的tripDetail長會在這裡 -->	
						<!-- 如果是舊的行程拿出來改，要從session取出tripDetailCart -->
						<c:if test="${not empty sessionScope.tripDetailCart}">										
						<c:forEach var="tripDetailVO" items="${sessionScope.tripDetailCart}">
<%-- 						<c:if test="${tripDetailVO.tripId==tripVO.tripId}"> --%>
							<form id="tripDetailForm" action="<c:url value="/_02_TripAndJournal/member/TripDetail.controller" />" method="post">
							<table>
							<tr class="delTripDetail">
								<td rowspan="2"><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${tripDetailVO.referenceNo}" />" width="120" height="90"></td>
								<td rowspan="2">${tripDetailVO.referenceNo}</td>
								<td rowspan="2" class="sightName">
									<c:forEach var="sightVO2" items="${sightSvc.all}">
                            			 <c:if test="${sightVO2.sightId==tripDetailVO.referenceNo}">
												${sightVO2.sightName}
                             			</c:if>
									</c:forEach>
								</td>
								<td rowspan="2"><input type="hidden" name="sightId" value="${tripDetailVO.referenceNo}"/></td>
								<td><label>行程順序111：</label><input type="text" name="tripOrder" value="${tripDetailVO.tripOrder}" size="5" /><P/></td>
								<td><label>停留時間：</label><input type="text" name="stayTime" value="${tripDetailVO.stayTime}" size="10"/></td>
								<td><label>預算：</label><input type="text" name="sightBudget" value="${tripDetailVO.sightBudget}" /></td>
								<td><input type="submit" value="修改"/></td>
								<td><button>刪除</button></td>
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
<%-- 						</c:if> --%>
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
			<%  int rowsPerPage = 10;  //每頁的筆數 %>
			<%@ include file="/_00_Misc/page1.file" %>
				<c:forEach var="sightVO" items="${sightVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
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
					<td><button class="label label-primary">詳情</button></td>					
				</tr>
				</table>
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
