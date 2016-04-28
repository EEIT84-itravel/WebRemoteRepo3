<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel會員專區</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_05_Member/MemberIndex.css"/>" />
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
		<div style="width:600px;margin:0 auto;">
			<h1>會員專區</h1>
			<table id="memberIndex" class="table" style="text-align: center;font-size: 25px;color:darkorange;">
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberTrip.jsp" />'"><td><span class="glyphicon glyphicon-search"></span>我的行程</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberJournal.jsp" />'"><td><span class="glyphicon glyphicon-search"></span>我的遊記</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberForum.jsp" />'"><td><span class="glyphicon glyphicon-search"></span>我的討論區</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberSight.jsp" />'"><td><span class="glyphicon glyphicon-heart"></span>我的收藏景點</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberCollectionTrip.jsp" />'"><td><span class="glyphicon glyphicon-heart"></span>我的收藏行程</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberCollectionJournal.jsp" />'"><td><span class="glyphicon glyphicon-heart"></span>我的收藏遊記</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberCollectionForum.jsp" />'"><td><span class="glyphicon glyphicon-heart"></span>我的收藏討論區</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberCollectionMember.jsp" />'"><td><span class="glyphicon glyphicon-heart"></span>我的追蹤作者</td></tr>
			<tr onclick="location.href='<c:url value="/_05_Member/member/MemberModify.jsp " />'"><td><span class="glyphicon glyphicon-cog"></span>修改會員資料</td></tr>		
			</table>
		</div>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>

</body>
</html>