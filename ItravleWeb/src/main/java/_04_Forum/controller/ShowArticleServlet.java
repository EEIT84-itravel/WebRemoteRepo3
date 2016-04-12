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

@WebServlet("/_04_Forum/ShowArticle.controller")
public class ShowArticleServlet extends HttpServlet {
	
    //**在討論區首頁印出所有文章**
	
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
				MessageService ms = new MessageService();
				List<MessageVO> messageVO = ms.getForumMessage(forumId);
				if(forumVO != null ) {					
					request.setAttribute("forumVO", forumVO);	
					request.setAttribute("messageVO1", messageVO);
				    request.getRequestDispatcher("/_04_Forum/LookArticle.jsp").forward(request, response);
				}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
