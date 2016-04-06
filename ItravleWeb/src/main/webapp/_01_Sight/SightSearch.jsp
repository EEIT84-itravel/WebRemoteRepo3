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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>進階搜尋</title>
</head>
<body>

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
</body>
</html>