<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel:Login</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
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
			<div style="text-align: center">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>
							<span class="glyphicon glyphicon-lock"></span> I-Travel登入
						</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form role="form"
							action="<c:url value="/_05_Member/login.controller" />"
							method="get">
							<div class="form-group">
								<label for="usrname"><span
									class="glyphicon glyphicon-user"></span> 帳號</label> <input
									type="text" class="form-control" name="username"
									value="${param.username}" placeholder="請輸入帳號"><span
									class="error">${error.username}</span>
							</div>
							<div class="form-group">
								<label for="psw"><span
									class="glyphicon glyphicon-eye-open"></span> 密碼</label> <input
									type="text" class="form-control" name="password"
									value="${param.password}" placeholder="請輸入密碼">
							</div>
							<button type="submit" class="btn btn-success btn-block">
								<span class="glyphicon glyphicon-off"></span> 登入
							</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left"
							data-dismiss="modal">取消</button>
					</div>
				</div>
			
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>
