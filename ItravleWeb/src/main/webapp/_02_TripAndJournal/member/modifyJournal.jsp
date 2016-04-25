<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel修改遊記</title>
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
		<h3>修改遊記</h3>

		<table>
			<tr>
				<td>遊記名稱:</td>
				<td colspan="2"><input type="text" name="journalName"
					value="${modifyVO.journalName}"></td>
				<td>地區:</td>
				<td><select name="regionId">
						<c:forEach var="region" items="${region}">
							<option value="${region.codeId}">${region.codeName}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>旅行日期：</td>
				<td>開始日期:</td>
				<td><input name="journalStartDate" type="text"
					value="${modifyVO.beginTime}" placeholder="${modifyVO.beginTime}"></td>
				<td>結束日期:</td>
				<td><input name="journalEndDate" type="text"
					value="${modifyVO.endTime}" placeholder="${modifyVO.endTime}"></td>
			</tr>
			<tr>
				<td>遊記簡介</td>
				<td colspan="4"><textarea name="journalIntro" rows="4"
						cols="40">${modifyVO.journalIntro}</textarea></td>
			</tr>
			
		</table>
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
			<c:forEach var="modifyDetailVO" items="${modifyDetailVO}">			
				<c:forEach var="SightVO" items="${SightService.all}">          
					<c:if test="${SightVO.sightId==modifyDetailVO.sightId}">							    
						<input type="hidden" name="journalDetailId" value="${modifyDetailVO.journalDetailId}">
						<input type="hidden" name="sightId" value="${modifyDetailVO.sightId}">
						<input type="hidden" name="sightOrder" value="${modifyDetailVO.sightOrder}">
						<input type="hidden" name="whichDay" value="${modifyDetailVO.whichDay}">
						<input type="hidden" name="journalId" value="${modifyDetailVO.journalId}">	
						<input type="hidden" name="JournalPhotoId" value="${modifyPhotoVO.journalPhotoId}">									
						<input type="hidden" name="crud" value="Update">									
						<tr>				
							<td>${SightVO.sightName}</td>
							<td><textarea name="sightJournal" >${modifyDetailVO.sightJournal}</textarea><span class="error">${error.sightJournal}</span></td>
						</tr>		
					</c:if>				
				</c:forEach>
		  </c:forEach>
		  		<tr><td><input type="submit" value="修改" id="saveJournal" class="btn btn-info btn-lg"/></td>	</tr>
		 </table>
    </form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>


</body>
</html>