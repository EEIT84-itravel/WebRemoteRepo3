<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
FriendService friendservice = new FriendService();
MemberService memberservice = new MemberService();
//抓使用者ID
MemberVO user = (MemberVO)session.getAttribute("user");
int memberId = user.getMemberId();
//找到會員追蹤的作者(會員)
List<Integer> list = new ArrayList<Integer>();
ArrayList<MemberVO> friendVO = new ArrayList<MemberVO>();  //好友(追蹤作者)的會員資料
 list = friendservice.findFriend(memberId);
 if(list!=null && list.size()>0){
		for(int i = 0 ; i<list.size();i++){
			MemberVO author = new MemberVO();
			author = memberservice.selectById(list.get(i));
			friendVO.add(i,author);
		}
	}
	pageContext.setAttribute("friendVO", friendVO);
%>    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的追蹤作者</title>
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
<table id="forum" border="1">
<thead>
				<tr id="forumTitle">
				    <th>作者照片</th>
					<th>作者帳號</th>
					<th>作者暱稱</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${not empty friendVO}">
			<c:forEach var="friendVO" items="${friendVO}">
			<tr>
			<td><img  src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${friendVO.memberId}" />" width="240" height="180"></td>
			<td><a href="<c:url value="/_05_Member/member/findauthor.controller?memberId=${friendVO.memberId}"/>">${friendVO.firstName}</a>&nbsp;&nbsp;</td>
			<td>${friendVO.nickname}</td>
			<td><a href="<c:url value="/_05_Member/member/deletefriend.controller?memberId=${user.memberId}&friendId=${friendVO.memberId}"/>">移出收藏夾</a>&nbsp;&nbsp;</td>
			</tr>
			</c:forEach>
			</c:if>
			</tbody>
</table>
</article>
</body>
</html>