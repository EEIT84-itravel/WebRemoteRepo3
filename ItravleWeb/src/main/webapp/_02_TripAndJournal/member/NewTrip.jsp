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
	List<CodeVO> list = service.select("region");
	pageContext.setAttribute("list", list);
%>
<title>ITravel-建立新行程</title>
</head>
<body>
<h3>建立新的行程</h3>
	<form
		action="<c:url value="/_02_TripAndJournal/member/NewTrip.controller" />"
		method="post">
		<table>
			<tr>
				<td>行程名稱:</td>
				<td><input type="text" name="tripName"
					value="${param.tripName}"></td>
				<td><span class="error">${error.tripName}</span></td>
			</tr>
			<tr>
				<td>旅行開始日期:</td>
				<td><input type="date" id="tripStartDate" name="tripStartDate"
					value="${param.tripStartDate}"></td>
				<td><span class="error">${error.tripStartDate}</span></td>
			</tr>
			<tr>
				<td>旅行結束日期:</td>
				<td><input type="date" id="tripEndDate" name="tripEndDate"
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
						<c:forEach var="region1" items="${list}">
							<option value="${region1.codeId}">${region1.codeName}</option>
						</c:forEach>
				</select></td>
				<td><span class="error">${error.regionId}</span></td>
			</tr>
			<tr>
				<td>交通工具:</td>
				<td><select size="1" name="transFormId">
						<option value="trans_form01">大眾運輸</option>
						<option value="trans_form02">開車</option>
						<option value="trans_form03">步行</option>
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



</body>
</html>