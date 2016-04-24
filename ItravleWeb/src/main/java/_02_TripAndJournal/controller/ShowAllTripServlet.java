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
	//顯示所有行程至行程首頁,可選擇排列順序
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收參數
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		String select = request.getParameter("select");
		
		List<TripVO> tripVOs=null;
		TripService tripService=new TripService();
		if ("byWatchNum".equals(select)) {
			tripVOs = tripService.selectOrderByWatch();
		} else if ("byCollectNum".equals(select)) {
			tripVOs=tripService.searchByCollectNum();
		} else if ("byModifyTime".equals(select)) {
			tripVOs = tripService.selectOrderByModifyTime();
		}
		
		
		if (!tripVOs.isEmpty()) {
			request.setAttribute("selectTripVOs", tripVOs);
			request.getRequestDispatcher(
					"/_02_TripAndJournal/TripIndex.jsp").forward(request,
					response);
		} else {
			error.put("noneSearch", "查無行程資料");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/TripIndex.jsp").forward(request,
					response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
