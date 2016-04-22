<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="_00_Misc.model.CodeVO"%>
<%@ page import="_00_Misc.model.CodeService"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="TripDetailService" scope="page"
	class="_02_TripAndJournal.model.TripDetailService" />
<jsp:useBean id="TripService" scope="page"
	class="_02_TripAndJournal.model.TripService" />
<jsp:useBean id="SightService" scope="page"
	class="_01_Sight.model.SightService" />
<%
	CodeService service = new CodeService();
	List<CodeVO> region = service.select("region");
	pageContext.setAttribute("region", region);
%>
<style>
textarea{/* Text Area 固定大小*/
 max-width:250px;
 max-height:100px;
 width:250px;
 height:100px;
 margin: 5px;
}
</style>
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/writeJournal.css"/>" />
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
// 		$('input[type="file"]').css('background-color','red');
		//起始日期用jQuery UI
		$('input[name="journalStartDate"]').datepicker({
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="journalEndDate"]').datepicker({
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin
	});
	  //選圖立即顯示
	  var openFile = function(event) {
	    var input = event.target;

	    var reader = new FileReader();
	    reader.onload = function(){
	      var dataURL = reader.result;
	      var output = document.getElementById('output');
	      output.src = dataURL;
	    };
	    reader.readAsDataURL(input.files[0]);
	  };

</script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<title>ITravel-建立新遊記</title>
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
		<h3>撰寫新遊記</h3>

		<table>
			<tr>
				<td>遊記名稱:</td>
				<td colspan="2"><input type="text" name="journalName"
					value="${journalVO.journalName}"></td>
				<td>地區:</td>
				<td><select name="regionId">
						<c:forEach var="region" items="${region}">
							<option value="${region.codeId}">${region.codeName}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>旅行日期-</td>
				<td>開始日期:</td>
				<td><input name="journalStartDate" type="text"
					value="${journalVO.beginTime}" placeholder="${journalVO.beginTime}"></td>
				<td>結束日期:</td>
				<td><input name="journalEndDate" type="text"
					value="${journalVO.endTime}" placeholder="${journalVO.endTime}"></td>
			</tr>
			<tr>
				<td>遊記簡介</td>
				<td colspan="4"><textarea name="journalIntro" rows="4"
						cols="40">${journalVO.journalIntro}</textarea></td>
			</tr>
			
		</table>
<!-- 		判斷暫存的車裡是否有東西 -->
<form action="<c:url value="/_02_TripAndJournal/member/JournalDetail.controller"/>" method="post" enctype="multipart/form-data">
	<table>
	   <tr>		
	      <td>選擇遊記主圖：</td>		
		  <td><input type="file" name="journalPic"  onchange='openFile(event)' class="btn btn-info btn-lg">
		  <div><img id='output'></div>

	   </tr>
	    <tr>
			<td>詳細遊記</td>
     	</tr>
		<c:if test="${not empty sessionScope.journalDetailCart}">
			<c:forEach var="journalDetailVO" items="${sessionScope.journalDetailCart}">			
				<c:forEach var="SightVO" items="${SightService.all}">
							
<!-- 				若是暫存車裡的景點id跟景點VO的景點id相同，則印出景點名字 -->             
					<c:if test="${SightVO.sightId==journalDetailVO.sightId}">							    
						<input type="hidden" name="journalDetailId" value="${journalDetailVO.journalDetailId}">
						<input type="hidden" name="sightId" value="${journalDetailVO.sightId}">
						<input type="hidden" name="sightOrder" value="${journalDetailVO.sightOrder}">
						<input type="hidden" name="whichDay" value="${journalDetailVO.whichDay}">
						<input type="hidden" name="journalId" value="${journalDetailVO.journalId}">
						<input type="hidden" name="JournalPhotoId" value="${JournalPhotoVO.JournalPhotoId}">					
						<input type="hidden" name="crud" value="Insert">
						<tr>				
							<td>${SightVO.sightName}</td>
							<td><textarea name="sightJournal" >${showJournalDetailVO.sightJournal}</textarea><span class="error">${error.sightJournal}</span></td>
						</tr>
						
					</c:if>				
				</c:forEach>
		  </c:forEach>
		</c:if>
				<tr><td><input type="submit" value="修改" id="saveJournal" class="btn btn-info btn-lg"/></td>	</tr>
		 </table>
    </form>
    	<!-- 儲存行程觸發的對話框 -->
<!-- 		<div id="dialog-confirm" title="確認儲存?" > -->
<!--  			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>確定要儲存嗎?</p> -->
<!-- 		</div>	 -->

		
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
