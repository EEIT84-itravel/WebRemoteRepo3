package _06_BackEnd.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _03_Event.model.EventService;
import _03_Event.model.EventVO;

@WebServlet("/_06_BackEnd/backend/NewEvent.controller")
@MultipartConfig
public class NewEventServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		  String savePath = this.getServletContext().getRealPath("/WEB-INF/upload");
		              
		// 接收資料
		String eventTopic = request.getParameter("eventTopic");
		String eventContent = request.getParameter("eventContent");
		String temp1 = request.getParameter("eventStartDate");
		String temp2 = request.getParameter("eventEndDate");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		java.sql.Date eventStartDate = null;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				eventStartDate = Date.valueOf(temp1);
			} catch (IllegalArgumentException e) {
				error.put("tripStartDate", "日期格式錯誤");
			}
		}
		java.sql.Date eventEndDate = null;
		if (temp2 != null && temp2.trim().length() != 0) {
			try {
				eventEndDate = Date.valueOf(temp2);
			} catch (IllegalArgumentException e) {
				error.put("tripEndDate", "日期格式錯誤");
			}
		}

		// 驗證資料
		if (eventTopic == null || eventTopic.trim().length() == 0) {
			error.put("eventTopic", "請輸入活動名稱");
		}
		if (eventContent == null || eventContent.trim().length() == 0) {
			error.put("eventContent", "請輸入活動內容");
		}
		if (eventStartDate == null) {
			error.put("eventStartDate", "請輸入活動開始日期");
		}
		if (eventEndDate == null) {
			error.put("eventEndDate", "請輸入活動結束日期");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_06_BeckEnd/beckend/NewEvent.jsp")
					.forward(request, response);
			return;
		}
		// 呼叫model
		EventService es = new EventService();
		EventVO eventVO = new EventVO();

		eventVO.setEventTopic(eventTopic);
		eventVO.setEventContent(eventContent);
		eventVO.setEventStartDate(eventStartDate);
		eventVO.setEventEndDate(eventEndDate);
		eventVO.setSightId(3); // 先寫死
		// 寫入資料
		EventVO result = es.insert(eventVO);
		if (result == null) {
			error.put("eventTopic", "新增失敗");
			request.getRequestDispatcher("/_06_BeckEnd/beckend/NewEvent.jsp")
					.forward(request, response);
			return;
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("eventVO", result);
		}
		String path = request.getContextPath();
		response.sendRedirect(path + "/_03_Event/Event.jsp");
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
