<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel新增活動</title>
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//起始日期用jQuery UI
		$('input[name="eventStartDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="eventEndDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin
	});
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
	<article>
		<form action="<c:url value="/_06_BackEnd/backend/NewEvent.controller" />">
			<table>
				<tr>
					<td>活動名稱：</td>
					<td><input type="text" name="eventTopic" value="${param.eventTopic}"></td>
					<td><span class="error">${error.eventTopic}</span></td>
				</tr>
				<tr>
					<td>活動圖片：</td>
					<td><input type="file" name="eventPhoto" value="${param.eventPhoto}" size="20"></td>
					<td><span class="error">${error.eventPhoto}</span></td>
				</tr>
				<tr>
					<td>活動內容：</td>
					<td><textarea rows="5" cols="40" name="eventContent" >${param.eventContent}</textarea></td>
					<td><span class="error">${error.eventContent}</span></td>
				</tr>
				<tr>
					<td>活動開始時間：</td>
					<td><input type="text" id="eventStartDate" name="eventStartDate" value="${param.eventStartDate}"></td>
					<td><span class="error">${error.eventStartDate}</span></td>
				</tr>
				<tr>
					<td>活動結束時間：</td>
					<td><input type="text" id="eventEndDate" name="eventEndDate" value="${param.eventEndDate}"></td>
					<td><span class="error">${error.eventEndDate}</span></td>
				</tr>
				<tr>
					<td>對應景點：</td>
					<td><span class="error"></span></td>
				</tr>
				<tr>
					<td><input type="submit" value="新增活動" /></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>