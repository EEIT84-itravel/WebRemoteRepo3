<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript" src="">
	
</script>
<title>討論區的頭</title>
</head>
<body>
	<div>
	
		<form action="<c:url value="/_04_Forum/FiltType.controller" />"></form>
		<table id="t1">
			<tr id="tr1">

				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type00"/>">全部</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type01" />">其他</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type02" />">景點</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type03" />">行程</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type04" />" name="">遊記</a>&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type05" />">交通</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type06" />">飲食</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type07" />">住宿</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type08" />">消費</a>&nbsp;&nbsp;</td>
				<td><a href="<c:url value="/_04_Forum/FiltType.controller?forumTypeId=forum_type09" />">金錢</a>&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>
	
	<div id="d3">
		<input type="submit" name="forumAction" value="發表文章" />
	</div>

</body>
</html>