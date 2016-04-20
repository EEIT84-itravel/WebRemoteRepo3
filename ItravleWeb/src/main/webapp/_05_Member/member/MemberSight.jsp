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
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- Datatables css -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js" />"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<!-- Datatables-->
<script type="text/javascript" src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	//DataTable設定
	var opt = {
		"sDom" : '<"top">tf<"bottom"p><"clear">',
		"oLanguage" : {
			"sProcessing" : "處理中...",
			"sLengthMenu" : "顯示 _MENU_ 項結果",
			"sZeroRecords" : "沒有匹配結果",
			"sInfo" : "顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
			"sInfoEmpty" : "顯示第 0 至 0 項結果，共 0 項",
			"sInfoFiltered" : "(從 _MAX_ 項結果過濾)",
			"sSearch" : "關鍵字搜尋:",
			"oPaginate" : {
				"sFirst" : "首頁",
				"sPrevious" : "上一頁",
				"sNext" : "下一頁",
				"sLast" : "最末頁"
			}
		}
	};
	$(function() {
		$("#forum").DataTable(opt);
	});
</script>
<title>${user.firstName}的收藏景點</title>
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
	<div id="header">
	<c:import url="/_05_Member/member/SightHead.jsp"></c:import>
		<table id="forum" border="1">
			<thead>
				<tr id="forumTitle">
					<th>景點圖片</th>
					<th>景點名稱</th>
					<th>景點所在縣市</th>
					<th>景點評分</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty sightVO1}">
				<c:if test="${empty noSightVO}">
					<c:forEach var="sightVO" items="${sightVO}">
						<tr>
							<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" width="100" height="50"></td>
							<td>${sightVO.sightName}</td>
							<c:forEach var="codeVO" items="${codeSvc.all}">
								<c:if test="${codeVO.codeId==sightVO.countyId}">
									<td>${codeVO.codeName}</td>
								</c:if>
							</c:forEach>
							<td>${sightVO.score}</td>  
							<td><a href="<c:url value="/_05_Member/member/delsight.controller?referenceType=${sightVO.sightId}&typeId=type_id01&regionId=region00"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
						</tr>
					</c:forEach>
				</c:if>
				</c:if>
				
				<c:forEach var="sightVO1" items="${sightVO1}">
					<tr>
						<td><img alt="" src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO1.sightId}" />" width="100" height="50"></td>
						<td>${sightVO1.sightName}</td>
						<c:forEach var="codeVO" items="${codeSvc.all}">
							<c:if test="${codeVO.codeId==sightVO1.countyId}">
								<td>${codeVO.codeName}</td>
							</c:if>
						</c:forEach>
						<td>${sightVO1.score}</td>
						<td><a href="<c:url value="/_05_Member/member/delsight.controller?memberId=${user.memberId}&referenceType=${sightVO1.sightId}&typeId=type_id01&regionId=${param.regionId}"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</article>
</body>
</html>