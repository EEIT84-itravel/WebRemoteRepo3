<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="_05_Member.model.dao.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- jQuery ui 日期相關-->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- jQuery ui 日期相關-->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/cellphonemodify.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var path = "${pageContext.request.contextPath}";
		//生日日期用jQuery UI
		$('input[name="birth"]').datepicker({
			defaultDate : "-25y",
			yearRange : "1900:2016",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		$('input[name="cellphone2"]').blur(function() {
			$("img:eq(1)").show();
			var url3 = path + "/_05_Member/member/cellphonemodify.controller";
			var cellphone1 = $('input[name="cellphone1"]').val();
			var cellphone2 = $('input[name="cellphone2"]').val();
			sendRequest3("GET", url3, cellphone1, cellphone2);
		});
		$('input[name="cellphone2"]').focus(function() {
			$("#cellphone5").empty("");
		});
	});
	var openFile = function(event) {
	    var input = event.target;

	    var reader = new FileReader();
	    reader.onload = function(){
	      var dataURL = reader.result;
	      var output = document.getElementById('output');
	      output.src = dataURL;
	    };
	    reader.readAsDataURL(input.files[0]);
	  };
</script>
<style type="text/css">
#editAccount {
	width:500px;
	margin: 0 auto;
}
#editAccount{
	font-size: 20px;	
}

#memberTable td {
	width: 200px;
}
#modifymessage {
color: red;
}
</style>

<title>修改會員資料</title>

</head>
<body>

	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article class="center-block">
	<div id="editAccount">
	<h3>${user.firstName}的個人資料</h3>
	<form action="<c:url value="/_05_Member/member/membermodify.controller" />"
		method="post" enctype="multipart/form-data">
		<input type="hidden" name="memberId" value="${user.memberId}">
		<input type="hidden" name="photo" value="${user.photo}">
		<input type="hidden" name="cellphone1" value="${user.cellphone}"> 
		<input type="hidden" name="memberAccount" value="${user.memberAccount}">
		<table id="memberTable">
			<tr>
				<td>*姓氏 :</td>
				<td><input type="text" name="lastName" value="${user.lastName}"></td>
				<td><span class="error">${error.lastName}</span></td>
			</tr>
			<tr>
				<td>*名字:</td>
				<td><input type="text" name="firstName"
					value="${user.firstName}"></td>
				<td><span class="error">${error.firstName}</span></td>
			</tr>
			<tr>
				<td>*帳號 :</td>
				<td>${user.memberAccount}</td>
				<td><span class="error"></span><img></td>
			</tr>
			<tr>
				<td>*密碼 :</td>
				<td><input type="password" name="password" value="${user.password}"></td>
				<td><span class="error">${error.password}</span></td>
			</tr>
			<tr>
				<td>*暱稱 :</td>
				<td><input type="text" name="nickname" value="${user.nickname}"></td>
				<td><span class="error">${error.nickname}</span></td>
			</tr>
			<tr>
				<td>*信箱 :</td>
				<td><input type="text" name="email" value="${user.email}"></td>
				<td><span class="error">${error.email}</span></td>
			</tr>
			<tr>
				<td>*生日 :</td>
				<td><input type="text" id="birth" name="birth"
					value="${user.birth}"></td>
				<td><span class="error">${error.birth}</span></td>
			</tr>
			<tr>
				<td>電話 :</td>
				<td><input type="text" name="cellphone2"
					value="${user.cellphone}"></td>
				<td><span class="error" id="cellphone5">${error.cellphone}</span><img
					src="<c:url value="/img/ajax-loader.gif"/>" style="display: none" /></td>
			</tr>
			<tr>
				<td>現在使用的大頭貼 :</td>
				<td><img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${user.memberId}" />"
					width="80" height="60"></td>
			</tr>
			<tr>
				<td>大頭貼 :</td>
				<td><input type='file' accept='image/*' onchange='openFile(event)' name="photo1"><br>
					<img id='output' width="160" height="240"></td>
			</tr>
			<tr>
				<td><input type="submit" value="修改會員資料"></td>
				<td></td>
			</tr>
		</table>
	</form>
	<div>
		<span id="modifymessage">
		${modify.message}
		</span>
		</div>
	</div>
	</article>
</body>
</html>
