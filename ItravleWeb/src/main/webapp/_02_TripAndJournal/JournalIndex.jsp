<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_05_Member.model.*"%>
<% 
	JournalService journalService = new JournalService();
	List<JournalVO> journalVOs = journalService.getAllPost();
	pageContext.setAttribute("journalVOs", journalVOs);
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("regions", codeVO);
    int rowNumber=0;      //總筆數
    int pageNumber=0;     //總頁數      
    int whichPage=1;      //第幾頁
    int pageIndexArray[]=null;
    int pageIndex=0; 
    int rowsPerPage;
%>
 <% 
	TripService tripService = new TripService();
	//memberId由session取出
	if(session.getAttribute("user")!=null){
	MemberVO memberVO = (MemberVO) session.getAttribute("user");
	int memberId = memberVO.getMemberId();
	List<TripVO> tripVO = tripService.selectFromMember(memberId);
	pageContext.setAttribute("tripVO", tripVO);
	}
%>
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<jsp:useBean id="CollectionService" scope="page" class="_05_Member.model.CollectionService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-遊記首頁</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/JournalIndex.css"/>"/>
<script type="text/javascript">
function doAlert() {
	alertify.alert('此功能僅限會員使用，請先登入!!')
}
</script>
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
		<div id="writeBtn">
<!-- 		寫遊記前先判斷是否有登入 -->
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${empty user}"><button type="button" class="btn btn-info btn-lg" onclick="doAlert()">寫遊記</button></c:when> --%>
<%-- 			<c:when test="${not empty user}"><button type="button"  class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">寫遊記</button></c:when> --%>
<%-- 		</c:choose> --%>
		<c:choose>
			<c:when test="${empty user}"><button type="button" class="btn btn-info btn-lg" onclick="doAlert()">寫遊記</button></c:when>
			<c:when test="${not empty user}"><button type="submit"  class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModalJournal">寫遊記</button></c:when>
		</c:choose>

		</div>
		
		<c:if test="${not empty journalVOs}">
			<div id="divRowsPerPage">
			<form action="<c:url value="/_02_TripAndJournal/ShowAllJournalServlet.controller" />" method="get">
				<select name="select">
					<option value="byWatchNum" ${param.select=="byWatchNum"?'selected':''}>依瀏覽人次排序</option>
					<option value="byCollectNum" ${param.select=="byCollectNum"?'selected':''}>依收藏人次排序</option>
					<option value="byModifyTime" ${param.select=="byModifyTime"?'selected':''}>依最後更新時間排序</option>
				</select>
				<input type="submit" value="確定">
			</form>
			<%  rowsPerPage = 8;  //每頁的筆數 
				rowNumber=journalVOs.size(); 
			%>
			<%@ include file="/_00_Misc/page1.file" %>
			</div>
			<c:if test="${empty selectJournalVOs}"><!-- 第一次進入首頁時由上方載入 -->
				<c:forEach var="row" items="${journalVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<c:if test="${row.post==true}"><!-- 狀態是"已發布" -->
					<div id="journalDiv">
						<table>
						<tr>
							<td>
								<img  src="<c:url value="/_02_TripAndJournal/ShowJournalMainPic.controller?journalId=${row.journalId}" />" onclick="location.href='<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${row.journalId}"/>'" class="img-thumbnail" width="280" height="210">
							</td>
						</tr>
						<tr>
							<td>
							<h4 class="h4">${row.journalName}</h4>
							${row.beginTime} ~ ${row.endTime}<br>
								<c:forEach var="region" items="${regions}">
									<c:if test="${region.codeId==row.regionId}">
										地區:${region.codeName}&nbsp;&nbsp;&nbsp;&nbsp;	
									</c:if>
								</c:forEach>	
							<c:forEach var="MemberVO" items="${MemberService.all}">
                             	<c:if test="${MemberVO.memberId==row.memberId}">
									作者：${MemberVO.nickname}<br>
                             	</c:if>
							</c:forEach>
							<!-- 瀏覽人次由servlet+1 -->
							<!-- 收藏人次直接由DB CollectionTable撈資料 -->
										<%int i = 0;%>
							<c:forEach var="CollectionVO" items="${CollectionService.tripCollect}">
								<c:if test="${CollectionVO.referenceType==row.journalId}">
											<%i++;%>
								</c:if>
							</c:forEach>
								有${row.visitorNum}人瀏覽,<%=i%>人收藏<br>
								最後更新時間:${row.modifyTime}<br>							
							</td>
						</tr>
						<tr><td>
						<div id="btnMore">
							<input type="button" value="看更多" onclick="location.href='<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${row.journalId}"/>'" class="btn btn-primary">
						</div>
						</td></tr>
						</table>
						</div>
						</c:if>
					</c:forEach>
					</c:if>
				<c:if test="${not empty selectJournalVOs}"><!-- select後由servlet載入 -->
				<c:forEach var="row" items="${selectJournalVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<c:if test="${row.post==true}"><!-- 狀態是"已發布" -->
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
								<c:forEach var="region" items="${regions}">
									<c:if test="${region.codeId==row.regionId}">
										地區:${region.codeName}&nbsp;&nbsp;&nbsp;&nbsp;	
									</c:if>
								</c:forEach>	
							<c:forEach var="MemberVO" items="${MemberService.all}">
                             	<c:if test="${MemberVO.memberId==row.memberId}">
									作者：${MemberVO.nickname}<br>
                             	</c:if>
							</c:forEach>
							<!-- 瀏覽人次由servlet+1 -->
							<!-- 收藏人次直接由DB CollectionTable撈資料 -->
										<%int i = 0;%>
							<c:forEach var="CollectionVO" items="${CollectionService.tripCollect}">
								<c:if test="${CollectionVO.referenceType==row.journalId}">
											<%i++;%>
								</c:if>
							</c:forEach>
								有${row.visitorNum}人瀏覽,<%=i%>人收藏<br>
								最後更新時間:${row.modifyTime}<br>							
							</td>
						</tr>
						<tr><td>
						<div id="btnMore">	
							<input type="button" value="看更多" onclick="location.href='<c:url value="/_02_TripAndJournal/ShowJournalDetail.controller?journalId=${row.journalId}"/>'" class="btn btn-primary">
						</div>
						</td></tr>
						</table>
						</div>
						</c:if>
					</c:forEach>
					</c:if>
					<h3>${error.noneSearch}</h3><!--  查無景點的錯誤訊息 -->
				<div id="divChangePage">
			<%@ include file="/_00_Misc/page2.file" %>
			</div>
		<div class="modal fade" id="myModalJournal" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<form id="fromTripToJournal"
						action="<c:url value="/_02_TripAndJournal/member/FromTripToJournal.controller"/>"
						method="post">
						<div class="modal-header" >
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h3 class="modal-title">從行程匯入遊記</h3>
						</div>
						<div class="modal-body">			
								<select name="tripId" >					  
									<c:forEach var="tripVO" items="${tripVO}" >							  
										<option value="${tripVO.tripId}" >${tripVO.tripName}</option>						   
									</c:forEach>					
								</select>	
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn-primary btn-lg btn">開始寫遊記吧!</button>
						</div>
					</form>
				</div>
			</div>
		</div>		
		</c:if>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>

</body>
</html>
