<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Login</title>
</head>
<body>

<h3>Login</h3>

<form action="<c:url value="/_05_Member/login.controller" />" method="get">
<table>
	<tr>
		<td>ID : </td>
		<td><input type="text" name="username" value="${param.username}"></td>
		<td>${error.username}</td>
	</tr>
	<tr>
		<td>PWD : </td>
		<td><input type="text" name="password" value="${param.password}"></td>
		<td>${error.password}</td>
	</tr>
	<tr>
		<td>　</td>
		<td align="right"><input type="submit" value="Login"></td>
	</tr>
</table>
</form>

</body>
</html>