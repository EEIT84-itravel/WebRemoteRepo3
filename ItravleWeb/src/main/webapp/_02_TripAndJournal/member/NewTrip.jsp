<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="_00_Misc.model.CodeVO"%>
<%@ page import="_00_Misc.model.CodeService"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> region = service.select("region");
	pageContext.setAttribute("region", region);

	List<CodeVO> transForm = service.select("trans_form");
	pageContext.setAttribute("transForm", transForm);
%>
<title>ITravel-建立新行程</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//起始日期用jQuery UI
		$('input[name="tripStartDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="tripEndDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin

	});
</script>
<style type="text/css">
article{
  margin: 20px;
}
</style>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
		<h3>建立新的行程</h3>
		<form action="<c:url value="/_02_TripAndJournal/member/NewTrip.controller" />" method="post">
			<table>
				<tr>
					<td>行程名稱:</td>
					<td><input type="text" name="tripName"
						value="${param.tripName}"></td>
					<td><span class="error">${error.tripName}</span></td>
				</tr>
				<tr>
					<td>旅行開始日期:</td>
					<td><input type="text" id="tripStartDate" name="tripStartDate"
						value="${param.tripStartDate}"></td>
					<td><span class="error">${error.tripStartDate}</span></td>
				</tr>
				<tr>
					<td>旅行結束日期:</td>
					<td><input type="text" id="tripEndDate" name="tripEndDate"
						value="${param.tripEndDate}"></td>
					<td><span class="error">${error.tripEndDate}</span></td>
				</tr>
				<tr>
					<td>開始遊玩時間:</td>
					<td><input type="time" name="startTime"></td>
					<td><span class="error">${error.startTime}</span></td>
				</tr>
				<tr>
					<td>地區:</td>
					<td><select name="regionId">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}">${region.codeName}</option>
							</c:forEach>
					</select></td>
					<td><span class="error">${error.regionId}</span></td>
				</tr>
				<tr>
					<td>交通工具:</td>
					<td><select name="transFormId">
							<c:forEach var="transForm" items="${transForm}">
								<option value="${transForm.codeId}">${transForm.codeName}</option>
							</c:forEach>
					</select></td>
					<td><span class="error">${error.transFormId}</span></td>
				</tr>
				<tr>
					<td>行程簡介:</td>
					<td><textarea name="tripIntro" rows="4" cols="50">${param.tripIntro}</textarea></td>
					<td><span class="error">${error.tripIntro}</span></td>

				</tr>
				<tr>
					<td><input type="submit" value="開始排行程吧"></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
