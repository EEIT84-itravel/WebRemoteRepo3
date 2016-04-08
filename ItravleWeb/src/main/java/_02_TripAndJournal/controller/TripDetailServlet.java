package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;

@WebServlet("/_02_TripAndJournal/member/TripDetail.controller")
public class TripDetailServlet extends HttpServlet {
	//把每筆tripDetail存到session
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	HttpSession session;
	List<TripDetailVO> tripDetailCart;

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
		System.out.println("tripId:"+temp1);
		System.out.println("tripOrder:"+temp2);
		System.out.println("stayTime:"+temp3);
		System.out.println("whichDay:"+temp4);
		System.out.println("sightId:"+temp5);
		System.out.println("sightBudget:"+temp6);
		System.out.println("referenceType:"+referenceType);
		System.out.println("notes:"+notes);
		
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
		if (session != null) {
			if (tripDetailCart != null) {
				tripDetailCart.add(tripDetailVO);
				System.out.println(tripDetailCart);
				session.setAttribute("tripDetailCart", tripDetailCart);
				System.out.println("tripDetailCart!=null");
			} else {
				// 建cart
				tripDetailCart = new ArrayList<TripDetailVO>();
				System.out.println("新建cart");
				// vo丟進去
				tripDetailCart.add(tripDetailVO);
				session.setAttribute("tripDetailCart", tripDetailCart);
				System.out.println("放進session");
			}
		} else {
			// 請使用者登入
			System.out.println("導向登入頁面(未完成)");
		}
		
				
//		if (result == null) {
//			error.put("fail", "insert fail");
//			request.getRequestDispatcher("/_02_TripAndJournal/member/NewTrip.jsp")
//			.forward(request,response);
//		} else {
//			session = request.getSession();
//			session.getAttribute("tripDetailCart");
//			//應該要塞到shoppingCart裡面才對?
//			session.setAttribute("tripDetailVO", result);
//		}
		//送回編輯行程頁面
		String path = request.getContextPath();
		response.sendRedirect(path + "/_02_TripAndJournal/member/WriteTrip.jsp");		

	}

}
