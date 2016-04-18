<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/tabs.css"/>" />

<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_04_Forum/forum.css"/>" />
<link rel="stylesheet" type="text/css"
	href="../css/_04_Forum/datatable.css" />
<link rel="stylesheet" type="text/css"
	href="../jquery-ui-1.11.4.custom/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css" />

<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>
<script type="text/javascript"
	src="../jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="">
</script>
<title>我的景點的頭</title>
</head>
<body>
<div>                                  
		<ul class="tabs">             
			<li><a href="<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region00&memberId=${user.memberId}" />">全部</a>&nbsp;&nbsp;</li>
			<li><a href="<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region01&memberId=${user.memberId}" />">北區</a>&nbsp;&nbsp;</li>
			<li><a href="<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region02&memberId=${user.memberId}" />">中區</a>&nbsp;&nbsp;</li>
			<li><a href="<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region03&memberId=${user.memberId}" />">南區</a>&nbsp;&nbsp;</li>
			<li><a href="<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region04&memberId=${user.memberId}" />">東區</a>&nbsp;&nbsp;</li>
		</ul>
		<ul></ul>
	</div>
</body>
</html>