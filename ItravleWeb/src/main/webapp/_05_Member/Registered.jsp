<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>註冊會員</h3>
<h5 style="color:red">*為必填欄位</h1>

<form action="<c:url value="/_05_Member/registered.controller" />"  method="get">

<table>
<tr>
		<td>*姓氏 : </td>
		<td><input type="text" name="lastName" value="${param.lastName}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.lastName}</span></td>
	    </tr>
	    <td>*名字: </td>
		<td><input type="text" name="firstName" value="${param.firstName}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.firstName}</span></td>
	    </tr>
	    <td>*帳號 : </td>
		<td><input type="text" name="memberAccount" value="${param.memberAccount}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.memberAccount}</span></td>
	    </tr>
	    <td>*密碼 : </td>
		<td><input type="text" name="password" value="${param.password}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.password}</span></td>
	    </tr>
	    <td>*信箱 : </td>
		<td><input type="text" name="email" value="${param.email}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.email}</span></td>
	    </tr>
	    <td>生日 : </td>
		<td><input type="text" name="birth" value="${param.birth}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.birth}</span></td>
	    </tr>
	    <td>電話 : </td>
		<td><input type="text" name="cellphone" value="${param.cellphone}" onblur="doBlur()" onfocus="clearForm()"></td>
		<td><span class="error">${error.cellphone}</span></td>
	    </tr>
	    <td>大頭貼 : </td>
		<td><input type="file" name="photo"></td>
	    </tr>
</table>
</form>
</body>
</html>