package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/member/FromTripToJournal.controller")
public class FromTripToJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//由舊行程匯入成新遊記,來自FromTripToJournal.jsp資料,顯示至WriteJournal.jsp

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("tripId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換HTML Form資料
		int tripId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			tripId = Integer.parseInt(temp1);
		} else {
			error.put("tripId", "行程ID錯誤");
		}

		// 驗證HTML Form資料
		// 無

		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/FromTripToJournal.jsp")
					.forward(request, response);
			return;
		}

		// 呼叫Model
		TripService tripService = new TripService();
		TripVO tripVO = tripService.select(tripId);
		
		JournalVO journalVO = new JournalVO();
		journalVO.setMemberId(tripVO.getMemberId());// 由tripVO取memberId
		journalVO.setJournalName(tripVO.getTripName());
		journalVO.setBeginTime(tripVO.getTripStartDate());
		journalVO.setEndTime(tripVO.getTripEndDate());
		journalVO.setRegionId(tripVO.getRegionId());
		journalVO.setJournalIntro(tripVO.getTripIntro());

		JournalService js = new JournalService();
		JournalVO result = js.insert(journalVO);

		if (result == null) {
			error.put("journalName", "insert fail");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/FromTripToJournal.jsp")
					.forward(request, response);
		} else {
			request.setAttribute("journalVO", result);
		}
		request.getRequestDispatcher(
				"/_02_TripAndJournal/member/WriteJournal.jsp").forward(request,
				response);

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
