package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailVO;


@WebServlet("/WriteTrip")
public class WriteTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//接收資料		
		String temp1 = request.getParameter("tripId");
		String temp2 = request.getParameter("tripOrder");
		String temp3 = request.getParameter("stayTime");
		String referenceType =request.getParameter("referenceType");
		String temp4 = request.getParameter("sightId");
		
		//型別轉換
		int tripId = Integer.parseInt(temp1);
		int tripOrder = Integer.parseInt(temp2);		
		java.sql.Time stayTime= Time.valueOf(temp3);
		int referenceNo = Integer.parseInt(temp4);
		
		TripDetailVO tripDetailVO = new TripDetailVO();
		tripDetailVO.setTripId(tripId);
		tripDetailVO.setTripOrder(tripOrder);
		tripDetailVO.setStayTime(stayTime);
		tripDetailVO.setReferenceType(referenceType);
		tripDetailVO.setReferenceNo(referenceNo);
		System.out.println(tripDetailVO);
		
		
	}

}
