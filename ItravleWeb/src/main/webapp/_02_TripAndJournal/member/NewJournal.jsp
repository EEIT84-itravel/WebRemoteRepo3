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
<title>ITravel-建立新遊記</title>
</head>
<body>
	<h3>建立新的遊記</h3>
	<form
		action="<c:url value="/_02_TripAndJournal/member/NewJournal.controller" />"
		method="post">
		<table>
			<tr>
				<td>遊記名稱:</td>
				<td><input type="text" name="journalName"
					value="${param.journalName}"></td>
				<td><span class="error">${error.journalName}</span></td>
			</tr>
			<tr>
				<td>遊記開始日期:</td>
				<td><input type="date" id="beginTime" name="beginTime"
					value="${param.beginTime}"></td>
				<td><span class="error">${error.beginTime}</span></td>
			</tr>
			<tr>
				<td>遊記結束日期:</td>
				<td><input type="date" id="endTime" name="endTime"
					value="${param.endTime}"></td>
				<td><span class="error">${error.endTime}</span></td>
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
				<td>行程簡介:</td>
				<td><textarea name="journalIntro" rows="4" cols="50">${param.journalIntro}</textarea></td>
				<td><span class="error">${error.journalIntro}</span></td>
			</tr>
			<tr>
				<td><input type="submit" value="開始寫遊記吧"></td>
			</tr>
		</table>
	</form>

</body>
</html>