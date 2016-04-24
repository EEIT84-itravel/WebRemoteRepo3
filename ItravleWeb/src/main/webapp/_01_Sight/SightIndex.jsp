<%@page import="_00_Misc.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	SightService forumService = new SightService();
	List<SightVO> sightVOs = forumService.select();
	pageContext.setAttribute("sightVOs", sightVOs);
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("regions", codeVO);
	List<CodeVO> codeVO2 = codeService.select("county");
	pageContext.setAttribute("countys", codeVO2);
	List<CodeVO> codeVO3 = codeService.select("sight_type");
	pageContext.setAttribute("sight_type", codeVO3);
%>
<%
	int rowNumber=0;      //總筆數
    int pageNumber=0;     //總頁數      
    int whichPage=1;      //第幾頁
    int pageIndexArray[]=null;
    int pageIndex=0; 
    int rowsPerPage;
%>
<jsp:useBean id="codeSvc" scope="page" class="_00_Misc.model.CodeService" />
<jsp:useBean id="CollectionService" scope="page" class="_05_Member.model.CollectionService" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITravel-景點首頁</title>

<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<script type="text/javascript">
$(document).ready(function() {
	//景點select選單
	$("#sel").change(function(){
		  switch ($(this).val()){
				case "region01": 
		      $("#sel2 option").remove();
		      var array = [ "請選擇","臺北市","新北市","基隆市","宜蘭縣","桃園縣","新竹市","新竹縣"];
		      var arrayId=["","county01","county02","county07","county17","county03","county08","county10"];
		      //利用each遍歷array中的值並將每個值新增到Select中
		      $.each(array, function(i, val) {	
		        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
		      });      
		      break;
				case "region02": 
		      $("#sel2 option").remove();
		      var array = [ "臺中市","彰化縣","南投縣","苗栗縣","雲林縣"];
		      var arrayId=["county04","county12","county13","county11","county14"];
		      $.each(array, function(i, val) {
		        $("#sel2").append($("<option value='" + arrayId[i] +"'>" + array[i] + "</option>"));
		      });      
		      break;
				case "region03": 
				      $("#sel2 option").remove();
				      var array = [ "嘉義市","嘉義縣","臺南市","高雄市","屏東縣","澎湖縣"];
				      var arrayId=["county09","county15","county05","county06","county16","county20"];
				      $.each(array, function(i, val) {
				        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
				      });      
				      break;
				case "region04": 
				      $("#sel2 option").remove();
				      var array = [ "花蓮縣","臺東縣","金門縣","連江縣"];
				      var arrayId=["county18","county19","county21","county22"];
				      $.each(array, function(i, val) {
				        $("#sel2").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
				      });      
				      break;
			}
		});
});
</script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_01_Sight/SightIndex.css"/>" /> 
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
	<div id="sightTop">
		<h3>首頁>看景點</h3>
		<!-- Button 進階搜尋 -->
		<button type="button" class="btn btn-primary btn-lg" id="searchBtn" data-toggle="#mySearch" data-target="#myModal">進階搜尋</button>
	</div>
		<br>
		<!-- 進階搜尋 互動視窗 -->
		<div class="modal fade" id="mySearch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">進階搜尋</h4>
					</div>
					<div class="modal-body">
						<form action="<c:url value="/_01_Sight/SightIndex.controller" />">
							<table>
								<tr>
								<td>地區：
									<select name="regionId" id="sel">
											<option value="">請選擇</option>
										<c:forEach var="region" items="${regions}">
											<option value="${region.codeId}" >${region.codeName}</option>
										</c:forEach>
									</select>
												縣市：
									<select name="countyId" id="sel2">
										<option value="">請選擇</option>
									</select>
								</td>
									<td>類型:
										<select name="sightType">
											<option value="">請選擇</option>
											<c:forEach var="region" items="${sight_type}">
												<option value="${region.codeId}">${region.codeName}</option>
											</c:forEach>
										</select>
									</td>
									<td>關鍵字:
									<input type="text" name="keyWord" value="${param.keyWord}">
									</td>
								</tr>
							</table>
							<input type="hidden" name="select" value="byWatchNum">
							<input type="submit" />
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 進階搜尋 互動視窗 End-->
		<br>
		<!-- 		景點欄位 -->
	<div id="sights">
		<c:if test="${empty sightVOSearch}">
			<c:if test="${empty error}"><!-- 判斷是否有錯誤訊息 -->
			<div id="divRowsPerPage">
			<%
						rowsPerPage = 8; //每頁的筆數 
						rowNumber = sightVOs.size();
			%>
			<%@ include file="/_00_Misc/page1.file"%>
			</div>
		<c:forEach var="sightVO" items="${sightVOs}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<div class="SearchSight">
				<table>
				<tr>
					<td>
						<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" class="img-thumbnail" width="280" height="210" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />'">
					</td>
				</tr>
				<tr>
					<td>
					<h4 class="h4"><a href="<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />">${sightVO.sightName}</a></h4>

					類型:
					<c:forEach var="codeVO" items="${codeSvc.all}">
						<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
								${codeVO.codeName}<br>
                             </c:if>
					</c:forEach>				
					縣市:
					<c:forEach var="codeVO" items="${codeSvc.all}">
						<c:if test="${codeVO.codeId==sightVO.countyId}">
								${codeVO.codeName}<br>
                             </c:if>
					</c:forEach>
				
					<!-- 瀏覽人次由servlet+1 -->
					<!-- 收藏人次直接由DB CollectionTable撈資料 -->
					<%int i = 0;%>
					<c:forEach var="CollectionVO" items="${CollectionService.sightCollect}">
						<c:if test="${CollectionVO.referenceType==sightVO.sightId}">
							<%i++;%>
						</c:if>
					</c:forEach>
					${sightVO.watchNum}人瀏覽,<%=i%>人收藏<br>
					最後更新時間:${sightVO.modifyTime}
					</td>
				</tr>
				<tr>
					<td>
					<div class="btnMore">
						<input type="button" value="看更多" class="btn btn-primary" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />'" />
					</div>
					</td>
				</tr>
				</table>
			</div>
			</c:forEach>
			<div id="pageBottom">
			<%@ include file="/_00_Misc/page2.file"%>
			</div>
			</c:if>
		</c:if>
		<c:if test="${not empty sightVOSearch}"><!-- 有搜尋結果由servlet回傳 -->
		<div id="divRowsPerPage">
			<form action="<c:url value="/_01_Sight/SightIndex.controller" />" method="get">
				<input type="hidden" name="regionId" value="${param.regionId}">
				<input type="hidden" name="countyId" value="${param.countyId}">
				<input type="hidden" name="sightType" value="${param.sightType}">
				<input type="hidden" name="keyWord" value="${param.keyWord}">
				<select name="select">
					<option value="byWatchNum" ${param.select=="byWatchNum"?'selected':''}>依瀏覽人次排序</option>
					<option value="byCollectNum" ${param.select=="byCollectNum"?'selected':''}>依收藏人次排序</option>
					<option value="byModifyTime" ${param.select=="byModifyTime"?'selected':''}>依最後更新時間排序</option>
				</select>
				<input type="submit" value="確定">
			</form>
		</div>
		<c:forEach var="sightVO" items="${sightVOSearch}">
			<div class="SearchSight">
				<table>
					<tr>
						<td>
							<img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" class="img-thumbnail" width="280" height="210" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />'">
						</td>
					</tr>
					<tr>
						<td>
						<h4 class="h4"><a href="<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />">${sightVO.sightName}</a></h4>
						類型:
						<c:forEach var="codeVO" items="${codeSvc.all}">
							<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
									${codeVO.codeName}<br>
	                             </c:if>
						</c:forEach>
						
						縣市:
						<c:forEach var="codeVO" items="${codeSvc.all}">
							<c:if test="${codeVO.codeId==sightVO.countyId}">
									${codeVO.codeName}<br>
	                             </c:if>
						</c:forEach>
						
						<!-- 瀏覽人次由servlet+1 -->
						<!-- 收藏人次直接由DB CollectionTable撈資料 -->
						<%int i = 0;%>
						<c:forEach var="CollectionVO" items="${CollectionService.sightCollect}">
							<c:if test="${CollectionVO.referenceType==sightVO.sightId}">
								<%i++;%>
							</c:if>
						</c:forEach>
						${sightVO.watchNum}人瀏覽,<%=i%>人收藏<br>
						最後更新時間:${sightVO.modifyTime}
						</td>
						
					</tr>
					<tr>
						<td>
						<div class="btnMore">
							<input type="button" value="看更多" onclick="location.href='<c:url value="/_01_Sight/Sight.controller?sightId=${sightVO.sightId}" />'" class="btn btn-primary">
						</div>
						</td>
					</tr>
				</table>
			</div>
			</c:forEach>
		</c:if>
		<h3>${error.noneSearch}</h3><!--  查無景點的錯誤訊息 -->
		</div><!-- end of 景點欄位 -->
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
