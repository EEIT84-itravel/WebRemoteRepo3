<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
	CollectionService collectionService = new CollectionService();
    SightService sightService = new SightService();
    MemberVO user = (MemberVO)session.getAttribute("user");
    int memberId = user.getMemberId();
 	List<CollectionVO> collectionVO = collectionService.selectByMemberId(memberId);
 	ArrayList<Integer> sightID = new ArrayList<Integer>();
 	ArrayList<SightVO> sightVO = new ArrayList<SightVO>();
 	if (collectionVO != null) {
 		for (int i = 0; i < collectionVO.size(); i++) {
 			int a = collectionVO.get(i).getReferenceType();
 			sightID.add(a);
 		}
 	}
 	if(sightID != null){
 		for (int i = 0; i < sightID.size(); i++) {
 			SightVO temp = sightService.selectById(sightID.get(i)); 
 			sightVO.add(i, temp);
 		}
 	}
 	pageContext.setAttribute("sightVO", sightVO);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/Member.css"/>" />
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js" />"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
$(function() {
	//景點詳情dialog功能
	var uri = "${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
	var dialog;
	dialog = $("#dialog-form").dialog({
		autoOpen : false,
		height : 700,
		width : 600,
		draggable : true,
		resizable : false,
		modal : true,
		open : function() {
			closedialog = 1;
			$(document).bind('click', overlayclickclose);
		},
		focus : function() {
			closedialog = 0;
		},
		close : function() {
			$(document).unbind('click');
		}
	});

	$("tr.sightId>td:nth-child(3)").each(function() {
		$(this).click(function() {
			var sightId = $(this).prev().prev().text();
			console.log(sightId);
			var stylei = ' width="98%" height="98%"  frameborder="0" scrolling="auto"';
			$("#dialog-form").html('<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
			dialog.dialog("open");
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
<title>ITravel-${user.nickname}的收藏景點</title>
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
	<h3>會員功能>我的景點</h3>
	<div id="dialog-form"></div>
	<div id="header">
	<c:import url="/_05_Member/member/SightHead.jsp"></c:import>
		<table class="table">
			<thead>
				<tr>
					<th>景點圖片</th>
					<th>景點名稱</th>
					<th>景點所在縣市</th>
					<th>景點類型</th>
<!-- 					<th>景點評分</th> -->
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty sightVO1}">
				<c:if test="${empty noSightVO}">
					<c:forEach var="sightVO" items="${sightVO}">
						<tr class="sightId success">
							<td hidden="true">${sightVO.sightId}</td>
							<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" width="160" height="120" class="img-rounded"></td>
							<td>${sightVO.sightName}  <span class="glyphicon glyphicon-info-sign"></span></td>
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
<%-- 							<td>${sightVO.score}</td>   --%>
							<td><a href="<c:url value="/_05_Member/member/delsight.controller?referenceType=${sightVO.sightId}&typeId=type_id01&regionId=region00"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
						</tr>
					</c:forEach>
				</c:if>
				</c:if>
				<c:forEach var="sightVO1" items="${sightVO1}">
					<tr class="sightId success">
						<td hidden="true">${sightVO1.sightId}</td>
						<td><img alt="" src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO1.sightId}" />" width="160" height="120" class="img-rounded"></td>
						<td><h3 class="h3">${sightVO1.sightName}  <span class="glyphicon glyphicon-info-sign"></span></h3></td>
						<c:forEach var="codeVO" items="${codeSvc.all}">
							<c:if test="${codeVO.codeId==sightVO1.countyId}">
								<td>${codeVO.codeName}</td>
							</c:if>
						</c:forEach>
						<c:forEach var="codeVO" items="${codeSvc.all}">
							<c:if test="${codeVO.codeId==sightVO1.sightTypeId}">
								      <td>${codeVO.codeName}</td>
                            </c:if>
							</c:forEach>
<%-- 						<td>${sightVO1.score}</td> --%>
						<td><a href="<c:url value="/_05_Member/member/delsight.controller?memberId=${user.memberId}&referenceType=${sightVO1.sightId}&typeId=type_id01&regionId=${param.regionId}"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</article>
</body>
</html>