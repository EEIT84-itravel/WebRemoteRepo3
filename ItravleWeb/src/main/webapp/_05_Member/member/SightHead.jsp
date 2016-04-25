<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_04_Forum/Forum.css"/>" />
<title>我的景點的頭</title>
</head>
<body>
	<div>                       
    	<div class="btn-group btn-group-lg">
			  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region00&memberId=${user.memberId}" />'">&nbsp;&nbsp;全&nbsp;&nbsp;部&nbsp;&nbsp;</button>
			  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region01&memberId=${user.memberId}" />'">&nbsp;&nbsp;北&nbsp;&nbsp;區&nbsp;&nbsp;</button>
			  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region02&memberId=${user.memberId}" />'">&nbsp;&nbsp;中&nbsp;&nbsp;區&nbsp;&nbsp;</button>
			  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region03&memberId=${user.memberId}" />'">&nbsp;&nbsp;南&nbsp;&nbsp;區&nbsp;&nbsp;</button>
			  <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/_05_Member/member/RegionFiltType.controller?regionId=region04&memberId=${user.memberId}" />'">&nbsp;&nbsp;東&nbsp;&nbsp;區&nbsp;&nbsp;</button>           
		</div>	
	</div>
</body>
</html>