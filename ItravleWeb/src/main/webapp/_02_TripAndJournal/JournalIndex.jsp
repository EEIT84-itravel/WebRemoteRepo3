<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<% 
	JournalService journalService = new JournalService();
	List<JournalVO> journalVOs = journalService.getAllPost();
	pageContext.setAttribute("journalVOs", journalVOs);
    int rowNumber=0;      //總筆數
    int pageNumber=0;     //總頁數      
    int whichPage=1;      //第幾頁
    int pageIndexArray[]=null;
    int pageIndex=0; 
    int rowsPerPage;
%>
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-遊記首頁</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/JournalIndex.css"/>"/>
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
	<article class="center-block">
		<h3>首頁>看遊記</h3>
		<c:if test="${not empty journalVOs}">
			<div id="divRowsPerPage">
			<%  rowsPerPage = 8;  //每頁的筆數 
				rowNumber=journalVOs.size(); 
			%>
			<%@ include file="/_00_Misc/page1.file" %>
			</div>
			<c:forEach var="row" items="${journalVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
				<c:if test="${row.post==true}">
					<div id="journalDiv">
						<table>
						<tr>
							<td>
								<img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${row.journalId}" />" class="img-thumbnail" width="280" height="210">
							</td>
						</tr>
						<tr>
							<td>
							<h4 class="h4">${row.journalName}</h4>
							${row.beginTime} ~ ${row.endTime}<br>
							<c:forEach var="MemberVO" items="${MemberService.all}">
                             	<c:if test="${MemberVO.memberId==row.memberId}">
									作者：${MemberVO.nickname}<br>
                             	</c:if>
							</c:forEach>							
							${row.visitorNum}
							</td>
						</tr>
						<tr><td>
						<div id="btnMore">
							<input type="button" value="看更多" onclick="" class="btn btn-primary">
						</div>
						</td></tr>
						</table>
						</div>
						</c:if>
					</c:forEach>
				<div id="divChangePage">
			<%@ include file="/_00_Misc/page2.file" %>
			</div>
			
		</c:if>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>

</body>
</html>
