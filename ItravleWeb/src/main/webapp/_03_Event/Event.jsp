<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>${eventVO.eventTopic}</title>
<style type="text/css">



</style>
</head>
<body>
	<form>
		<table>
			<tr>
				<td>���ʥD�D�G${eventVO.eventTopic}</td>
			</tr>
			<tr>
				<td>���ʤ��e�G${eventVO.eventContent}</td>
			</tr>
			<tr>
				<td>���ʰ_�W�ɶ��G${eventVO.eventStartDate}�_�A��${eventVO.eventEndDate}</td>
			</tr>
			<tr>                                    
				<td>���ʹϤ��G<img alt="" src="<c:url value="/_03_Event/ShowEventPic.controller?eventId=${eventVO.eventId}" />" width="600" height="500"></td>
			</tr>
			<tr>
				<td><a href="/ItravleWeb/_03_Event/AllEvent.jsp">�^���ʭ���</a></td>
			</tr>			
		</table>
	</form>



</body>
</html>