<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 外接程式碼 -->
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<%
	ForumService forumService = new ForumService();
 	List<ForumVO> forumVO = forumService.select();
 	pageContext.setAttribute("forumVO", forumVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/datatable.css" />
<link rel="stylesheet" type="text/css" href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css"/>
 
<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
//DataTable設定
var opt={
	"sDom": '<"top">tf<"bottom"p><"clear">',	
	"oLanguage":{"sProcessing":"處理中...",
    "sLengthMenu":"顯示 _MENU_ 項結果",
    "sZeroRecords":"沒有匹配結果",
    "sInfo":"顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
    "sInfoEmpty":"顯示第 0 至 0 項結果，共 0 項",
    "sInfoFiltered":"(從 _MAX_ 項結果過濾)",
    "sSearch":"關鍵字搜尋:",
    "oPaginate":{"sFirst":"首頁",
                         "sPrevious":"上一頁",
                         "sNext":"下一頁",
                         "sLast":"最末頁"}
    }
};
$(document).ready(function(){
	$("#forum").DataTable(opt);
})

</script>
<title>ITravel討論區</title>
</head>
<body>
	<form action="<c:url value="/_04_Forum/Forum.controller"/>"
		method="post">
		<div id="header">
			<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
			<table id="forum" border="1">
				<thead>
					<tr id="forumTitle">
						<th>討論類型</th>
						<th>討論主題</th>
						<th>作者</th>
						<th>瀏覽人次</th>
						<th>回覆數</th>
						<th>最後發表</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty forumVO1}">
					<c:forEach var="forumVO" items="${forumVO}">
						<tr>							
							<td>${forumVO.forumTypeId}</td>
							<td><a
								href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO.forumId}" />">${forumVO.forumTopic}</a></td>
							<td>${forumVO.memberId}</td>
							<td>${forumVO.visitorNum}</td>
							<td>${forumVO.replyNum}</td>
							<td>${forumVO.forumTime}</td>
						</tr>
					</c:forEach>
					</c:if>
						<c:forEach var="forumVO1" items="${forumVO1}">
						<tr>							
							<td>${forumVO1.forumTypeId}</td>
							<td><a
								href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO1.forumId}" />">${forumVO1.forumTopic}</a></td>
							<td>${forumVO1.memberId}</td>
							<td>${forumVO1.visitorNum}</td>
							<td>${forumVO1.replyNum}</td>
							<td>${forumVO1.forumTime}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>