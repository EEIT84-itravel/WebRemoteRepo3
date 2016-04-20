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

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;
import _05_Member.model.MemberVO;

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
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		String crud = request.getParameter("crud");
		String temp1 = request.getParameter("forumId");
		String temp2 = request.getParameter("messageId");
		MemberVO memberVO =(MemberVO)session.getAttribute("user");
		int memberId = memberVO.getMemberId();

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		int forumId = 0;
		if("UpdateArticle".equals(crud))
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				forumId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

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
		if ("UpdateArticle".equals(crud)) {
			if (fs.selectOne(forumId).getMemberId() == memberId) {
				fv = fs.selectOne(forumId);
				request.setAttribute("showThisArticle", fv);
				request.setAttribute("memberId", memberId);
				request.getRequestDispatcher(
						"/_04_Forum/member/ModifyArticle.jsp").forward(request,
						response);
			} else {
				error.put("fContent", "非本人不可編輯");
				response.sendRedirect(path
						+ "/_04_Forum/ShowArticle.controller?forumId="
						+ forumId);
				return;
			}
		}
		if ("UpdateReply".equals(crud)) {
			if (ms.selectOne(messageId).getMemberId() == memberId) {
				mv = ms.selectOne(messageId);
				request.setAttribute("showThisMessage", mv);
				request.setAttribute("memberId", memberId);
				request.getRequestDispatcher("/_04_Forum/member/Reply.jsp")
						.forward(request, response);
			} else {
				error.put("fContent", "非本人不可編輯");
				response.sendRedirect(path
						+ "/_04_Forum/ShowArticle.controller?forumId="
						+ forumId);
				return;
			}
		}
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

}
