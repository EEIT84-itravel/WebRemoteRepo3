<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="_01_Sight.model.*"%>
<%@page import="_00_Misc.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService codeService = new CodeService();
	List<CodeVO> codeVO = codeService.select("region");
	pageContext.setAttribute("region", codeVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<title>進階搜尋</title>
</head>
<body>
	<header>
		<!-- import共同的 -->
	</header>
	<!-- import共同的 -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
		<jsp:include page="/_00_Misc/top.jsp" />
	</nav>
	<article>
		<form action="">
			<table>
				<tr>
					<td>地區:<select></select>
					</td>
					<td>縣市:<select></select>
					</td>
					<td>類型:<select></select>
					</td>
					<td>消費金額:<select></select>
					</td>
					<td>建議遊玩時間:<select></select>
					</td>
					<td>開放時間:<select></select>
					</td>
				</tr>
			</table>
		</form>
	</article>
	<footer>
		<div> <jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>