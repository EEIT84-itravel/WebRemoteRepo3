<%@ page import="_00_Misc.model.CodeVO"%>
<%@ page import="_00_Misc.model.CodeService"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> list = service.select("forum_type");
	pageContext.setAttribute("list", list);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel修改文章</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_04_Forum/Forum.css"/>" />

<!-- CKeditor文本編輯器CDN碼，可直接變更最新版本號碼 -->
<script src="//cdn.ckeditor.com/4.5.8/full/ckeditor.js"></script>

<script type="text/javascript">
	
</script>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
		<form
			action="<c:url value="/_04_Forum/member/WritingsServlet.controller"/>"
			method="post">
			<div id="forumHead">
				<!-- 抓出從LookArticle.jsp傳過來的參數 -->

				<input type="hidden" name="forumId" value="${param.forumId}">
				<input type="hidden" name="visit" value="${param.visit}"> <input
					type="hidden" name="reply" value="${param.reply}"> <input
					type="hidden" name="crud" value="${param.crud}">

				<table>

					<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
					<tr>

						<td>文章主題：</td>
						<td><input type="text" name="forumTopic"
							value="${param.forumTopic}" size="100" /></td>
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
						<td><textarea name="forumContent" rows="4" cols="50">${param.content}</textarea></td>
						<script>
							var toolbar = [
									//加粗     斜體，     下劃線      穿過線     文本顏色     背景顏色
									[ 'Bold', 'Italic', 'Underline', 'Strike',
											'TextColor', 'BGColor' ],
									//左對齊             居中對齊          右對齊          兩端對齊  超鏈接
									[ 'JustifyLeft', 'JustifyCenter',
											'JustifyRight', 'JustifyBlock',
											'Link' ],
									//樣式       格式      字體    字體大小  表情       特殊字符    
									[ 'Styles', 'Format', 'Font', 'FontSize',
											'Smiley', 'SpecialChar' ] ]
							var fontSize_sizes = '10pt/10pt;13/13px;16/16px;18/18px;20/20px;22/22px;24/24px;36/36px;48/48px;'
							CKEDITOR.replace('forumContent', {
								toolbar : toolbar
							}, {
								removePlugins : 'sourcearea'
							}, {
								fontSize : fontSize_sizes
							});
						</script>
						<td><span class="error">${error.forumContent}</span></td>
					</tr>
					<tr>
						<td><input type="submit" value="確定修改"
							onclick="if(confirm('您確定要修改文章嗎?')) return true;else return false"></td>
					</tr>
				</table>
			</div>
		</form>
	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>