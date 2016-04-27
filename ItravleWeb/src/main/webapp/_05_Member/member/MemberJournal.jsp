<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/Member.css"/>" />
<link rel="stylesheet" type="text/css" href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<title>ITravel-${user.nickname}的遊記</title>
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
	<h3>會員功能>我的遊記</h3>
	<table class="table">
		<thead>
			<tr>
				<th>遊記照片</th>
				<th>遊記名字</th>
				<th>起始日期</th>
				<th>最後修改時間</th>
				<th>人氣</th>
				<th>發佈狀態</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${not empty journalVO}">
		<c:forEach var="journalVO" items="${journalVO}">
			<tr class="journalTr">
				<td><img src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />" width="160" height="120" class="img-rounded"></td>
				<td><a href="<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${journalVO.journalId}" />">${journalVO.journalName}</a></td>
				<td>${journalVO.beginTime}</td>			
				<td><fmt:formatDate value="${journalVO.modifyTime}" timeStyle="short" type="both" /></td>
				<td>${journalVO.visitorNum}</td>
				<td>
			        <c:if test="${journalVO.post==false}">
					未發佈
					</c:if>		
					<c:if test="${journalVO.post==true}">
					已發佈
					</c:if>		
				</td>
					<td>
					<button type="button" class="btn-info btn btn-lg" onclick="location.href='<c:url value="/_05_Member/member/changejournalpost.controller?journalId=${journalVO.journalId}"/>'">改變發佈狀態</button>
				</td>			
				<td>
					<button type="button" class="btn-warning btn btn-lg" onclick="location.href='<c:url value="/_02_TripAndJournal/member/ModifyJournal.controller?crud=Update&journalId=${journalVO.journalId}"/>'">&nbsp;&nbsp;&nbsp;修改遊記&nbsp;&nbsp;&nbsp;</button>				
				</td>
				
			</tr>
		    
		     
		
		</c:forEach>
		</c:if>
		</tbody>
	</table>
	</article>
</body>
</html>
