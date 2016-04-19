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
%>
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<title>ITravel-建立新遊記</title>
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
		<h3>撰寫新遊記</h3>
		<form>
			<table>
				<tr>
					<td>遊記名稱:</td>
					<td colspan="2"><input type="text" name="journalName"
						value="${journalVO.journalName}"></td>
					<td>地區:</td>
					<td><select name="regionId">
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}">${region.codeName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>旅行日期-</td>
					<td>開始日期:</td>
					<td><input name="beginTime" type="date"
						placeholder="${journalVO.beginTime}"></td>
					<td>結束日期:</td>
					<td><input name="endTime" type="date"
						placeholder="${journalVO.endTime}"></td>
				</tr>
				<tr>
					<td>遊記簡介</td>
					<td colspan="4"><textarea name="journalIntro" rows="4"
							cols="50">${journalVO.journalIntro}</textarea></td>
				</tr>
				<tr>
					<td><input type="submit" value="確定送出"></td>
					<td><input type="button" value="clear"></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>