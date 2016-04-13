package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Time;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailVO;

@WebServlet("/_02_TripAndJournal/member/AddToTripDetailCart.controller")
public class AddToTripDetailCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		System.out.println("------------------AddToTripDetailCart------------------");
		String temp1 = request.getParameter("tripId");
		String temp2 = request.getParameter("tripOrder");
		String temp3 = request.getParameter("stayTime");
		String temp4 = request.getParameter("whichDay");
		String referenceType = request.getParameter("referenceType");
		String temp5 = request.getParameter("sightId");
		String notes = request.getParameter("notes");
		String temp6 = request.getParameter("sightBudget");
		System.out.println("tripId:" + temp1);
		System.out.println("tripOrder:" + temp2);
		System.out.println("stayTime:" + temp3);
		System.out.println("whichDay:" + temp4);
		System.out.println("referenceType:" + referenceType);
		System.out.println("sightId:" + temp5);
		System.out.println("notes:" + notes);
		System.out.println("sightBudget:" + temp6);
		System.out.println("------------------------");
		
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

		// 驗證HTML Form資料

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

		session = request.getSession(false);
		String sessionId = session.getId();
		System.out.println("sessionId:" + sessionId);
		List<TripDetailVO> tripDetailCart = null;

		if (session != null) {
			try {
				tripDetailCart = (LinkedList<TripDetailVO>) session.getAttribute("tripDetailCart");			
				if (tripDetailCart == null) {					
					// 建cart
					tripDetailCart = new LinkedList<TripDetailVO>();
					System.out.println("新建cart");
				}	
				// vo丟進去
				tripDetailCart.add(tripDetailVO);
				session.setAttribute("tripDetailCart", tripDetailCart);
				System.out.println("放進session");
				System.out.println("tripDetailCart===>"+tripDetailCart);
			} catch (ClassCastException e) {
				System.out.println("Object cast to List<TripDetailVO> ClassCastException");
				e.printStackTrace();
			}
		}
	}
	
	

}
