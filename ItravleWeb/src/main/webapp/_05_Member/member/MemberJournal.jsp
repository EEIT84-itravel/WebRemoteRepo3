<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="codeSvc" scope="page"
	class="_00_Misc.model.CodeService" />
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
JournalService journalservice = new JournalService();
MemberVO user = (MemberVO)session.getAttribute("user");
int memberId = user.getMemberId();
List<JournalVO> journalVO = journalservice.selectMemberJournal(memberId);
pageContext.setAttribute("journalVO", journalVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css"
	href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />

<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript"
	src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
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
	$(document).ready(function() {
		$("#forum").DataTable(opt);
	})
</script>
<title>我的遊記</title>
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
	<table id="forum" border="1">
	<thead>
				<tr id="forumTitle">
				    <th>遊記照片</th>
					<th>遊記名字</th>
					<th>起始日期</th>
					<th>最後修改時間</th>
					<th>人氣</th>
					<th>發佈狀態</th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty journalVO}">
			<c:forEach var="journalVO" items="${journalVO}">
			<tr>
			<td><img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />" width="240" height="180"></td>
			<td>${journalVO.journalName}</td>
			<td>${journalVO.beginTime}</td>
			<td>${journalVO.modifyTime}</td>
			<td>${journalVO.visitorNum}</td>
			<td>
	        <c:if test="${journalVO.post==false}">
			未發佈
			</c:if>		
			<c:if test="${journalVO.post==true}">
			已發佈
			</c:if>		
			</td>
			<td><a href="<c:url value="/_05_Member/member/changejournalpost.controller?journalId=${journalVO.journalId}"/>">改變發佈狀態</a>&nbsp;&nbsp;</td>
			<td><a href="<c:url value="/_05_Member/member/.controller?journalId=${journalVO.journalId}"/>">修改遊記</a>&nbsp;&nbsp;</td>
			<td><a href="<c:url value="/_05_Member/member/delmyjournal.controller?journalId=${journalVO.journalId}"/>">刪除遊記</a>&nbsp;&nbsp;</td>
			</tr>
			</c:forEach>
			</c:if>
			</tbody>
	</table>
	</article>
</body>
</html>