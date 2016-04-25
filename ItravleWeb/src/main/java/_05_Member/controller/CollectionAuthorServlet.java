package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _05_Member.model.FriendService;
import _05_Member.model.MemberVO;
@WebServlet("/_05_Member/member/collectionauthor.controller")
public class CollectionAuthorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	FriendService friendservice = new FriendService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 接收HTML Form資料
		HttpSession session = request.getSession();
		Integer memberId = ((MemberVO) session.getAttribute("user"))
				.getMemberId();
		String temp1 = request.getParameter("friendId");//加入的好友Id
		String temp2 = request.getParameter("tripId");//參照編號
		Integer tripId = 0;
		Integer friendId = null;
		// 轉換HTML Form資料
				if(temp1 != null && temp1.trim().length()!=0){
					friendId = Integer.parseInt(temp1);
				}else{
					System.out.println("缺少欲加好友編號");
				}
				if(temp2 != null && temp2.trim().length()!=0){
					tripId = Integer.parseInt(temp2);
				}else{
					System.out.println("缺少行程編號");
				}
		//處理資料
				if(friendId != null ){
				friendservice.newFriend(memberId,friendId);
				}
				 //秀回畫面
				 String path = request.getContextPath();
					response.sendRedirect(path
							+ "/_02_TripAndJournal/ShowTrip.controller?tripId="
							+ tripId);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
