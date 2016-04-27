<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 外接程式碼 -->
<%@ page import="_01_Sight.model.*"%>
<%@ page import="_03_Event.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
	SightService sightService = new SightService();
 	List<SightVO> sightVO = sightService.selectAllbySightId();
 	pageContext.setAttribute("sightVO", sightVO);
	MemberService memberService = new MemberService();
 	List<MemberVO> memberVO = memberService.getAll();
 	pageContext.setAttribute("memberVO", memberVO);
 	EventService eventService=new EventService();
 	List<EventVO> eventVO=eventService.select();
 	pageContext.setAttribute("eventVO", eventVO);
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
<jsp:useBean id="SightService" scope="page" class="_01_Sight.model.SightService" />
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel後台:管理景點</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- jQuery ui css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(function() {
			    $( "#tabs" ).tabs();
		//景點詳情dialog功能
	 	var uri = "${pageContext.request.contextPath}/_02_TripAndJournal/ShowSightDetail.controller?sightId=";
		var dialog;
		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 700,
			width : 600,
			draggable : true,
			resizable : false,
			modal : true,
			open : function() {
				closedialog = 1;
				$(document).bind('click', overlayclickclose);
			},
			focus : function() {
				closedialog = 0;
			},
			close : function() {
				$(document).unbind('click');
			}
		});

		$("tr.sightId>td:nth-child(2)").each(
						function() {
							$(this).click(function() {
												var sightId = $(this).prev().text();
												console.log(sightId);
												var stylei = ' width="98%" height="98%"  frameborder="0" scrolling="auto"';
												$("#dialog-form").html(
																'<iframe src="'+uri+sightId+'"'+stylei+'></iframe>');
												dialog.dialog("open");
												closedialog = 0;
											});
						});
		var closedialog;
		function overlayclickclose() {
			if (closedialog) {
				$('#dialog-form').dialog('close');
			}
			closedialog = 1;//set to one because click on dialog box sets to zero   
		}
	}); 
	function doNewSight() {
		window.location.href = "<c:url value='/_06_BackEnd/backend/NewSight.jsp' />";
	};
	function doNewEvent() {
		window.location.href = "<c:url value='/_06_BackEnd/backend/NewEvent.jsp' />";
	};
</script>
<style type="text/css">
.ui-widget-content{
width: 100%;
}

.backendTable thead th{
	text-align: center
} 
.backendTable tbody{
	text-align: center
} 
</style>
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
		<div id="dialog-form"></div>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">管理景點</a></li>
				<li><a href="#tabs-2">管理會員</a></li>
				<li><a href="#tabs-3">管理活動</a></li>
			</ul>
			<div id="tabs-1">
				<h2>I-Travel後台:管理景點</h2>
				<button type="button" class="btn btn-info btn-lg" onclick="doNewSight()">新增景點</button>
					<%
						rowsPerPage = 14; //每頁的筆數 
						rowNumber = sightVO.size();
					%>
					<%@ include file="/_00_Misc/page1.file"%>
					<table class="backendTable table">
						<thead>
							<tr>
								<th>景點編號</th>
								<th>景點名稱</th>
								<th>地區</th>
								<th>縣市</th>
								<th>景點類型</th>
								<th>電話</th>
								<th>地址</th>
								<th>修改人</th>
								<th>修改時間</th>
								<th>是否顯示</th>
								<th>修改</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="sightVO" items="${sightVO}"
								begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr class="sightId">
									<td>${sightVO.sightId}</td>
									<td>${sightVO.sightName}</td>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.regionId}">
											<td>${codeVO.codeName}</td>
										</c:if>
									</c:forEach>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.countyId}">
											<td>${codeVO.codeName}</td>
										</c:if>
									</c:forEach>
									<c:forEach var="codeVO" items="${codeSvc.all}">
										<c:if test="${codeVO.codeId==sightVO.sightTypeId}">
											<td>${codeVO.codeName}</td>
										</c:if>
									</c:forEach>
									<td>${sightVO.phone}</td>
									<td>${sightVO.addr}</td>
									<td>${sightVO.modifier}</td>
									<td><fmt:formatDate value="${sightVO.modifyTime}" timeStyle="short" type="both" /></td>
									<td>
									<c:if test="${sightVO.del==true}">否</c:if>
									<c:if test="${sightVO.del==false}">是</c:if>
									</td>
									<td>
										<FORM METHOD="post" enctype="multipart/form-data" ACTION="<c:url value="/_06_BackEnd/backEnd/BackendSight.controller" />">
											<input style="color: black" type="submit" value="修改">
											<input type="hidden" name="action" value="getOne"> 
											<input type="hidden" name="sightId" value="${sightVO.sightId}">
										</FORM>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="/_00_Misc/page2.file"%>
			</div>
			<!-- tabs-1 end tag -->
			<div id="tabs-2">
				<h2>I-Travel後台:管理會員</h2>
			<%-- 	<%
					rowsPerPage = 20; //每頁的筆數
					rowNumber = memberVO.size();
				%>
				<%@ include file="/_00_Misc/page1.file"%> --%>
				<table class="backendTable table">
					<thead>
						<tr>
							<th>會員帳號</th>
							<th>姓</th>
							<th>名</th>
							<th>暱稱</th>
							<th>email</th>
							<th>生日</th>
							<th>電話</th>
							<th>修改人</th>
							<th>修改時間</th>
							<th>管理權限</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="memberVO" items="${memberVO}"
							begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<td>${memberVO.memberAccount}</td>
								<td>${memberVO.lastName}</td>
								<td>${memberVO.firstName}</td>
								<td>${memberVO.nickname}</td>
								<td>${memberVO.email}</td>
								<td>${memberVO.birth}</td>
								<td>${memberVO.cellphone}</td>
								<c:if test="${memberVO.modifier==null}">
									<td>此會員尚未修改過資料</td>
								</c:if>
								<c:forEach var="MemberVO" items="${MemberService.all}">
									<c:if test="${MemberVO.memberId==memberVO.modifier}">
										<td>${MemberVO.nickname}</td>
									</c:if>
								</c:forEach>
								<td><fmt:formatDate value="${memberVO.modiftyTime}" timeStyle="short" type="both" /></td>
								<td>
									<FORM ACTION="<c:url value="/_06_BackEnd/backend/modifyAdmin.controller" />">
										<select name="admin" style="color: black">
											<option value="true" ${(memberVO.admin==true)?'selected':''}>管理員</option>
											<option value="false" ${(memberVO.admin==false)?'selected':''}>普通會員</option>
										</select> 
										<input style="color: black" type="submit" value="修改">
										<input type="hidden" name="memberId" value="${memberVO.memberId}">
									</FORM>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
<%-- 				<%@ include file="/_00_Misc/page2.file"%> --%>
			</div><!-- tabs-2 end tag -->
			<div id="tabs-3">
				<h2>I-Travel後台:管理活動</h2>
				<button type="button" class="btn btn-info btn-lg" onclick="doNewEvent()">新增活動</button>
					<%
						rowsPerPage = 20; //每頁的筆數 
						rowNumber = eventVO.size();
					%>
					<%@ include file="/_00_Misc/page1.file"%>
					<table class="backendTable table">
						<thead>
							<tr>
								<th>活動主題</th>
								<th>起始時間</th>
								<th>結束時間</th>
								<th>相關景點</th>
								<th>是否下架</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="eventVO" items="${eventVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr id=eventId>
									<td width="300">${eventVO.eventTopic}</td>
									<td>${eventVO.eventStartDate}</td>
									<td>${eventVO.eventEndDate}</td>
									<c:forEach var="SightVO_All" items="${SightService.all}">
										<c:if test="${SightVO_All.sightId==eventVO.sightId}">
											<td>${SightVO_All.sightName}</td>
										</c:if>
									</c:forEach>
									<td>
									<c:if test="${eventVO.eventRemoved==true}">是</c:if>
									<c:if test="${eventVO.eventRemoved==false}">否</c:if>
									</td>
									<td>																																			
										<FORM METHOD="post" enctype="multipart/form-data" ACTION="<c:url value="/_06_BackEnd/backend/NewEvent.controller" />">
											<input style="color: black" type="submit" value="修改">
											<input type="hidden" name="action" value="getOne"> 
											<input type="hidden" name="eventId" value="${eventVO.eventId}">
										</FORM>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="/_00_Misc/page2.file"%>
			</div><!-- tabs-3 end tag -->
		</div><!-- tabs end tag -->
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
