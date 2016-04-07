<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>I-Travel活動頁面</title>
</head>
<body>
	<form>
		<table>
		
		
			<tr>
				<td>活動主題：${eventVO.eventTopic}</td>
			</tr>
			<tr>
				<td>活動內容：${eventVO.eventContent}</td>
			</tr>
			<tr>
				<td>活動起訖時間：${eventVO.eventStartDate}起，至${eventVO.eventEndDate}</td>
			</tr>
			<tr>
				<td><a href="/ItravleWeb/_03_Event/AllEvent.jsp">回活動首頁</a></td>
			</tr>
			
		</table>
	</form>



</body>
</html>