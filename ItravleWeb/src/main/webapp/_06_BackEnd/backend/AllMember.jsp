<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="MemberService" scope="page" class="_05_Member.model.MemberService" />
<!-- 外接程式碼 -->
<%@ page import="_05_Member.model.*"%>
<%@ page import="java.util.*"%>
<%
	MemberService memberService = new MemberService();
 	List<MemberVO> sightVO = memberService.getAll();
 	pageContext.setAttribute("sightVO", sightVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>I-Travel後台:管理會員</title>
</head>
<body>
<h2>I-Travel後台:管理會員</h2>
				<%  int rowsPerPage = 20;  //每頁的筆數 %>
					<%@ include file="/_00_Misc/page1.file" %>
						<table border="1" class="backendTable">
							<thead>
								<tr>
									<th>會員帳號</th>
									<th>姓</th>
									<th>名</th>
									<th>暱稱</th>
									<th>email</th>
									<th>生日</th>
									<th>電話</th>
									<th>修改人</th>
									<th>修改時間</th>
									<th>管理權限</th>
								</tr>
							</thead>
							<tbody> 
								<c:forEach var="sightVO" items="${sightVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr>							
									<td>${sightVO.memberAccount}</td>
									<td>${sightVO.lastName}</td>
									<td>${sightVO.firstName}</td>
									<td>${sightVO.nickname}</td>
									<td>${sightVO.email}</td>
									<td>${sightVO.birth}</td>
									<td>${sightVO.cellphone}</td>
									<c:forEach var="MemberVO" items="${MemberService.all}">
                             			<c:if test="${MemberVO.memberId==sightVO.modifier}">
											 <td>${MemberVO.nickname}</td>
                             			</c:if>
									</c:forEach>
									<td>${sightVO.modiftyTime}</td>
									<td> 																																
										<FORM ACTION="<c:url value="/_06_BackEnd/backend/modifyAdmin.controller" />">
			     							<select name="admin" style="color:black"> 
 													<option value="true" ${(sightVO.admin==true)?'selected':''}>管理員</option> 
 													<option value="false" ${(sightVO.admin==false)?'selected':''}>普通會員</option> 
 											</select> 
			     							<input style="color:black" type="submit" value="修改">
			     							<input type="hidden" name="memberId" value="${sightVO.memberId}">
			     						</FORM>
			     					</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
			<%@ include file="/_00_Misc/page2.file" %>
</body>
</html>