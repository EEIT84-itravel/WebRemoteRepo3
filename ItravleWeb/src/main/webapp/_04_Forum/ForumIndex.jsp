<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_04_Forum.model.*"%>
<%@ page import="java.util.*"%>
<% 
ForumService forumService = new ForumService();
	List<ForumVO> forumVO = forumService.select();
	pageContext.setAttribute("forumtVO", forumVO);	
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


<%-- 	<form action="<c:url value="/_04_Forum/Forum.controller"/>"	method="post"> --%>
<form method="post">
		<div id="header">
			<div>
				<table id="t1">
					<tr id="tr1">
						<td><a href="">全部主題</a>&nbsp;&nbsp;</td>
						<td><a href="">行程交流</a>&nbsp;&nbsp;</td>
						<td><a href="">遊記交流</a>&nbsp;&nbsp;</td>
						<td><a href="">住宿討論</a>&nbsp;&nbsp;</td>
						<td><a href="">交通方式</a>&nbsp;&nbsp;</td>
						<td><a href="">飲食分享</a>&nbsp;&nbsp;</td>
						<td><a href="">景點討論</a>&nbsp;&nbsp;</td>
						<td><a href="">我愛購物</a>&nbsp;&nbsp;</td>
						<td><a href="">消費高手</a>&nbsp;&nbsp;</td>
						<td><a href="">其他分類</a>&nbsp;&nbsp;</td>
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
				<input type="submit" name="forumAction" value="Submit" />

			</div>



			<table id="forum">
				<thead>
					<tr id="forumTitle">
						<th>討論類型</th>
						<th>討論主題</th>
						<th>作者</th>
						<th>回覆數</th>
						<th>最後發表</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ForumVO" items="${ForumVO}">
						<tr>
							<td>${ForumVO.forumTopic}</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>


					</c:forEach>
				</tbody>
			</table>



		</div>
	</form>
</body>
</html>