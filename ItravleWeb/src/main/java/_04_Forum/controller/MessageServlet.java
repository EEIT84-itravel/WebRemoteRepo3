package _04_Forum.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
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

@WebServlet("/_04_Forum/member/MessageServlet.controller")
public class MessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MessageService ms = new MessageService();
	private MessageVO messageVO = new MessageVO();

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 接收資料
		String temp1 = request.getParameter("referenceNo");
		String temp2 = request.getParameter("messageId");
		String content = request.getParameter("content");
		String crud = request.getParameter("crud");
		System.out.println(temp1);
		System.out.println(temp2);

		// 轉換資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		// 轉換資料
		int referenceNo = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			try {
				referenceNo = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		// 新增文章不需轉換messageId
		int messageId = 0;
		if (!"NewReply".equals(crud)) {
			if (temp2 != null || temp2.trim().length() != 0) {
				try {
					messageId = Integer.parseInt(temp2);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		messageVO.setMemberId(4);
		messageVO.setContent(content);
		messageVO.setReferenceNo(referenceNo);
		messageVO.setUpdateTime(new Timestamp(new Date().getTime()));
		messageVO.setMessageType("type_id05"); // 寫死留言類型

		String path = request.getContextPath();
		if ("NewReply".equals(crud)) {
			MessageVO result = ms.insert(messageVO);
			if (result == null) {
				error.put("messageContent", "新增失敗");
				response.sendRedirect(path + "/_04_Forum/member/Reply.jsp");
				return;
			} else {
				HttpSession session = request.getSession();
				request.setAttribute("messageVO", result);
			}
			response.sendRedirect(path
					+ "/_04_Forum/ShowArticle.controller?forumId="
					+ referenceNo);
		} else if ("UpdateReply".equals(crud)) {
			messageVO.setMessageId(messageId);
			MessageVO result = ms.update(messageVO);
			if (result == null) {
				error.put("forumTopic", "修改失敗");
				response.sendRedirect(path + "/_04_Forum/member/Reply.jsp");
				return;
			} else {
				request.setAttribute("messageVO", result);
			}
			response.sendRedirect(path
					+ "/_04_Forum/ShowArticle.controller?forumId="
					+ referenceNo);
		} else if ("Delete".equals(crud)) {
			System.out.println(messageId);
			messageVO.setMessageId(messageId);
			boolean result = ms.delete(messageVO);
			if (result == false) {
				error.put("messageTopic", "刪除失敗");
				response.sendRedirect(path + "/_04_Forum/LookArticle.jsp");
				return;
			} else {
				response.sendRedirect(path
						+ "/_04_Forum/ShowArticle.controller?forumId="
						+ referenceNo);
			}
		}
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
