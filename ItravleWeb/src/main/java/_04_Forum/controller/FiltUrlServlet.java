package _04_Forum.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;

@WebServlet("/_04_Forum/member/FiltUrlServlet.controller")
public class FiltUrlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ForumService fs = new ForumService();
	private ForumVO fv = new ForumVO();
	private MessageService ms = new MessageService();
	private MessageVO mv = new MessageVO();

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String forumTopic = request.getParameter("forumTopic");
		String crud = request.getParameter("crud");
		String temp1 = request.getParameter("forumId");
		String temp2 = request.getParameter("messageId");
		
		int forumId = 0;
		if ("UpdateArticle".equals(crud)) {
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					forumId = Integer.parseInt(temp1);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		fv = fs.selectOne(forumId);
		
		int messageId = 0;
		if ("UpdateReply".equals(crud)) {
			if (temp2 != null && temp2.trim().length() != 0) {
				try {
					messageId = Integer.parseInt(temp2);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		mv = ms.selectOne(messageId);
		
		if("UpdateArticle".equals(crud)){
	        request.setAttribute("showThisArticle", fv);
	        request.getRequestDispatcher("/_04_Forum/member/ModifyArticle.jsp").forward(request, response);        
		}else if("UpdateReply".equals(crud)){
			request.setAttribute("showThisMessage", mv);
			request.getRequestDispatcher("/_04_Forum/member/Reply.jsp").forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

}
