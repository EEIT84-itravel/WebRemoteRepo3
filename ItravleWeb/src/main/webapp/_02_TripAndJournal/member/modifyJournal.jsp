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
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_00_Misc/main.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_02_TripAndJournal/ModifyJournal.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
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
		<h1>修改遊記</h1>
		<fieldset id="introDiv">
		<legend><mark>遊記基本資訊</mark></legend>
		<div class="form-horizontal">
		<form action="<c:url value="/_02_TripAndJournal/member/ModifyJournalIntro.controller"/>" method="post">
		<input type="hidden" name="journalId" value="${modifyVO.journalId}">
		<input type="hidden" name="visitorNum" value="${modifyVO.visitorNum}">
		<input type="hidden" name="memberId" value="${user.memberId}">			
		<input type="hidden" name="post" value="${modifyVO.post}">	
		<input type="hidden" name="crud" value="Update">	
			
			<div class="form-group">
				<h4><label class="control-label col-sm-3">遊記名稱：</label></h4>
				<div class="col-sm-6">
					<input class="form-control" type="text" name="journalName" value="${modifyVO.journalName}"/><span class="error">${error.journalName}</span>				    
				    <span class="errorMsg">${error.journalName}</span>
				</div>
			</div>
			<div class="form-group">
				<h4><label class="control-label col-sm-3">遊玩地區：</label></h4>
				<div class="col-sm-3">
					<select name="regionId">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}">${region.codeName}</option>
							</c:forEach>
					</select>			    
				</div>
			</div>
			<div class="form-group">
				<h4><label class="control-label col-sm-3">旅行日期：</label></h4>
				<div class="col-sm-3">
				<input name="journalStartDate" type="text" value="${modifyVO.beginTime}"	placeholder="${modifyVO.beginTime}">至<input name="journalEndDate" type="text" value="${modifyVO.endTime}" placeholder="${modifyVO.endTime}">
				</div>
			</div>
			<div class="form-group">
				<h4><label class="control-label col-sm-3">遊記簡介：</label></h4>
				<div class="col-sm-6">
				<textarea name="journalIntro" rows="4" id="jBody" class="textBody form-control" cols="40">${modifyVO.journalIntro}</textarea>
				<span class="errorMsg">${error.journalIntro}</span>
				</div>
			</div>
			<div class="form-group"  style="text-align: center;">
			<input type="submit" value="儲存基本資訊" class="btn-success btn-lg">
		    </div>
		</form>
		</div>				
		</fieldset>
		<!-- 詳細遊記   -->
		<fieldset id="journalDetailDiv">
		<legend><mark>景點遊記</mark></legend>
		<div class="form-horizontal">
		<form action="<c:url value="/_02_TripAndJournal/member/JournalDetail.controller"/>"	method="post" enctype="multipart/form-data">
			<div class="form-group">
				<h4><label class="control-label col-sm-3">選擇遊記主圖：</label></h4>
				<div class="col-sm-9">
				<input type="file" name="journalPic"
						onchange='openFile(event)' class="btn btn-info btn-lg">
						<div>
							<img id='output'>
						</div>
				</div>
			</div>
						
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
								
								<div class="form-group">
									<h4><label class="control-label col-sm-3">${SightVO.sightName}：</label></h4>
									<div class="col-sm-6" id="jBody">
									<textarea name="sightJournal" rows="5" cols="50" class="textBody form-control">${modifyDetailVO.sightJournal}</textarea><span
										class="errorMsg">${error.sightJournal}</span>
									</div>
								</div>
								

							</c:if>
						</c:forEach>
					</c:forEach>
				
				<div class="form-group"  style="text-align: center;">
					<input type="submit" value="儲存遊記" id="saveJournal" onclick="if(confirm('您確定修改遊記嗎?')) return true;else return false"
						class="btn btn-success btn-lg" />
		   		 </div>			
		</form>
		</div>
		</fieldset>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>


</body>
</html>