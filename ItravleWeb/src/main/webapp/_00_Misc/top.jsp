<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- 最新編譯和最佳化的 JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<!-- jQuery ui -->
<script type="text/javascript"
	src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<style type="text/css">
nav{
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 18px;
  line-height: 20px;
  color: white
}
</style>
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
			<a class="navbar-brand" href="#">ITravel</a>
		</div>
		
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			    <!--  正在被選取的物件-->
		        <!-- 	<li class="active"><a href="#">看景點<span class="sr-only">(current)</span></a></li> -->
				<li><a href="<c:url value="/_01_Sight/SightIndex.jsp"/>">看景點</a></li>				
        		<li><a href="#">看行程</a></li>
        		<li><a href="#">看遊記</a></li>
        		<li><a href="<c:url value="/_02_TripAndJournal/member/NewTrip.jsp" />">排行程</a></li>
        		<li><a href="<c:url value="/_02_TripAndJournal/member/NewJournal.jsp" />">寫遊記</a></li>    		  		
        		<li><a href="<c:url value="/_04_Forum/ForumIndex.jsp" />">討論區</a></li>
      		    <li class="dropdown">
          				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">會員功能<span class="caret"></span></a>
          				<ul class="dropdown-menu" role="menu">
           			    	 <li><a href="#">我的景點</a></li>
          				     <li><a href="#">我的行程</a></li>
           					 <li><a href="#">我的遊記</a></li>
           					 <li><a href="#">我的好友</a></li>
        				  </ul>
       				 </li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</body>
</html>