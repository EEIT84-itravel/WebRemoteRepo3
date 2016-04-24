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

import _02_TripAndJournal.model.JournalDetailService;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalPhotoService;
import _02_TripAndJournal.model.JournalPhotoVO;
import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;


@WebServlet("/_02_TripAndJournal/member/ModifyJournal.controller")
public class ModifyJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String temp1 = request.getParameter("journalId");
		
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int journalId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				journalId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		JournalDetailService journalDetailService = new JournalDetailService();
		List<JournalDetailVO> journalDetailVO = journalDetailService.selectByJournalId(journalId);
		JournalService journalService = new JournalService();
		JournalVO journalVO = journalService.select(journalId);
		JournalPhotoService jps = new JournalPhotoService();
		JournalPhotoVO journalPhotoVO = jps.selectCover(journalDetailVO);
		
		session.setAttribute("modifyVO", journalVO);
		session.setAttribute("modifyDetailVO", journalDetailVO);
		session.setAttribute("modifyPhotoVO", journalPhotoVO);
		
//		request.setAttribute("modifyVO", journalVO);
//		request.setAttribute("modifyDetailVO", journalDetailVO);
		
		response.sendRedirect(path + "/_02_TripAndJournal/member/modifyJournal.jsp");
//		request.getRequestDispatcher("/_02_TripAndJournal/member/modifyJournal.jsp").forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
		
	}



}
