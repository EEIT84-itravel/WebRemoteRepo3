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
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;
import _05_Member.model.MemberVO;

@WebServlet("/_02_TripAndJournal/member/NewTrip.controller")
public class NewTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//建立新行程的controller 接收來自NewTrip.jsp資料,傳送至WriteTrip.jsp
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		String tripName = request.getParameter("tripName");
		String temp1 = request.getParameter("tripStartDate");
		String temp2 = request.getParameter("tripEndDate");
//		String temp3 = request.getParameter("startTime");
		String regionId = request.getParameter("regionId");
//		String transFormId = request.getParameter("transFormId");
		String tripIntro = request.getParameter("tripIntro");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換HTML Form資料
		java.sql.Date tripStartDate = null;
		if (temp1 != null && temp1.trim().length() != 0) {
			// yyyy-[m]m-[d]d
			try {
				tripStartDate = Date.valueOf(temp1);
			} catch (IllegalArgumentException e) {
				error.put("tripStartDate", "日期格式錯誤");
			}
		}
		java.sql.Date tripEndDate = null;
		if (temp2 != null && temp2.trim().length() != 0) {
			// yyyy-[m]m-[d]d
			try {
				tripEndDate = Date.valueOf(temp2);
			} catch (IllegalArgumentException e) {
				error.put("tripEndDate", "日期格式錯誤");
			}
		}
//		java.sql.Time startTime = null;
//		if (temp3 != null && temp3.trim().length() != 0) {
//			// yyyy-[m]m-[d]d
//			try {
//				startTime = Time.valueOf(temp3 + ":00");
//			} catch (IllegalArgumentException e) {
//				error.put("startTime", "時間格式錯誤");
//			}
//		}

		// 驗證HTML Form資料
		if (tripName == null || tripName.trim().length() == 0) {
			error.put("tripName", "請輸入行程名稱");
		}
		if (tripStartDate == null) {
			error.put("tripStartDate", "請輸入開始日期");
		}
		if (tripEndDate == null) {
			error.put("tripEndDate", "請輸入結束日期");
		}
		if (tripStartDate != null && tripEndDate != null) {
			if (tripStartDate.after(tripEndDate)) {
				error.put("tripEndDate", "結束日期必須大於開始日期");
			}
		}
//		if (startTime == null) {
//			error.put("startTime", "請輸入開始遊玩時間");
//		}
		if (regionId == null || regionId.trim().length() == 0) {
			error.put("regionId", "請選擇地區");
		}
//		if (transFormId == null || transFormId.trim().length() == 0) {
//			error.put("transFormId", "請選擇交通工具");
//		}

		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewTrip.jsp").forward(request,
					response);
			return;
		}

		// 呼叫Model
		TripService ts = new TripService();
		TripVO tripVO = new TripVO();
		// 由session接收會員資料
		 HttpSession session = request.getSession();
		 MemberVO memberVO = (MemberVO) session.getAttribute("user");
		 int memberId = memberVO.getMemberId();
		 tripVO.setMemberId(memberId);
		tripVO.setTripName(tripName);
		tripVO.setTripStartDate(tripStartDate);
		tripVO.setTripEndDate(tripEndDate);
		java.sql.Time startTime = java.sql.Time.valueOf("00:00:00");
		tripVO.setStartTime(startTime);
		tripVO.setRegionId(regionId);
		tripVO.setTransFormId("trans_form01");
		tripVO.setTripIntro(tripIntro);
		tripVO.setWatchNum(1);
		TripVO result = ts.insert(tripVO);
		if (result == null) {
			error.put("tripName", "insert fail");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewTrip.jsp").forward(request,
					response);
		} else {
			session.setAttribute("tripVO", result);	
		}

		String path = request.getContextPath();
		response.sendRedirect(path + "/_02_TripAndJournal/member/WriteTrip.jsp");
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
