<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel討論區回覆文章</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- CKeditor文本編輯器CDN碼，可直接變更最新版本號碼 -->
<script src="//cdn.ckeditor.com/4.5.8/full/ckeditor.js"></script>
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
			action="<c:url value="/_04_Forum/member/MessageServlet.controller"/>"
			method="post">
			<!--抓到LookArticle.jsp傳過來的值 -->
		<input type="hidden" name="referenceNo" value="${param.referenceNo}">
			<input type="hidden" name="messageId" value="${showThisMessage.messageId}">
			<input type="hidden" name="messageContent" value="${showThisMessage.content}">
			<input type="hidden" name="memberId" value="${param.memberId}" >
			<input type="hidden" name="crud" value="${param.crud}">
			

			<div id="forumHead">
				<table>
					<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
					<tr>
						<td>回覆內容：</td>
						<td><textarea rows="5" cols="40" name="content">${showThisMessage.content}</textarea></td>
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

							CKEDITOR.replace('content', {
								toolbar : toolbar
							});
						</script>
						<td><span class="error">${error.content}</span></td>
					</tr>
					<tr>
						<td><input type="submit" value="確定回覆"
							onclick="if(confirm('您確定回覆此文章嗎?')) return true;else return false"></td>
					</tr>
					<tr>
						<td></td>
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
