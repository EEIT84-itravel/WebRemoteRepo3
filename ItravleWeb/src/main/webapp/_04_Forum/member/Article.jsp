<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel發表新文章</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<script type="text/javascript"
	src="<c:url value="/js/_04_Forum/ckeditor/ckeditor.js" />"></script>


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


	<form action="<c:url value="/_04_Forum/member/Article.controller"/>"
		method="post">
		<div id="header">
			<table>
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				<tr>
					<td>文章主題：</td>
					<td><input type="text" name="forumTopic"
						value="${param.forumTopic}" size="40" /></td>
					<td><span class="error">${error.forumTopic}</span></td>
				</tr>
				<tr>
					<td>文章分類：</td>
					<td><select name="forumTypeId">
							<c:forEach var="forum_type" items="${list}">
								<option value="${forum_type.codeId}">${forum_type.codeName}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>文章內容：</td>
					<td><textarea name="forumContent" rows="4" cols="50"></textarea></td>
					<script>
						CKEDITOR.replace('forumContent', {
							width:700,
						});
					</script>
					<td><span class="error">${error.forumContent}</span></td>
				</tr>
				<tr>
					<td><input type="submit" value="確定發表"></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>