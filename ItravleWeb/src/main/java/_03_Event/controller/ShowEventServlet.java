package _03_Event.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _03_Event.model.EventService;
import _03_Event.model.EventVO;


@WebServlet("/_03_Event/ShowEvent.controller")
public class ShowEventServlet extends HttpServlet {



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("eventId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int eventId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			eventId = Integer.parseInt(temp1);
		}
		// 驗證資料-無
		// 呼叫Model
				EventService es = new EventService();
				EventVO eventVO = es.selectOne(eventId);
				if(eventVO != null ) {					
					request.setAttribute("eventVO", eventVO);	
				    request.getRequestDispatcher("/_03_Event/Event.jsp").forward(request, response);
				}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
