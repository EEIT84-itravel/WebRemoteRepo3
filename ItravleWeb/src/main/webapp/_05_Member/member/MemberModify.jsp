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
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_05_Member/Register.css"/>" />
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
	
	<div id="regForm" style="margin:0 auto;border:1px dotted #d0d0d0;">
	
			<form action="<c:url value="/_05_Member/member/membermodify.controller" />"method="post" enctype="multipart/form-data">
				<input type="hidden" name="memberId" value="${user.memberId}">
				<input type="hidden" name="photo" value="${user.photo}">
				<input type="hidden" name="cellphone1" value="${user.cellphone}"> 
				<input type="hidden" name="memberAccount" value="${user.memberAccount}">
				<fieldset id="reg">
					<legend id="regTitle">${user.firstName}的個人資料<span id="modifymessage">
		${modify.message}
		</span></legend>
					
					<div class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-sm-3">*姓氏 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="lastName" value="${user.lastName}"/><span class="errorMsg">${error.lastName}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*名字:</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="firstName" value="${user.firstName}"/><span class="errorMsg">${error.firstName}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*帳號 :</label>
							<div class="col-sm-9">
								${user.memberAccount}		    
							<img>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*密碼 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="password" value="${user.password}"/><span class="errorMsg">${error.password}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*暱稱 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="nickname" value="${user.nickname}"/><span class="errorMsg">${error.nickname}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*信箱 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="email" id="email" value="${user.email}"/><span class="errorMsg">${error.email}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*生日 :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" id="birth" name="birth" value="${user.birth}"/><span class="errorMsg">${error.birth}</span>				    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">*電話  :</label>
							<div class="col-sm-9">
								<input class="form-control" type="text" name="cellphone2" value="${user.cellphone}"/><span class="errorMsg" id="cellphone5">${error.cellphone}</span>				    
							<img>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">現在使用的大頭貼 ：</label>
							<div class="col-sm-9">
								<img src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${user.memberId}" />"
								width="80" height="60">			    
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3">大頭貼：</label>
							<div class="col-sm-9">
								<input class="form-control" type="file" accept='image/*'
									onchange='openFile(event)' name="photo2" />
									<img id='output' width="180px" height="180px">			    
							</div>
						</div>
					</div>
					<div style="height: 20px;"></div>
					<div style="text-align: center;">
						<input type="submit" value="修改會員資料" class="btn-info btn-lg" >
					</div>
					<div style="height: 20px;"></div>
				</fieldset>
			</form>
		</div>
	<div id="editAccount"></div>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
