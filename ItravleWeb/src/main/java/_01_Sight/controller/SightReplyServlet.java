package _01_Sight.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.property.Getter;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet("/_01_Sight/member/SightReplyServlet.controller")
public class SightReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 景點、遊記、行程 所有留言共用

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		String temp1 = request.getParameter("referenceNo");// 景點ID,referenceNo
		String content = request.getParameter("reply");// 回覆內容
		String type = request.getParameter("type");// 回覆類型

		MessageService messageService = new MessageService();
		MessageVO messageVO = new MessageVO();
		if ("type_id01".equals(type)) {// 類型=景點
			// 轉換HTML Form資料
			int referenceNo = 0;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					referenceNo = Integer.parseInt(temp1);
				} catch (IllegalArgumentException e) {
					error.put("referenceNo", "景點ID必須是數字");
				}
			} else {
				error.put("reply", "請填入留言內容");
			}
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_01_Sight/Sight.controller?sightId=" + referenceNo)
						.forward(request, response);
				return;
			}

			// 呼叫model
			messageVO.setMessageType(type);
			HttpSession session = request.getSession();
			MemberVO user = (MemberVO) session.getAttribute("user");
			messageVO.setMemberId(user.getMemberId());// 由session抓取現在登入者
			messageVO.setContent(content);// 內容
			java.util.Date now=new java.util.Date();
			java.sql.Timestamp time= new java.sql.Timestamp(now.getTime());
			messageVO.setUpdateTime(time);
			messageVO.setReferenceNo(referenceNo);// 參照編號(此為景點ID)
			MessageVO result = messageService.insert(messageVO);
			if (result != null) {
				String path = request.getContextPath();
				response.sendRedirect(path
						+ "/_01_Sight/Sight.controller?sightId=" + referenceNo+"#tabs-4");
			} else {
				error.put("reply", "留言失敗");
				request.getRequestDispatcher(
						"/_01_Sight/Sight.controller?sightId=" + referenceNo)
						.forward(request, response);
			}
		}
		if ("type_id02".equals(type)) {// 類型=行程
			// 轉換HTML Form資料
			int referenceNo = 0;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					referenceNo = Integer.parseInt(temp1);
				} catch (IllegalArgumentException e) {
					error.put("referenceNo", "行程ID必須是數字");
				}
			} else {
				error.put("reply", "請填入留言內容");
			}
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_02_TripAndJournal/ShowTrip.controller?tripId="
								+ referenceNo).forward(request, response);
				return;
			}

			// 呼叫model
			messageVO.setMessageType(type);
			HttpSession session = request.getSession();
			MemberVO user = (MemberVO) session.getAttribute("user");
			messageVO.setMemberId(user.getMemberId());// 由session抓取現在登入者
			messageVO.setContent(content);// 內容
			java.util.Date now=new java.util.Date();
			java.sql.Timestamp time= new java.sql.Timestamp(now.getTime());
			messageVO.setUpdateTime(time);
			messageVO.setReferenceNo(referenceNo);// 參照編號(此為景點ID)
			MessageVO result = messageService.insert(messageVO);
			if (result != null) {
				String path = request.getContextPath();
				response.sendRedirect(path
						+ "/_02_TripAndJournal/ShowTrip.controller?tripId="
						+ referenceNo);
			} else {
				error.put("reply", "留言失敗");
				request.getRequestDispatcher(
						"/_02_TripAndJournal/ShowTrip.controller?tripId="
								+ referenceNo).forward(request, response);
			}
		}
		if ("type_id03".equals(type)) {// 類型=遊記
			// 轉換HTML Form資料
			int referenceNo = 0;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					referenceNo = Integer.parseInt(temp1);
				} catch (IllegalArgumentException e) {
					error.put("referenceNo", "遊記ID必須是數字");
				}
			} else {
				error.put("reply", "請填入留言內容");
			}
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_02_TripAndJournal/ShowJournalDetail.controller?journalId="
								+ referenceNo).forward(request, response);
				return;
			}

			// 呼叫model
			messageVO.setMessageType(type);
			HttpSession session = request.getSession();
			MemberVO user = (MemberVO) session.getAttribute("user");
			messageVO.setMemberId(user.getMemberId());// 由session抓取現在登入者
			messageVO.setContent(content);// 內容
			messageVO.setReferenceNo(referenceNo);// 參照編號(此為景點ID)
			java.util.Date now=new java.util.Date();
			java.sql.Timestamp time= new java.sql.Timestamp(now.getTime());
			messageVO.setUpdateTime(time);
			MessageVO result = messageService.insert(messageVO);
			if (result != null) {
				String path = request.getContextPath();
				response.sendRedirect(path
						+ "/_02_TripAndJournal/ShowJournalDetail.controller?journalId="
						+ referenceNo);
			} else {
				error.put("reply", "留言失敗");
				request.getRequestDispatcher(
						"/_02_TripAndJournal/ShowJournalDetail.controller?journalId="
								+ referenceNo).forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
