<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<%
	ForumService forumService = new ForumService();
 	List<ForumVO> forumVO = forumService.select();
 	pageContext.setAttribute("forumVO", forumVO);
%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
</style>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript" src="">
	
</script>
<title>ITravel討論區</title>
</head>
<body>
		<form action="<c:url value="/_04_Forum/Forum.controller"/>"	method="post">

		<div id="header">
			<div>
				<table id="t1">
					<tr id="tr1">
						<td><a href="">全部</a>&nbsp;&nbsp;</td>
						<td><a href="">行程</a>&nbsp;&nbsp;</td>
						<td><a href="">遊記</a>&nbsp;&nbsp;</td>
						<td><a href="">住宿</a>&nbsp;&nbsp;</td>
						<td><a href="">交通</a>&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td><a href="">飲食</a>&nbsp;&nbsp;</td>
						<td><a href="">景點</a>&nbsp;&nbsp;</td>
						<td><a href="">金錢</a>&nbsp;&nbsp;</td>
						<td><a href="">消費</a>&nbsp;&nbsp;</td>
						<td><a href="">其他</a>&nbsp;&nbsp;</td>
					</tr>
				</table>
			</div>
			<div id="d1">
				排序方式<br> <select>
					<option value="time">時間</option>
					<option value="view">瀏覽數</option>
				</select>
			</div>
			<div id="d2">
				關鍵字搜尋<br> <input type="text" value="請輸入關鍵字" />
			</div>
			<div id="d3">
				<input type="submit" name="forumAction" value="發表文章" />
			</div>
			<table id="forum" border="1">
				<thead>
					<tr id="forumTitle">
						<th>討論類型</th>
						<th>討論主題</th>
						<th>作者</th>
						<th>瀏覽人次</th>
						<th>回覆數</th>
						<th>最後發表</th>
					</tr>
				</thead>
				<tbody >
					<c:forEach var="forumVO" items="${forumVO}">
						<tr>
					<c:set value="select" target="${forumVO.forumTopic}" var="forumAction" />
                            <td>${forumVO.forumTypeId}</td>                        
							<td><a href="<c:url value="/_04_Forum/ShowArticle.controller?forumId=${forumVO.forumId}" />">${forumVO.forumTopic}</a></td>
							<td>${forumVO.memberId}</td>
							<td>${forumVO.visitorNum}</td>			
							<td>${forumVO.replyNum}</td>
							<td>${forumVO.forumTime}</td>
													
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>