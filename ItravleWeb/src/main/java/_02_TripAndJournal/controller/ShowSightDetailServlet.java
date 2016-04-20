package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;

@WebServlet("/_02_TripAndJournal/ShowSightDetail.controller")
public class ShowSightDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//顯示單一景點詳情
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收參數
		request.setCharacterEncoding("UTF-8");
		String temp = request.getParameter("sightId");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		// 型態轉換
		int sightId = 0;
		if (temp != null && temp.trim().length() != 0) {
			try {
				sightId = Integer.parseInt(temp);
			} catch (NumberFormatException e) {				
				error.put("sightDetail", "景點ID必須是數字");
			}
		} else {
			error.put("sightDetail", "景點ID不得空白");
		}

		// 資料驗證-無
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/_02_TripAndJournal/ShowSightDetail.jsp").forward(request,
					response);
			return;
		}
		
		// 呼叫model
		SightService sightService = new SightService();
		SightVO sightVO = sightService.findByPrimaryKey(sightId);
		if (sightVO != null) {
			request.setAttribute("sightVO", sightVO);
			request.getRequestDispatcher("/_02_TripAndJournal/ShowSightDetail.jsp").forward(request, response);
		} else {
			error.put("sightDetail", "查無此景點");
		}

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
