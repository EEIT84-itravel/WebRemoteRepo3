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

@WebServlet("/_04_Forum/member/ReplyArticle.controller")
public class ReplyArticle extends HttpServlet {
	// 寫回覆文章的驗證
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		HttpSession hs = request.getSession();
		String messageType = request.getParameter("messageType");
		String content = request.getParameter("content");
		//抓出session裡的forumId，存為referenceNo
		int referenceNo = (int)hs.getAttribute("referenceNo");
	
		// 轉換資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		
		// 驗證	
		if (content == null || content.trim().length() == 0) {
			error.put("content", "請輸入您要回覆的內容");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_04_Forum/member/Reply.jsp")
					.forward(request, response);
			return;
		}
		// 呼叫model

		MessageService ms = new MessageService();
		MessageVO messageVO = new MessageVO();
		messageVO.setMemberId(4);
		messageVO.setContent(content);
		messageVO.setReferenceNo(referenceNo);
		messageVO.setMessageType(messageType);


		MessageVO result = ms.insert(messageVO);
		if (result == null) {
			error.put("content", "新增失敗");
			request.getRequestDispatcher("/_04_Forum/member/Reply.jsp")
					.forward(request, response);
			return;
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("messageVO", result);
		}
		String path = request.getContextPath();
		response.sendRedirect(path + "/_04_Forum/ShowArticle.controller?forumId="+referenceNo);

		// if("reply".equals(reply)){
		// request.getRequestDispatcher("/_04_Forum/member/Reply.jsp").forward(request,
		// response);
		// return;
		// }
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
