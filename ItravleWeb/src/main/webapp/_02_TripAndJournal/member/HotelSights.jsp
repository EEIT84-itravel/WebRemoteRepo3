<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_01_Sight.model.dao.*"%>
<%@ page import="java.util.*"%>
<!-- 以下的要再改成jQuery 的ajax   不要在jsp出現java code -->

<%
	SightService sightService = new SightService();
	List<SightVO> sightVO = sightService.selectByType("sight_type04");
	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HotelSights</title>
<script>
	$(".sight").draggable({
			helper : "clone",	//複製一份 			
			start: function( event, ui ) {
				$("tr.sightId>td:first-child:last").each(function(){	//取得正在拖曳的物件的sightId
					sightId =$(this).text();
				});
				$("tr.sightId>td:nth-child(3):last").each(function(){	//取得正在拖曳的物件的sightName
					sightName =$(this).text(); 					
				});
				$("tr.sightId>td:nth-child(6):last").each(function(){	//取得正在拖曳的物件的spendHour
					spendHour =$(this).text(); 					
				});
			}
	});	
</script>
</head>
<body>
	HotelSights.jsp
	<%@ include file="/_00_Misc/page1.file" %>
				<c:forEach var="sightVO" items="${sightVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
				<table class="sight">
				<tr class="sightId">	
					<td>${sightVO.sightId}</td>
					<td><img src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />"
							 width="80" height="60">
					</td>					
					<td>${sightVO.sightName}</td>
					<td>建議旅行時段:
						<c:forEach var="codeVO" items="${codeSvc.all}">
                             <c:if test="${codeVO.codeId==sightVO.playPeriod}">
								${codeVO.codeName}
                             </c:if>
						</c:forEach>
					</td>
					<td>${sightVO.score}分</td>
 					<td hidden="true">${sightVO.spendHour}</td>	<%-- 給jQuery抓每個景點預設的建議停留時間 --%>
					<td>評論</td>
					<td>最愛</td>
					<!-- 景點彈出視窗功能 -->
					<td><button class="label label-primary" onclick="window.open('<c:url value="/_02_TripAndJournal/ShowSightDetail.controller?sightId=${sightVO.sightId}" />','sightDetail','height=500,width=500,toolbar=no,titlebar=no,status=no,left=450,top=350');">詳情</button></td>					
				</tr>
				</table>
				</c:forEach>
				<%@ include file="/_00_Misc/page2.file" %>
<%-- 	<c:forEach var="sightVO" items="${sightVO}"> --%>
<!-- 		<table class="sight"> -->
<!-- 			<tr> -->
<!-- 				<td><img -->
<%-- 					src="<c:url value="/_01_Sight/ShowSightMainPic.controller?sightId=${sightVO.sightId}" />" --%>
<!-- 					width="80" height="60"></td> -->
<%-- 				<td>${sightVO.sightName}</td> --%>
<%-- 				<td>${sightVO.score}分</td> --%>
<!-- 				<td>評論</td> -->
<!-- 				<td>最愛</td> -->
<!-- 				景點彈出視窗功能 -->
<%-- 				<td><button class="label label-primary" onclick="window.open('<c:url value="/_02_TripAndJournal/ShowSightDetail.controller?sightId=${sightVO.sightId}" />','sightDetail','height=500,width=500,toolbar=no,titlebar=no,status=no,left=450,top=350');">詳情</button></td> --%>
<!-- 			</tr> -->
<!-- 		</table> -->
<%-- 	</c:forEach> --%>
</body>
</html>