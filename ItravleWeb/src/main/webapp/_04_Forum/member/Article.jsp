<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發表新文章</title>
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript"
	src="../js/_04_Forum/ckeditor/ckeditor.js"></script>

<%@ page import="_00_Misc.model.CodeVO"%>
<%@ page import="_00_Misc.model.CodeService"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> list = service.select("forum_type");
	pageContext.setAttribute("list", list);
%>
</head>
<body>
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


		<form action="<c:url value="/_04_Forum/member/Article.controller"/>"
			method="post">
			<div>
				<table>
					<tr>
						<td>文章主題：</td>
						<td><input type="text" name="forumTopic"
							value="${param.forumTopic}" /></td>
						<td><span class="error">${error.forumTopic}</span></td>
					</tr>
					<tr>
						<td>文章分類：</td>
						<td><select name="forum_typeId">
								<c:forEach var="forum_type" items="${list}">
									<option value="${forum_type.codeId}">${forum_type.codeName}</option>
								</c:forEach>
						</select></td>
						<td><span class="error">${error.forum_typeId}</span></td>
					</tr>
				</table>
			</div>

			<div id="article">
				<textarea class='ckeditor' id="content" rows='' name="content"></textarea>
				<script type="text/javascript">
					CKEDITOR.replace('content');
				</script>
			</div>
		</form>
	</div>

</body>
</html>