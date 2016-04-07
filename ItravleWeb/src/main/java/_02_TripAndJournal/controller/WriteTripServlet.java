package _02_TripAndJournal.controller;

import java.io.IOException;

import java.sql.Time;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;

//本servlet檔名取錯，報廢中
@WebServlet("/_02_TripAndJournal/member/WriteTrip.controller")
public class WriteTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {	
		
		// 接收HTML Form資料
		String temp1 = request.getParameter("tripId");		
		String temp2 = request.getParameter("tripOrder");
		String temp3 = request.getParameter("stayTime");
		String temp4 = request.getParameter("whichDay");
		String referenceType = request.getParameter("referenceType");
		String temp5 = request.getParameter("sightId");
		String notes = request.getParameter("notes");
		String temp6 = request.getParameter("sightBudget");
		
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換HTML Form資料
		int tripId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				tripId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {				
				e.printStackTrace();
			}			
		}
		int tripOrder = 0;
		if (temp2 != null && temp2.trim().length() != 0) {
			try {
				tripOrder = Integer.parseInt(temp2);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		java.sql.Time stayTime = null;
		if (temp3 != null && temp3.trim().length() != 0) {
			try {
				stayTime = Time.valueOf(temp3);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		int whichDay = 0;
		if (temp4 != null && temp4.trim().length() != 0) {
			try {
				whichDay = Integer.parseInt(temp4);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		int referenceNo = 0;
		if (temp5 != null && temp5.trim().length() != 0) {
			try {
				referenceNo = Integer.parseInt(temp5);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		java.math.BigDecimal sightBudget = null;
		if (temp6 != null && temp6.trim().length() != 0) {
			double temp7 = Double.parseDouble(temp6);
			sightBudget = java.math.BigDecimal.valueOf(temp7);
		}
		
		// 驗證HTML Form資料：不用驗證，因為form都是hidden
		
		// 呼叫Model
		TripDetailVO tripDetailVO = new TripDetailVO();
		tripDetailVO.setTripId(tripId);
		tripDetailVO.setTripOrder(tripOrder);
		tripDetailVO.setStayTime(stayTime);
		tripDetailVO.setWhichDay(whichDay);
		tripDetailVO.setReferenceType(referenceType);
		tripDetailVO.setReferenceNo(referenceNo);
		tripDetailVO.setNotes(notes);
		tripDetailVO.setSightBudget(sightBudget);
		System.out.println(tripDetailVO);
		
		TripDetailService service = new TripDetailService();
		TripDetailVO result = service.insert(tripDetailVO);
		
		if (result == null) {
			error.put("fail", "insert fail");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/NewTrip.jsp").forward(request,
					response);
		} else {
			HttpSession session = request.getSession();
			//應該要塞到shoppingCart裡面才對?
			session.setAttribute("tripDetailVO", result);
		}
		//送回編輯行程頁面
		String path = request.getContextPath();
		response.sendRedirect(path + "/_02_TripAndJournal/member/WriteTrip.jsp");

	}

}
