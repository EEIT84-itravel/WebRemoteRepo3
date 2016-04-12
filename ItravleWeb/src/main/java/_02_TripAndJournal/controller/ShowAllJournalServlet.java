package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/ShowAllJournalServlet.controller")
public class ShowAllJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// 接收參數
		request.setCharacterEncoding("UTF-8");
		String temp = request.getParameter("journalId");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		// 型態轉換
		int journalId = 0;
		if (temp != null && temp.trim().length() != 0) {
			journalId = Integer.parseInt(temp);
		} else {
			error.put("journalId", "遊記ID必須是數字");
		}
		// 資料驗證-無

		// 呼叫model
		JournalService journalService = new JournalService();

		List<JournalVO> journalVOs = null;
		JournalVO journalVO = null;
		if (journalId == 0) {
			journalVOs = journalService.getAll();
		} else {
			journalVO = journalService.select(journalId);
		}
		if (!journalVOs.isEmpty()) {
			HttpSession session = request.getSession();
			session.setAttribute("journalVOs", journalVOs);
			session.setAttribute("journalVO", journalVO);
			String path = request.getContextPath();
			response.sendRedirect(path + "/_02_TripAndJournal/JournalIndex.jsp");
		} else {
			error.put("journalId", "查無遊記資料");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewJournal.jsp").forward(
					request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
