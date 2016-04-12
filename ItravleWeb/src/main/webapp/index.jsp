<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel首頁</title>
</head>
<body>



<h3>Welcome ${user.firstName}</h3>
<h3><a href="<c:url value="/_05_Member/Login.jsp" />">Login</a></h3>
<h3><a href="<c:url value="/_05_Member/Logout.jsp" />">Logout</a></h3>
<h3><a href="<c:url value="/_05_Member/Registered.jsp" />">註冊</a></h3>
<h3><a href="<c:url value="/_05_Member/MemberModify.jsp" />">修改會員資料</a></h3>



</body>
</html>