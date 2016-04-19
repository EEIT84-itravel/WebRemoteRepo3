<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:註冊會員</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- jQuery ui 日期相關-->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui 日期相關-->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/account.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/cellphone.js"/>"></script>
<script type="text/javascript">
	var path = "${pageContext.request.contextPath}";
	$(document).ready(function() {
		//生日日期用jQuery UI
		$('input[name="birth"]').datepicker({
			defaultDate : "-25y",
			yearRange : "1900:2016",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");

		$('input[name="memberAccount"]').blur(function() {
			$("img:eq(0)").show();
			var url = path + "/_05_Member/memberAccount.controller";
			var id = $('input[name="memberAccount"]').val();
			sendRequest("GET", url, id);
		});

		$('input[name="cellphone"]').blur(function() {
			$("img:eq(1)").show();
			var url2 = path + "/_05_Member/cellphone.controller";
			var id2 = $('input[name="cellphone"]').val();
			sendRequest2("GET", url2, id2);
		});
		$('input[name="memberAccount"]').focus(function() {	
		 	$("span:eq(2)").empty("");
		});
		$('input[name="cellphone"]').focus(function() {
		 	$("span:eq(6)").empty("");
		});
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
		<h3>註冊會員</h3>
		<h5 style="color: red">*為必填欄位</h5>
		<form action="<c:url value="/_05_Member/registered.controller" />" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td>*姓氏 :</td>
					<td><input type="text" name="lastName" value="${param.lastName}"></td>
					<td><span class="error">${error.lastName}</span></td>
				</tr>
				<tr>
					<td>*名字:</td>
					<td><input type="text" name="firstName" value="${param.firstName}"></td>
					<td><span class="error">${error.firstName}</span></td>
				</tr>
				<tr>
					<td>*帳號 :</td>
					<td><input type="text" name="memberAccount" value="${param.memberAccount}"></td>
					<td><span class="error">${error.memberAccount}</span><img src="../img/ajax-loader.gif" style="display: none" /></td>
				</tr>
				<tr>
					<td>*密碼 :</td>
					<td><input type="text" name="password" value="${param.password}"></td>
					<td><span class="error">${error.password}</span></td>
				</tr>
				<tr>
					<td>*暱稱 :</td>
					<td><input type="text" name="nickname" value="${param.nickname}"></td>
					<td><span class="error">${error.nickname}</span></td>
				</tr>
				<tr>
					<td>*信箱 :</td>
					<td><input type="text" name="email" value="${param.email}"></td>
					<td><span class="error">${error.email}</span></td>
				</tr>
				<tr>
					<td>*生日 :</td>
					<td><input type="text" id="birth" name="birth" value="${param.birth}"></td>
					<td><span class="error">${error.birth}</span></td>
				</tr>
				<tr>
					<td>電話 :</td>
					<td><input type="text" name="cellphone" value="${param.cellphone}"></td>
					<td><span class="error">${error.cellphone}</span><img src="../img/ajax-loader.gif" style="display: none" /></td>
				</tr>
				<tr>
					<td>大頭貼 :</td>
					<td><input type="file" name="photo"></td>
				</tr>
				<tr>
					<td><input type="submit" value="註冊"></td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
