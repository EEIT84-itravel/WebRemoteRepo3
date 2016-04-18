<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 外接程式碼 -->
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	SightService sightService = new SightService();
 	List<SightVO> sightVO = sightService.select();
 	pageContext.setAttribute("sightVO", sightVO);
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel後台:管理景點</title>
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
		$("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
		//景點詳情dialog功能
		var uri="${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
 		var dialog;
	    dialog = $( "#dialog-form" ).dialog({
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

		$("tr.sightId>td:nth-child(2)").each(function(){
			$(this).click(function(){
					var sightId=$(this).prev().text();	
					console.log(sightId);
					var stylei=' width="98%" height="98%"  frameborder="0" scrolling="auto"';
					$("#dialog-form").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
					dialog.dialog( "open" );
					closedialog = 0;
			});
		});
		var closedialog;
		 function overlayclickclose() {
		        if (closedialog) {
		            $('#dialog-form').dialog('close');
		        }
		        closedialog = 1;//set to one because click on dialog box sets to zero   
		    }
	});

</script>
<style type="text/css">
.ui-tabs-vertical {
	width: 100%;
}
.ui-tabs-vertical .ui-tabs-nav {
	padding: .2em .1em .2em .2em;
	float: left;
	width: 12em;
}
.ui-tabs-vertical .ui-tabs-nav li {
	clear: left;
	width: 100%;
	border-bottom-width: 1px !important;
	border-right-width: 0 !important;
	margin: 0 -1px .2em 0;
}
.ui-tabs-vertical .ui-tabs-nav li a {
	display: block;
}
.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active {
	padding-bottom: 0;
	padding-right: .1em;
	border-right-width: 1px;
}
.ui-tabs-vertical .ui-tabs-panel {
	padding: 1em;
	float: right;
	width: 40em;
}
#tabs-1{
	float:left;
	width: 82%;
	padding: 0;
	margin: 5px;
}
#tabs-1 h2{
	margin: 5px;
}
.backendTable thead tr th{
	text-align:center
}
/* 由jQueryUI長出來的分頁id */
#ui-id-3{
width: 82%;
padding: 0;
margin: 5px;
float: left;
}
#ui-id-3 h2{
	margin: 5px;
}
</style>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<!-- import共同的 -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
	    <div id="dialog-form"></div>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">管理景點</a></li>
				<li><a href="<c:url value="/_06_BackEnd/backend/AllMember.jsp" />	">管理會員</a></li>
				<li><a href="<c:url value="/_06_BackEnd/backend/AllTrip.jsp" />	">管理行程</a></li>
				<li><a href="<c:url value="/_06_BackEnd/backend/AllJournal.jsp" /> ">管理遊記</a></li>
				<li><a href="<c:url value="/_06_BackEnd/backend/AllForum.jsp" />	">管理討論區</a></li>
				<li><a href="<c:url value="/_06_BackEnd/backend/AllEvent.jsp" />	">管理活動</a></li>
			</ul>
		<div id="tabs-1">
			<h2>I-Travel後台:管理景點</h2>
			<a href="<c:url value="/_06_BackEnd/backend/NewSight.jsp" />">新增景點</a>
					<div>
					<%  int rowsPerPage = 20;  //每頁的筆數 %>
					<%@ include file="/_00_Misc/page1.file" %>
						<table border="1" class="backendTable">
							<thead>
								<tr>
									<th>景點編號</th>
									<th>景點名稱</th>
									<th>地區</th>
									<th>縣市</th>
									<th>景點類型</th>
									<th>電話</th>
									<th>地址</th>
									<th>修改人</th>
									<th>修改時間</th>
									<th>顯示</th>
									<th>修改</th>
								</tr>
							</thead>
							<tbody> 
								<c:forEach var="sightVO" items="${sightVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr class="sightId">							
									<td>${sightVO.sightId}</td>
									<td>${sightVO.sightName}</td>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.regionId}">
								            <td>${codeVO.codeName}</td>
                                		 </c:if>
									</c:forEach>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.countyId}">
								         	<td>${codeVO.codeName}</td>
                                	  	</c:if>
									</c:forEach>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								             	<td>${codeVO.codeName}</td>
                                	    </c:if>
									</c:forEach>
									<td>${sightVO.phone}</td>
									<td>${sightVO.addr}</td>
									<td>${sightVO.modifier}</td>
									<td>${sightVO.modifyTime}</td>
									<td>${sightVO.del}</td>
									<td> 
										<FORM METHOD="post" enctype="multipart/form-data" ACTION="<c:url value="/_06_BackEnd/backEnd/BackendSight.controller" />">
			     							<input style="color:black" type="submit" value="修改">
			     							<input type="hidden" name="action" value="getOne">
			     							<input type="hidden" name="sightId" value="${sightVO.sightId}">
			     						</FORM>
			     					</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<%@ include file="/_00_Misc/page2.file" %>
					</div>
			</div><!-- tabs-1 end tag -->
		</div>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
