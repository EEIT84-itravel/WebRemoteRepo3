<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> list = service.select("region");
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>景點資訊</title>
</head>
<body>
	<h1>景點資訊</h1>

	<table border="1" width="300" height="300">

	</table>
	<select>
		<c:forEach var="region" items="${list}">
			<option value="${region.codeId}">${region.codeName}</option>
		</c:forEach>
	</select>
	<input type="button" value="相關行程">
	<input type="button" value="相關遊記">
	<input type="button" value="留言">
</body>
</html>