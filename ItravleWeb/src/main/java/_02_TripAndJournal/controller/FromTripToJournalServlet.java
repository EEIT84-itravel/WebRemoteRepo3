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
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalDetailService;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/member/FromTripToJournal.controller")
public class FromTripToJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//由舊行程匯入成新遊記,來自FromTripToJournal.jsp資料,顯示至WriteJournal.jsp

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		String temp1 = request.getParameter("tripId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換HTML Form資料
		int tripId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			tripId = Integer.parseInt(temp1);
		} else {
			error.put("tripId", "行程ID錯誤");
		}

		// 驗證HTML Form資料
		// 無

		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/FromTripToJournal.jsp")
					.forward(request, response);
			return;
		}

		// 呼叫Model
		TripService tripService = new TripService();
		TripVO tripVO = tripService.select(tripId);
		TripDetailService tripDetailService = new TripDetailService();
		List<TripDetailVO> tripDetailVOs = tripDetailService.select(tripId);
		

		JournalVO journalVO = new JournalVO();
		journalVO.setMemberId(tripVO.getMemberId());// 由tripVO取memberId
		journalVO.setJournalName(tripVO.getTripName());
		journalVO.setBeginTime(tripVO.getTripStartDate());
		journalVO.setEndTime(tripVO.getTripEndDate());
		journalVO.setRegionId(tripVO.getRegionId());
		journalVO.setJournalIntro(tripVO.getTripIntro());

		JournalService js = new JournalService();
		JournalVO result = js.insert(journalVO);
		JournalDetailService journalDetailService = new JournalDetailService();
 
		
		LinkedList<JournalDetailVO> journalDetailCart = new LinkedList<>();
		for (TripDetailVO tripDVO : tripDetailVOs) {			
			if (tripDVO.getWhichDay() == 1 && tripDVO.getReferenceType().equals("type_id01")) {			
				JournalDetailVO journalDetailVO = new JournalDetailVO();
				journalDetailVO.setJournalId(result.getJournalId());
				journalDetailVO.setSightId(tripDVO.getReferenceNo());
				journalDetailVO.setSightOrder(tripDVO.getTripOrder());
				journalDetailVO.setWhichDay(tripDVO.getWhichDay());
				journalDetailService.insert(journalDetailVO);
				journalDetailCart.add(journalDetailVO);			  
			}
		}
		//將資料贊時存到車子
		session.setAttribute("journalDetailCart", journalDetailCart);
		System.out.println(journalDetailCart);

		if (result == null) {
			error.put("journalName", "insert fail");
			request.getRequestDispatcher(
					"/_02_TripAndJournal/member/FromTripToJournal.jsp")
					.forward(request, response);
		} else {
			session.setAttribute("journalVO", result);
		}
		response.sendRedirect(path
				+ "/_02_TripAndJournal/member/WriteJournal.jsp");

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
