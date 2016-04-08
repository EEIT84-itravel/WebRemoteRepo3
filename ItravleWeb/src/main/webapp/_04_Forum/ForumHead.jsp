<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/tabs.css"/>" />

<script type="text/javascript" src="">
	
</script>
<title>討論區的頭</title>
</head>
<body>
	<div>
		<ul class="tabs">
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type00"/>">全部</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type01" />">其他</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type02" />">景點</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type03" />">行程</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type04" />"
				name="">遊記</a>&nbsp;&nbsp;</li>

			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type05" />">交通</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type06" />">飲食</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type07" />">住宿</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type08" />">購物</a>&nbsp;&nbsp;</li>
			<li><a
				href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type09" />">金錢</a>&nbsp;&nbsp;</li>
		<li><input type="submit" name="forumAction" value="發表文章" /></li>
		</ul>
		<ul></ul>
	</div>


</body>
</html>