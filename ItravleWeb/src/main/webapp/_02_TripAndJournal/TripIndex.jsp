<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="_00_Misc.model.*"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<% 
	TripService tripService = new TripService();
	List<TripVO> tripVOs = tripService.getAllPost();
	pageContext.setAttribute("tripVOs", tripVOs);
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
<jsp:useBean id="TripDetailService" scope="page" class="_02_TripAndJournal.model.TripDetailService" />
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<jsp:useBean id="CollectionService" scope="page" class="_05_Member.model.CollectionService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_02_TripAndJournal/TripIndex.css"/>"/>
<title>ITravel-行程首頁</title>
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
	<h3>首頁>看行程</h3>	


    <div id="writeTripBtn">
<!-- 		<button type="button" id="myBtn2" class="btn btn-info btn-lg" >排行程</button> -->
		<c:choose>
			<c:when test="${empty user}"><button type="button" class="btn btn-info btn-lg" onclick="doAlert()">排行程</button></c:when>
			<c:when test="${not empty user}"><button type="button"  class="btn btn-info btn-lg" onclick="location.href='<c:url value="/_02_TripAndJournal/member/NewTrip.jsp"/>'">排行程</button></c:when>
		</c:choose>
	</div>
		
			<div id="divRowsPerPage">
			<form action="<c:url value="/_02_TripAndJournal/ShowAllTripServlet.controller" />" method="get">
				<select name="select">
					<option value="byWatchNum" ${param.select=="byWatchNum"?'selected':''}>依瀏覽人次排序</option>
					<option value="byCollectNum" ${param.select=="byCollectNum"?'selected':''}>依收藏人次排序</option>
					<option value="byModifyTime" ${param.select=="byModifyTime"?'selected':''}>依最後更新時間排序</option>
				</select>
				<input type="submit" value="確定">
			</form>
			<%  rowsPerPage = 8;  //每頁的筆數 
				rowNumber=tripVOs.size(); 
			%>
			<%@ include file="/_00_Misc/page1.file" %>
			</div>
			<c:if test="${empty selectTripVOs}"><!-- 第一次進入首頁時由上方載入 -->
				<c:forEach var="row" items="${tripVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<c:if test="${row.post==true}"><!-- 狀態是"已發布" -->
						<div id="tripDiv">
						<table>
						<tr>
							<td>
								<c:url value="/_02_TripAndJournal/ShowTrip.controller" var="path" scope="page">
									<c:param name="tripId" value="${row.tripId}" />									
								</c:url>
								<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}">
                             		<c:if test="${TripDetailVO.tripId==row.tripId}">
										<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" class="img-thumbnail" width="280" height="210" onclick="location.href='${path}'">
                             		</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>
								<h4 class="h4">${row.tripName}</h4>
								${row.tripStartDate} ~ ${row.tripEndDate}<br>	
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
										<c:if test="${CollectionVO.referenceType==row.tripId}">
											<%i++;%>
										</c:if>
									</c:forEach>
								有${row.watchNum}人瀏覽,<%=i%>人收藏<br>
								最後更新時間:${row.modifyTime}<br>
							</td>
						</tr>
						<tr><td>
						<div id="btnMore">
							<input type="button" value="看更多" onclick="location.href='${path}'" class="btn btn-primary">
						</div>
						</td></tr>												
						</table>
						</div>
						</c:if>
					</c:forEach>
				</c:if><!-- end of index直接篩選 -->
				<c:if test="${not empty selectTripVOs}">
					<c:forEach var="row" items="${selectTripVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					<c:if test="${row.post==true}">
						<div id="tripDiv">
						<table>
						<tr>
							<td>
								<c:url value="/_02_TripAndJournal/ShowTrip.controller" var="path" scope="page">
									<c:param name="tripId" value="${row.tripId}" />									
								</c:url>
								<c:forEach var="TripDetailVO" items="${TripDetailService.mainPics}">
                             		<c:if test="${TripDetailVO.tripId==row.tripId}">
										<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${TripDetailVO.referenceNo}" />" class="img-thumbnail" width="280" height="210" onclick="location.href='${path}'">
                             		</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>
								<h4 class="h4">${row.tripName}</h4>
								${row.tripStartDate} ~ ${row.tripEndDate}<br>	
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
										<c:if test="${CollectionVO.referenceType==row.tripId}">
											<%i++;%>
										</c:if>
									</c:forEach>
								有${row.watchNum}人瀏覽,<%=i%>人收藏<br>
								最後更新時間:${row.modifyTime}<br>
							</td>
						</tr>
						<tr><td>
						<div id="btnMore">
							<input type="button" value="看更多" onclick="location.href='${path}'" class="btn btn-primary">
						</div>
						</td></tr>												
						</table>
						</div>
						</c:if>
					</c:forEach>
				</c:if><!-- end of select後行程 -->
			<h3>${error.noneSearch}</h3><!--  查無行程的錯誤訊息 -->
			<div id="divChangePage">
			<%@ include file="/_00_Misc/page2.file" %>
			</div>	
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
