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

@WebServlet("/ShowAllTripServlet.controller")
public class ShowAllTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
//		TripDetailService tripDetailService=new TripDetailService();
//		List<TripDetailVO> TripDetailVOs=tripDetailService.select(tripId);
		if (tripId == 0) {
			tripVOs = tripService.getAll();
		} else {
			tripVO = tripService.select(tripId);
		}
		if (!tripVOs.isEmpty()) {
			HttpSession session = request.getSession();
			session.setAttribute("tripVOs", tripVOs);
			session.setAttribute("tripVO", tripVO);
			String path = request.getContextPath();
			response.sendRedirect(path + "/_02_TripAndJournal/TripIndex.jsp");
		}else{
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
