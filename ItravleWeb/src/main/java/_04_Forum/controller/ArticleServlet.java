package _04_Forum.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;


@WebServlet("/_04_Forum/member/Article.controller")
public class ArticleServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String forumTypeId = request.getParameter("forumTypeId");
		String forumTopic = request.getParameter("forumTopic");
		String forumContent = request.getParameter("forumContent");
		String forumAction = request.getParameter("forumAction");
		

		
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		
        //驗證
		if(forumTopic == null || forumTopic.trim().length() == 0){
			error.put("forumTopic", "請輸入您的文章主題");
		}
		if(forumContent == null || forumContent.trim().length() == 0){
			error.put("forumContent","請輸入文章內容");
		}
		if( error != null && !error.isEmpty()){
			request.getRequestDispatcher("/_04_Forum/member/Article.jsp").forward(request, response);
			return;
		}
		//呼叫model
		ForumService fs = new ForumService();
		ForumVO forumVO = new ForumVO();
		// 由session接收會員資料
		// HttpSession session = request.getSession();
		// MemberVO memberVO = (MemberVO) session.getAttribute("user");
		// int memberId = memberVO.getMemberId();
		// forumVO.setMemberId(memberId);
		forumVO.setMemberId(3);//暫時寫死會員id
		forumVO.setForumTypeId(forumTypeId);
		forumVO.setForumTopic(forumTopic);
		forumVO.setForumContent(forumContent);
		
		ForumVO result = fs.insert(forumVO);
		if(result == null){
			error.put("forumTopic", "新增失敗");
			request.getRequestDispatcher("/_04_Forum/member/Article.jsp").forward(request, response);
			return;
		}else{
			HttpSession session = request.getSession();
			session.setAttribute("forumVO", result);
		}
		String path = request.getContextPath();
		response.sendRedirect(path+"/_04_Forum/ForumIndex.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doGet(request, response);
	}

}
