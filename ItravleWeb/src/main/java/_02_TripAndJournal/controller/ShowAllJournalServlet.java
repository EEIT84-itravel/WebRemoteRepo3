package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/ShowAllJournalServlet.controller")
public class ShowAllJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//顯示排序後遊記至遊記首頁
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收參數
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		String select = request.getParameter("select");
		
		List<JournalVO> journalVOs=null;
		JournalService journalService=new JournalService();
		if ("byWatchNum".equals(select)) {
			journalVOs = journalService.selectOrderByWatch();
		} else if ("byCollectNum".equals(select)) {
			journalVOs=journalService.searchByCollectNum();
		} else if ("byModifyTime".equals(select)) {
			journalVOs = journalService.selectOrderByModifyTime();
		}
		
		if (!journalVOs.isEmpty()) {
			request.setAttribute("selectJournalVOs", journalVOs);
			request.getRequestDispatcher(
					"/_02_TripAndJournal/JournalIndex.jsp").forward(request,
					response);
		} else {
			error.put("noneSearch", "查無遊記資料");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/JournalIndex.jsp").forward(
					request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
