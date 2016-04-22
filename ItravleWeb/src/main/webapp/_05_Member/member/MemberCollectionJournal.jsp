<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<% 
JournalService journalservice = new JournalService();
CollectionService collectionservice = new CollectionService();
//抓使用者ID
MemberVO user = (MemberVO)session.getAttribute("user");
int memberId = user.getMemberId();
//找出收藏的遊記ID
 ArrayList<Integer> journalId = collectionservice.selectjournalByMemberId(memberId);
//找出收藏且已發布的遊記們
List<JournalVO> list = new ArrayList<JournalVO>();
List<JournalVO> journalVO = new ArrayList<JournalVO>();
if(journalId!=null &&journalId.size()>0){
for(int i = 0 ; i<journalId.size();i++){
	list.add(i, journalservice.select(journalId.get(i)));
}
}
if(list!=null&& list.size()>0){
for(int i = 0 ;i<list.size();i++){
	if(list.get(i).getPost()==true){
		journalVO.add(list.get(i));
	}
}
}
pageContext.setAttribute("journalVO", journalVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/Member.css"/>" />
<title>ITravel-我的收藏遊記</title>
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
	<h3>會員功能>我的收藏遊記</h3>
	<table class="table">
		<thead>
			<tr id="forumTitle">
				<th>遊記照片</th>
				<th>遊記名字</th>
				<th>起始日期</th>
				<th>最後修改時間</th>
				<th>人氣</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${not empty journalVO}">
		<c:forEach var="journalVO" items="${journalVO}">
			<tr>
				<td>
					<img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${journalVO.journalId}" />" width="160" height="120" class="img-rounded">
				</td>
				<td>${journalVO.journalName}</td>
				<td>${journalVO.beginTime}</td>
				<td>${journalVO.modifyTime}</td>
				<td>${journalVO.visitorNum}</td>
				<td><a href="<c:url value="/_05_Member/member/deljournal.controller?memberId=${user.memberId}&referenceType=${journalVO.journalId}&typeId=type_id03"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
			</tr>
		</c:forEach>
		</c:if>
		</tbody>
	</table>
	</article>
</body>
</html>