package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
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

@WebServlet("/_02_TripAndJournal/member/NewJournal.controller")
public class NewJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		String journalName = request.getParameter("journalName");
		String temp1 = request.getParameter("beginTime");
		String temp2 = request.getParameter("endTime");
		String regionId = request.getParameter("regionId");
		String journalIntro = request.getParameter("journalIntro");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換HTML Form資料
		java.sql.Date beginTime = null;
		if (temp1 != null && temp1.trim().length() != 0) {
			// yyyy-[m]m-[d]d
			try {
				beginTime = Date.valueOf(temp1);
			} catch (IllegalArgumentException e) {
				error.put("beginTime", "日期格式錯誤");
			}
		}
		java.sql.Date endTime = null;
		if (temp2 != null && temp2.trim().length() != 0) {
			// yyyy-[m]m-[d]d
			try {
				endTime = Date.valueOf(temp2);
			} catch (IllegalArgumentException e) {
				error.put("endTime", "日期格式錯誤");
			}
		}
		// 驗證HTML Form資料
		if (journalName == null || journalName.trim().length() == 0) {
			error.put("journalName", "請輸入行程名稱");
		}
		if (beginTime == null) {
			error.put("beginTime", "請輸入開始日期");
		}
		if (endTime == null) {
			error.put("endTime", "請輸入結束日期");
		}
		if (beginTime != null && endTime != null) {
			if (beginTime.after(endTime)) {
				error.put("endTime", "結束日期必須大於開始日期");
			}
		}
		if (regionId == null || regionId.trim().length() == 0) {
			error.put("regionId", "請選擇地區");
		}

		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewJournal.jsp").forward(
					request, response);
			return;
		}

		// 呼叫Model
		JournalService js = new JournalService();
		JournalVO journalVO = new JournalVO();
		// 由session接收會員資料
		// HttpSession session = request.getSession();
		// MemberVO memberVO = (MemberVO) session.getAttribute("user");
		// int memberId = memberVO.getMemberId();
		// journalVO.setMemberId(memberId);
		journalVO.setMemberId(1);// 寫死memberId
		journalVO.setJournalName(journalName);
		journalVO.setBeginTime(beginTime);
		journalVO.setEndTime(endTime);
		journalVO.setRegionId(regionId);
		journalVO.setJournalIntro(journalIntro);

		JournalVO result = js.insert(journalVO);
		if (result == null) {
			error.put("journalName", "insert fail");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewJournal.jsp").forward(
					request, response);
		} else {
			request.setAttribute("journalVO", result);
		}
		request.getRequestDispatcher(
				"/_02_TripAndJournal/member/WriteJournal.jsp").forward(
				request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
