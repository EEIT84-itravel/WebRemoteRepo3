<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:註冊會員</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_00_Misc/main.css"/>" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_05_Member/Register.css"/>" />
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
			$("#memberAccount").empty("");
		});
		$('input[name="cellphone"]').focus(function() {
			$("#cellphone5").empty("");
		});
	});
	var openFile = function(event) {
		var input = event.target;

		var reader = new FileReader();
		reader.onload = function() {
			var dataURL = reader.result;
			var output = document.getElementById('output');
			output.src = dataURL;
		};
		reader.readAsDataURL(input.files[0]);
	};


</script>
<style>
</style>
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
	<article class="center-block">
		<div id="regForm" style="margin:0 auto;border:1px dotted #d0d0d0;">
			<form action="<c:url value="/_05_Member/registered.controller" />"
				method="post" enctype="multipart/form-data">
				<fieldset id="reg">
					<legend id="regTitle">註冊會員</legend>
					<h5 style="color: red">*為必填欄位</h5>
					<div class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-sm-3">*姓氏 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="lastName" value="${param.lastName}"/><span class="error">${error.lastName}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*名字:</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="firstName" value="${param.firstName}"/><span class="error">${error.firstName}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*帳號 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="memberAccount" value="${param.memberAccount}"/><span class="error" id="memberAccount">${error.memberAccount}</span>				    
							<img>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*密碼 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="password" value="${param.password}"/><span class="error">${error.password}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*暱稱 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="nickname" value="${param.nickname}"/><span class="error">${error.nickname}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*信箱 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="email" id="email" value="${param.email}"/><span class="error">${error.email}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*生日 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" id="birth" name="birth" value="${param.birth}"/><span class="error">${error.birth}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*電話  :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="cellphone" value="${param.cellphone}"/><span class="error" id="cellphone5">${error.cellphone}</span>				    
							<img>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">大頭貼：</label>
							<div class="col-sm-9">
								<input class="form-control" type="file" accept='image/*'
									onchange='openFile(event)' name="photo" />
									<img id='output' width="180px" height="180px">			    
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<div style="text-align: center;">
						<input type="submit" value="註冊" class="btn-info btn-lg" >
					</div>
					<div style="height: 20px;"></div>
				</fieldset>
			</form>
		</div>
		
	</article>
<footer>
		<div>
			<jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
