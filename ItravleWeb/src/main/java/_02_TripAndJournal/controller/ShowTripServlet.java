package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/ShowTrip.controller")
public class ShowTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		String temp1 = request.getParameter("tripId");
		System.out.println(temp1);

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 驗證資料
		int tripId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				tripId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 轉換資料

		// 呼叫model
		TripService tripService = new TripService();
		TripVO tripVO = tripService.select(tripId);
		System.out.println(tripVO);
		request.setAttribute("tripVO", tripVO);
		TripDetailService tripDetailService = new TripDetailService();
		List<TripDetailVO> result = tripDetailService.select(tripId);
		List<TripDetailVO> tripDetailVOs = new LinkedList<TripDetailVO>();
		//取出"景點"性質的tripDetailVO
		for(TripDetailVO tripDetailVO: result){
			if(tripDetailVO.getReferenceType().equals("type_id01")){
				tripDetailVOs.add(tripDetailVO);
			}
		}
		request.setAttribute("tripDetailVOs", tripDetailVOs);

		// 根據結果選擇veiw
		request.getRequestDispatcher("/_02_TripAndJournal/Trip.jsp").forward(request, response);

		
	}

}
