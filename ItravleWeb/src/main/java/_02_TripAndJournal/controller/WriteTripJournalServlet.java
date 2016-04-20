package _02_TripAndJournal.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/_02_TripAndJournal/member/WriteTripJournal.controller")
@MultipartConfig 
public class WriteTripJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("tripOrder");
		String temp2 = request.getParameter("tripId");
		String temp3 = request.getParameter("journalId");
		String temp4 = request.getParameter("whichDay");
		String temp5 = request.getParameter("sightId");
		System.out.println(temp1);
		System.out.println(temp2);
		System.out.println(temp3);
		System.out.println(temp4);
		System.out.println(temp5);
		

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
