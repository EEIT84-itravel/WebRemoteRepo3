package _04_Forum.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;
import _05_Member.model.CollectionService;
import _05_Member.model.FriendService;
import _05_Member.model.MemberVO;

@WebServlet("/_04_Forum/ShowArticle.controller")
public class ShowArticleServlet extends HttpServlet {
	
    //**在討論區點選文章後可以印出該文章的所有留言以及文章詳細內容**
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("forumId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int forumId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			forumId = Integer.parseInt(temp1);
		}
		// 驗證資料-無
		// 呼叫Model
				ForumService fs = new ForumService();
				ForumVO forumVO = fs.selectOne(forumId);
				//將瀏覽人次加1
				forumVO.setForumId(forumId);
				forumVO.setVisitorNum(forumVO.getVisitorNum()+1);
				fs.update(forumVO);
				
				MessageService ms = new MessageService();
				List<MessageVO> messageVO = ms.getForumMessage(forumId);
				
				
			    long count = ms.getForumMessageNum(forumId);
				if(forumVO != null ) {					
					request.setAttribute("forumVO", forumVO);	
					request.setAttribute("messageVO1", messageVO);
					request.setAttribute("count", count);
					// 會員已登入且景點未收藏過會顯示景點收藏鈕
					boolean flag = false;
					CollectionService collectionService = new CollectionService();
					MemberVO user = (MemberVO) request.getSession().getAttribute("user");
					if (user != null&& collectionService.selectCollection(forumVO.getForumId(),user.getMemberId(), "type_id05") == null) {
						flag = true;
					}
					request.setAttribute("flag", flag);
					  //會員已登入且作者未收藏過會顯示作者收藏鈕
					boolean flagmember = false;
					FriendService friendservice= new FriendService();
					if(user != null && user.getMemberId()!=forumVO.getMemberId() && friendservice.isfriend(user.getMemberId(), forumVO.getMemberId())==false){
						flagmember = true;
					}
					request.setAttribute("flagmember", flagmember);
				    request.getRequestDispatcher("/_04_Forum/LookArticle.jsp").forward(request, response);
				}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
