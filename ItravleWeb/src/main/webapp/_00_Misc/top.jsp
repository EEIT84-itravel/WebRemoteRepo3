<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_02_TripAndJournal.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="_05_Member.model.*"%>

<!DOCTYPE html>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Top-nav</title>
<!-- 最新編譯和最佳化的 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<!-- 選擇性佈景主題 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">

<link href="<c:url value="/css/_00_Misc/alertify.core.css"/>" rel="stylesheet">
<link href="<c:url value="/css/_00_Misc/alertify.default.css"/>" rel="stylesheet">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/alertify.js/0.3.10/alertify.min.js"></script>
<!-- jQuery -->
<script type="text/javascript"
	src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- 最新編譯和最佳化的 JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>

<script type="text/javascript" src="<c:url value="/js/account.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/cellphone.js"/>"></script>
	<script type="text/javascript"	src="<c:url value="/js/jquery.skippr.min.js"/>"></script>
<script type="text/javascript"	src="<c:url value="/js/jquery-boxSlider.js"/>"></script>
<style type="text/css">
nav {
	font-family: "Microsoft JhengHei", "Helvetica Neue", Helvetica, Arial,
		sans-serif;
	font-size: 18px;
	line-height: 20px;
}

.navbar-brand {
	color: white;
	font-weight: 500;
	font-size: 24px;
	line-height: 30px;
}

#bs-example-navbar-collapse-1 .whiteNav a {
	color: white;
	font-weight: 500;
	font-size: 24px;
	height: 60px;
	line-height: 30px;
}

.dropdown-menu {
	background-color: black;
}

</style>

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
			$("#cellphone").empty("");
		});
	});
	function doAlertMessage() {
		alertify.alert('欲使用會員功能請先登入！')
	}
	function doArticleMessage() {
		alertify.alert('發表文章請先登入！')
	}
</script>
</head>
<body>
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<c:url value="/index.jsp"/>">ITravel</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!--  正在被選取的物件-->
				<!-- 	<li class="active"><a href="#">看景點<span class="sr-only">(current)</span></a></li> -->
				<li class="whiteNav">
					<a href="<c:url value="/_01_Sight/SightIndex.jsp"/>">看景點</a>
				</li>
				<li class="whiteNav">
					<a href="<c:url value="/_02_TripAndJournal/TripIndex.jsp"/>">看行程</a>
				</li>
				<li class="whiteNav">
					<a href="<c:url value="/_02_TripAndJournal/JournalIndex.jsp"/>">看遊記</a>
				</li>
				<li class="whiteNav">
					<a href="<c:url value="/_04_Forum/ForumIndex.jsp" />">討論區</a>
				</li>
				<li class="whiteNav">
					<c:choose>
						<c:when test="${empty user}"><a onclick="doAlertMessage()" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">會員功能<span class="caret"></span></a></c:when>
						<c:when test="${not empty user}"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">會員功能<span class="caret"></span></a></c:when>
					</c:choose>
					<ul class="dropdown-menu navbar-nav" role="menu">
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberTrip.jsp" />">我的行程</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberJournal.jsp" />">我的遊記</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberForum.jsp" />">我的討論區</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberSight.jsp" />">我的收藏景點</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberCollectionTrip.jsp" />">我的收藏行程</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberCollectionJournal.jsp" />">我的收藏遊記</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberCollectionForum.jsp" />">我的收藏討論區</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberCollectionMember.jsp" />">我的追蹤作者</a>
						</li>
						<li class="whiteNav">
							<a href="<c:url value="/_05_Member/member/MemberModify.jsp " />">修改會員資料</a>
						</li>
					</ul>
				</li>
				<c:if test="${not empty admin}">
					<li class="whiteNav">
						<a href="<c:url value="/_06_BackEnd/backend/AllSight.jsp" />">後台</a>
					</li>
				</c:if>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<!-- 視session是否登入登出顯示 login/註冊 或 logout -->
					<c:if test="${not empty user}">
						<li class="whiteNav" style="color: white; font-size: 24px;" > ${user.nickname}<img class="img-circle"
							src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${user.memberId}" />"
							width="50px" height="50px"></li >
					</c:if>
				
				<c:if test="${empty user}">
					<li class="whiteNav"><a href="<c:url value="/_05_Member/Registered.jsp"/>">註冊</a></li>
				</c:if>
				<c:if test="${empty user}">
					<li class="whiteNav"><a id="myBtn" style="cursor: pointer">Login</a></li>
					<!-- 					<li><button type="button"  class="btn btn-info btn-lg" id="myBtn3">Login</button></li> -->
				</c:if>
				<c:if test="${not empty user}">
					<li class="pull-right whiteNav"><a href="<c:url value="/_05_Member/Logout.jsp" />">Logout</a></li>
				</c:if>
			</ul>
		</div>
		<!-- /.navbar-collapse -->

		<!-- LoginDIV -->
     	<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>
							<span class="glyphicon glyphicon-lock"></span> I-Travel登入
						</h4>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form role="form" action="<c:url value="/_05_Member/login.controller" />" method="get">
							<div class="form-group">
								<label for="usrname">
								<span class="glyphicon glyphicon-user"></span> 帳號</label> 
								<input type="text" class="form-control" name="username" value="${param.username}" placeholder="請輸入帳號">
								<span class="error">${error.username}</span>
							</div>
							<div class="form-group">
								<label for="psw">
								<span class="glyphicon glyphicon-eye-open">
								</span> 密碼</label>
								<input type="password" class="form-control" name="password" value="${param.password}" placeholder="請輸入密碼">
							</div>
							<button type="submit" class="btn btn-success btn-block">
								<span class="glyphicon glyphicon-off"></span> 登入
							</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div><!-- 登入DIV結束 -->
		<script>
			//呼叫登入modal
			$(document).ready(function() {
				$("#myBtn").click(function() {
					$("#myModal").modal();
				});
			});
			//呼叫註冊modal
		</script>
	</div>
	<!-- /.container-fluid -->
</body>
</html>
