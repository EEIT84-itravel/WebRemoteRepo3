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
	<article class="center-block">
		<form
			action="<c:url value="/_04_Forum/member/WritingsServlet.controller"/>"
			method="post">
			<fieldset id="introDiv">	
			<div id="forumHead" class="form-horizontal">
			<!-- 抓出從LookArticle.jsp傳過來的參數 -->
				<input type="hidden" name="forumId" value="${showThisArticle.forumId}">
				<input type="hidden" name="visit" value="${showThisArticle.visitorNum}">
				<input type="hidden" name="crud" value="${param.crud}">
				<input type="hidden" name="memberId" value="${user.memberId}">
				<c:import url="/_04_Forum/ForumHead.jsp"></c:import>
				<div style="height: 20px;"></div>
				<div class="form-group">
					<label class="control-label col-sm-2">文章主題:</label>
					<div class="col-sm-9">
						<input class="form-control" type="text" name="forumTopic" value="${showThisArticle.forumTopic}"/><span class="errorMsg">${error.forumTopic}</span>				    
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2">文章分類：</label>
					<div class="col-sm-6">
						<select name="forumTypeId">
								<c:forEach var="forum_type" items="${list}">
									<option value="${forum_type.codeId}">${forum_type.codeName}</option>
								</c:forEach>
						</select>			    
					</div>
				</div>
		
				<div class="form-group">
					<label class="control-label col-sm-2">文章內容：</label>
						<div class="col-sm-9">
						<textarea name="forumContent" rows="4" id="jBody" class="textBody form-control" cols="40">${showThisArticle.forumContent}</textarea>
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

							CKEDITOR.replace('forumContent', {
								toolbar : toolbar
							});
						</script>
						<span class="errorMsg">${error.forumContent}</span>
					</div>
			  	</div>	
			  				<div id="editor" style="text-align: center"><input type="submit" value="確定修改" class="btn btn-default" class="btn btn-default" 
							onclick="if(confirm('您確定要修改文章嗎?')) return true;else return false"></div>
			  		
			</div>
			</fieldset>	
		</form>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
