<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_01_Sight.model.dao.*"%>
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
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.selectByType("sight_type02");
	pageContext.setAttribute("sightVO", sightVO);
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HotelSights</title>
<script>
var sightId;
var spendHour;
var sightName;
var latitude;	//緯度
var longitude;  //經度

$(function(){
	
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
	//景點詳情dialog功能
		var uri="${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
		var dialog;
		dialog = $( "#dialog-shopping" ).dialog({
        autoOpen: false,
        height: 700,
        width: 550,
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
 				$("#dialog-shopping").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
 				dialog.dialog( "open" );
				closedialog = 0;
 		});
 	});
 	var closedialog;
 	 function overlayclickclose() {
 	        if (closedialog) {
 	            $('#dialog-shopping').dialog('close');
 	        }
 	       closedialog = 1;//set to one because click on dialog box sets to zero
 	    }	
 });  //end document.ready
</script>
</head>
<body>
    	<!-- 	景點dialog顯示頁面 平時隱藏 -->
		<div id="dialog-shopping" ></div>	
		<%  rowsPerPage = 10;  //每頁的筆數 
			rowNumber=sightVO.size(); %>
		<%@ include file="/_00_Misc/page1.file" %>
				<c:forEach var="sightVO" items="${sightVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
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
				</c:forEach>
				<%@ include file="/_00_Misc/page2.file" %>

</body>
</html>
