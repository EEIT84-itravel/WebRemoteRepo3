package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _05_Member.model.CollectionService;
import _05_Member.model.CollectionVO;
import _05_Member.model.MemberVO;

@WebServlet("/_02_TripAndJournal/member/collectiontrip.controller")
public class CollectionTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 接收HTML Form資料
		HttpSession session = request.getSession();
		Integer memberId = ((MemberVO) session.getAttribute("user"))
				.getMemberId();
		String temp1 = request.getParameter("tripId");

		// 轉換HTML Form資料

		// 驗證HTML Form資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		int tripId = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			tripId = Integer.parseInt(temp1);
		}
		// 呼叫Model(首頁畫面)
				CollectionVO collectionVO = new CollectionVO();
				CollectionService collectionService = new CollectionService();
				collectionVO.setMemberId(memberId);
				collectionVO.setTypeId("type_id02");// 行程
				collectionVO.setReferenceType(tripId);
				collectionService.collectiontrip(collectionVO);
				// 根據Model執行結果顯示View
				String path=request.getContextPath();
				response.sendRedirect(path+"/_02_TripAndJournal/ShowTrip.controller?tripId="+tripId);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
