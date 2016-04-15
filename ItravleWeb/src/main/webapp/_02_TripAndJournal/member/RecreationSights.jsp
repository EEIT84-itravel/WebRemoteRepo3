<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_01_Sight.model.dao.*"%>
<%@ page import="java.util.*"%>
<!-- 以下的要再改成jQuery 的ajax   不要在jsp出現java code -->

<%
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.selectByType("sight_type05");
	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RecreationSights</title>
<script>
$(function(){
	//景點詳情dialog功能
		var uri="${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
		var dialog;
		dialog = $( "#dialog-recreation" ).dialog({
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
	$("tr.sightId>td:nth-child(7)").each(function(){
 		$(this).click(function(){
 				var sightId=$(this).prev().prev().prev().prev().prev().prev().text();	
 				console.log(sightId);
				var stylei=' width="98%" height="98%"  frameborder="0" scrolling="auto"';
 				$("#dialog-recreation").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
 				dialog.dialog( "open" );
				closedialog = 0;
 		});
 	});
 	var closedialog;
 	 function overlayclickclose() {
 	        if (closedialog) {
 	            $('#dialog-recreation').dialog('close');
 	        }
 	       closedialog = 1;//set to one because click on dialog box sets to zero
 	    }	
 });
 
	$(".sight").draggable({
		helper : "clone" //只拖動複製的圖片，原始圖片保持不動
	});
</script>
</head>
<body>
		<!-- 	景點dialog顯示頁面 平時隱藏 -->
		<div id="dialog-recreation" ></div>
	RecreationSights.jsp
	<c:forEach var="sightVO" items="${sightVO}">
		<table class="sight">
			<tr class="sightId">
				<td hidden="true">${sightVO.sightId}</td>
				<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" width="80" height="60"></td>
				<td>${sightVO.sightName}</td>
				<td>${sightVO.score}分</td>
				<td>評論</td>
				<td>最愛</td>
				<!-- 景點彈出視窗功能 -->
				<td><button class="label label-primary">詳情</button></td>
			</tr>
		</table>
	</c:forEach>
</body>
</html>