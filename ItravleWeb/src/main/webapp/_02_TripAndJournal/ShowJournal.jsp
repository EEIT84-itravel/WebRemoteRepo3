<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="MemberService" scope="page"
	class="_05_Member.model.MemberService" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${showJournalVO.journalName}</title>
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
		<h1 style="color: red;">${showJournalVO.journalName}</h1>
		<div>
			<table>
				<tr>
					<td><img
						src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${showJournalVO.memberId}" />"
						width="100px" height="100px"><td>
						
					<ul style="list-style-type: none;">
							<li><c:forEach var="MemberVO" items="${MemberService.all}">
									<c:if test="${MemberVO.memberId==showJournalVO.memberId}">作者：${MemberVO.nickname}</c:if>
								</c:forEach></li>
						<li>發表於:${showJournalVO.modifyTime}</li>
						<li>瀏覽人次:${showJournalVO.visitorNum}</li>
						<li></li>
					</ul>
					
				</tr>
			</table>
		</div>


	</article>
	<footer>
		<!-- import共同的 -->
	</footer>
</body>
</html>