package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _05_Member.model.FriendService;

@WebServlet("/_05_Member/member/deletefriend.controller")
public class DeleteFriendCollectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	FriendService friendservice = new FriendService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		Integer memberId = null;
		Integer friendId = null;
		String temp1 = request.getParameter("memberId");
		String temp2 = request.getParameter("friendId");
		//轉換資料型態
		if(temp1 != null && temp1.trim().length()!=0){
			memberId = Integer.parseInt(temp1);
		}else{
			System.out.println("缺少會員編號");
		}
		if(temp2 != null && temp2.trim().length()!=0){
			friendId = Integer.parseInt(temp2);
		}else{
			System.out.println("缺少好友編號");
		}
		friendservice.delFriend(memberId, friendId);
		 //秀回畫面
		String path = request.getContextPath();
		response.sendRedirect(path+"/_05_Member/member/MemberCollectionMember.jsp");
		 return;
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
