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

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/ShowAllTripServlet.controller")
public class ShowAllTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//顯示所有行程至行程首頁
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收參數
		request.setCharacterEncoding("UTF-8");
		String temp = request.getParameter("tripId");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		// 型態轉換
		int tripId = 0;
		if (temp != null && temp.trim().length() != 0) {
			tripId = Integer.parseInt(temp);
		} else {
			error.put("tripId", "行程ID必須是數字");
		}
		// 資料驗證-無

		TripService tripService = new TripService();
		List<TripVO> tripVOs = null;
		TripVO tripVO = null;
		if (tripId == 0) {
			tripVOs = tripService.getAll();
		} else {
			tripVO = tripService.select(tripId);
		}
		if (!tripVOs.isEmpty()) {
			request.setAttribute("tripVOs", tripVOs);
			request.setAttribute("tripVO", tripVO);
			request.getRequestDispatcher(
					"/_02_TripAndJournal/TripIndex.jsp").forward(request,
					response);
		} else {
			error.put("tripId", "查無行程資料");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewTrip.jsp").forward(request,
					response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
