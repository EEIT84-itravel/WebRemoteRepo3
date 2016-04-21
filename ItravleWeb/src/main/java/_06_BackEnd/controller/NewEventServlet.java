package _06_BackEnd.controller;

import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.http.Part;

import _01_Sight.model.SightPicService;
import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;
import _03_Event.model.EventService;
import _03_Event.model.EventVO;

@WebServlet("/_06_BackEnd/backend/NewEvent.controller")
@MultipartConfig
public class NewEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		String temp = request.getParameter("eventId");
		String action = request.getParameter("action");
		int eventId = 0;
		if (temp != null && temp.trim().length() != 0) {
			try {
				eventId = Integer.parseInt(temp);
			} catch (IllegalArgumentException e) {
				error.put("eventId", "活動ID必須是數字");
			}
		}
		// 呼叫model
		EventService eventService = new EventService();
		EventVO eventVO;
		EventVO result;

		if ("getOne".equals(action)) {// 來自AllSight.jsp篩選一隻EventVO為了update
			eventVO = eventService.selectOne(eventId);
			request.setAttribute("eventVO", eventVO);

			request.getRequestDispatcher("/_06_BackEnd/backend/UpdateEvent.jsp")
					.forward(request, response);
		}
		if ("update".equals(action)) { // 來自UpdateEvent.jsp 接收修改後資料
			String eventTopic = request.getParameter("eventTopic");// 活動名稱
			if (eventTopic == null || eventTopic.trim().length() == 0) {
				error.put("eventTopic", "請輸入活動名稱");
			}
			String eventContent = request.getParameter("eventContent");// 活動內容
			if (eventContent == null || eventContent.trim().length() == 0) {
				error.put("eventContent", "請輸入活動內容");
			}
			String temp1 = request.getParameter("eventStartDate");// 活動開始日期
			java.sql.Date eventStartDate = null;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					eventStartDate = Date.valueOf(temp1);
				} catch (IllegalArgumentException e) {
					error.put("eventStartDate", "日期格式錯誤");
				}
			} else {
				error.put("eventStartDate", "請輸入活動開始日期");
			}
			String temp2 = request.getParameter("eventEndDate");// 活動結束日期
			java.sql.Date eventEndDate = null;
			if (temp2 != null && temp2.trim().length() != 0) {
				try {
					eventEndDate = Date.valueOf(temp2);
				} catch (IllegalArgumentException e) {
					error.put("eventEndDate", "日期格式錯誤");
				}
			} else {
				error.put("eventEndDate", "請輸入活動結束日期");
			}
			String temp3 = request.getParameter("eventRemoved");// 是否下架 true=下架:false=上架
			boolean eventRemoved = false;
			if (temp3 != null && temp3.trim().length() != 0) {
				if (temp3.equals("true")) {
					eventRemoved = true;
				} else {
					eventRemoved = false;
				}
			}
			String temp4 = request.getParameter("sightId");// 對應景點ID
			int sightId = 0;
			if (temp4 != null && temp4.trim().length() != 0) {
				try {
					sightId = Integer.parseInt(temp4);
				} catch (IllegalArgumentException e) {
					error.put("sightId", "景點ID必須是數字");
				}
			}
			Part filePart = request.getPart("eventPhoto"); // Retrieves <input type="file" name="eventPhoto">
			InputStream is = filePart.getInputStream();

			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/UpdateEvent.jsp").forward(
						request, response);
				return;
			}

			// 呼叫model
			eventVO = eventService.selectOne(eventId);
			eventVO.setSightId(sightId);
			eventVO.setEventTopic(eventTopic);
			eventVO.setEventContent(eventContent);
			eventVO.setEventStartDate(eventStartDate);
			eventVO.setEventEndDate(eventEndDate);
			eventVO.setEventRemoved(eventRemoved);
			byte[] p = new byte[is.available()];
			if (p.length != 0) {
				is.read(p);
				is.close();
				eventVO.setEventPhoto(p);
			} else {
				byte[] bytes = eventVO.getEventPhoto();
				eventVO.setEventPhoto(bytes);
			}
			result = eventService.update(eventVO);
			
			if (result != null) {
				String path = request.getContextPath();
				response.sendRedirect(path
						+ "/_06_BackEnd/backend/AllSight.jsp#tabs-3");
			}
		}
		if ("insert".equals(action)) { // 來自NewEvent.jsp 接收新增資料
			String eventTopic = request.getParameter("eventTopic");// 活動名稱
			if (eventTopic == null || eventTopic.trim().length() == 0) {
				error.put("eventTopic", "請輸入活動名稱");
			}
			String eventContent = request.getParameter("eventContent");// 活動內容
			if (eventContent == null || eventContent.trim().length() == 0) {
				error.put("eventContent", "請輸入活動內容");
			}
			String temp1 = request.getParameter("eventStartDate");// 活動開始日期
			java.sql.Date eventStartDate = null;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					eventStartDate = Date.valueOf(temp1);
				} catch (IllegalArgumentException e) {
					error.put("eventStartDate", "日期格式錯誤");
				}
			} else {
				error.put("eventStartDate", "請輸入活動開始日期");
			}
			String temp2 = request.getParameter("eventEndDate");// 活動結束日期
			java.sql.Date eventEndDate = null;
			if (temp2 != null && temp2.trim().length() != 0) {
				try {
					eventEndDate = Date.valueOf(temp2);
				} catch (IllegalArgumentException e) {
					error.put("eventEndDate", "日期格式錯誤");
				}
			} else {
				error.put("eventEndDate", "請輸入活動結束日期");
			}
			String temp3 = request.getParameter("eventRemoved");// 是否下架 true=下架:false=上架
			boolean eventRemoved = false;
			if (temp3 != null && temp3.trim().length() != 0) {
				if (temp3.equals("true")) {
					eventRemoved = true;
				} else {
					eventRemoved = false;
				}
			}
			String temp4 = request.getParameter("sightId");// 對應景點ID
			int sightId = 0;
			if (temp4 != null && temp4.trim().length() != 0) {
				try {
					sightId = Integer.parseInt(temp4);
				} catch (IllegalArgumentException e) {
					error.put("sightId", "景點ID必須是數字");
				}
			}else{
				error.put("sightId", "請選擇相關景點");
			}
			Part filePart = request.getPart("eventPhoto"); // Retrieves <input type="file" name="eventPhoto">
			InputStream is = filePart.getInputStream();

			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/NewEvent.jsp").forward(
						request, response);
				return;
			}

			// 呼叫model
			eventVO = new EventVO();
			eventVO.setSightId(sightId);
			eventVO.setEventTopic(eventTopic);
			eventVO.setEventContent(eventContent);
			eventVO.setEventStartDate(eventStartDate);
			eventVO.setEventEndDate(eventEndDate);
			eventVO.setEventRemoved(eventRemoved);
			byte[] p = new byte[is.available()];
				is.read(p);
				is.close();
				eventVO.setEventPhoto(p);
			result = eventService.insert(eventVO);
			
			if (result != null) {
				String path = request.getContextPath();
				response.sendRedirect(path
						+ "/_06_BackEnd/backend/AllSight.jsp#tabs-3");
			}
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
